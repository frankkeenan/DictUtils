use Getopt::Std;

require "/disk1/home/keenanf/perl/utils.pl";
require "/disk1/home/hughsoni/perl/lib/std.pl";
require "/disk1/home/hughsoni/Translations/scripts/trans_funcs.pl";


$, = "\t";
$\ = "\n";
## undef $/;			# read in the whole file at once


getopts('f:hl8');

&print_usage(0) if ($opt_h);

if ($opt_8) {
    binmode(STDIN, ":utf8");
    binmode(STDOUT, ":utf8");
}

&open_log() if $opt_l;


if ($opt_f) {
    &write_log("Load from file ${opt_f}: Starting") if $opt_l;
    &loadf($opt_f);
    &write_log("\nLoad from file ${opt_f}: Finished") if $opt_l;
    # } else {
    # &print_usage(1);
}



if ($opt_l) {
    &write_log("Main processing: Starting\n");
}


$IELTPL = '<Indexer><seo#SAMPLE#>#SEO#</seo><browse>#BROWSE#</browse><autocompletes>#ACS#</autocompletes><indexing>#ARLS#</indexing></Indexer>';

$ACTPL = '<autocomp>#AC#</autocomp>';

$ARLTPL = '<arl type="#TYPE#"><index>#INDEX#</index><display>#DISPLAY#</display></arl>';


%ARLTYPE = (
    h => "headword",
    infl => "inflection",
    v => "variant",
    dr => "derivative",
    pv => "phrasal_verb",
    idm => "idiom",
    cpd => "derivative",
    cfe => "idiom",
    v_alt => "variant",
    v_adv => "variant",
);


### `main' routine ###

&proc();

### end `main' routine ###


if ($opt_l) {
    &write_log("\nMain processing: Finished");
    &close_log();
}


sub loadf {

    my($f) = @_;
    my($record);
    
    open(ifp, $f) || die "Unable to read ${f}"; 
    binmode(ifp, ":utf8") if ($opt_8);

  record:
    while (<ifp>) {

	++$record;
	&write_log("Record ${record}: Starting") if $opt_l;

	chomp;
	s|||g;

	&zap_comments();

	&load_record();

	&write_log("Record ${record}: Finished") if $opt_l;
    }

    close(ifp);
}


sub load_record {

}



sub proc {

    my($line);
    
  line:
    while (<>) {

	++$line;
	&write_log("Line ${line}: Starting") if $opt_l;

	chomp;
	s|||g;

	unless (m|<entry[ >]|io and not m|^[^>]+ del="y|io) {
	    print;
	    next line;
	}
	# &zap_comments();
	&hide_comments();

	&proc_entry();

	&restore_comments();
	print;

	&write_log("Line ${line}: Finished") if $opt_l;
    }
}


sub proc_entry {

    my($cp,$hdwd,$pos,$sample,$iel,%seen);
    our($bftype,@acs,@arls,$bf0,$bf1,$ac,$arl);

    $hdwd = (m|(<h[ >].*?</h>)|io ? &norm_ac($1) : "");

    @acs = @arls = ();

    for ($ac = $ACTPL) {
	s|#AC#|$hdwd|;
    }

    push @acs, $ac;

    for ($cp = $_) {

	foreach $bftype (qw|dr pv idm cfe cpd|) {
	    &cic(sub {
		     my($eid);

		     m| eid="([^"]+)"|io;
		     $eid = $1;

		     while (s!(<(${bftype}|v)[ >].*?</\2>)!!i) {

			 $bf0 = &norm_ac($1);

			 for ($ac = $ACTPL) {
			     s|#AC#|$bf0|;
			 }

			 push @acs, $ac;

			 foreach $bf1 (&get_forms($bf0)) {

			     for ($arl = $ARLTPL) {
				 s|#TYPE#|$ARLTYPE{$bftype}|;
				 s|#INDEX#|$bf1|;
				 s|#DISPLAY#|$bf0|;
				 s|>| contextid="$eid">|;
			     }

			     push @arls, $arl;
			 }
		     }

		     $_ = "";
		 },
		 "${bftype}-g"
	     );
	}

	$pos = (m|>([^<>]+)</pos>|io ? $1 : "");
	$browse = $hdwd;
	$browse .= " <pos>$pos</pos>" if $pos;

	foreach $bftype (qw|v infl v_alt v_adv|) {
	    while (s!(<(${bftype})[ >].*?</\2>)!!i) {

		$bf0 = &norm_ac($1);

		next if $bf0 eq $hdwd;

		foreach $bf1 (&get_forms($bf0)) {

		    for ($arl = $ARLTPL) {
			s|#TYPE#|$ARLTYPE{$bftype}|;
			s|#INDEX#|$bf1|;
			s|#DISPLAY#|$browse|;
		    }

		    unshift @arls, $arl;
		}
	    }
	}
    }

    $bf0 = &norm_arl1($hdwd);

    for ($arl = $ARLTPL) {
	s|#TYPE#|$ARLTYPE{"h"}|;
	s|#INDEX#|$bf0|;
	s|#DISPLAY#|$browse|;
    }

    unshift @arls, $arl;

    $bf1 = &norm_arl2($hdwd);

    if ($bf1 ne $bf0) {
	for ($arl = $ARLTPL) {
	    s|#TYPE#|$ARLTYPE{"h"}|;
	    s|#INDEX#|$bf1|;
	    s|#DISPLAY#|$browse|;
	}

	unshift @arls, $arl;
    }

    $hdwd = &norm_seo($bf1, $pos);
    $sample = (m|^<[^>]* is_sample="y|io ? " sample=\"y\"" : "");

    for ($iel = $IELTPL) {

	s|#SEO#|$hdwd|;
	s|#SAMPLE#|$sample|;
	s|#BROWSE#|$browse|;
	s|#ACS#|join "", grep {!$seen{$_} and $seen{$_} = 1} @acs|e;
	%seen = ();
	s|#ARLS#|join "", grep {!$seen{$_} and $seen{$_} = 1} @arls|e;
    }

    s|>|>$iel|;
}


sub norm_ac {

    my($ac) = @_;

    for ($ac) {

	s|<pnc[ >].*?</pnc>||gio;
	s|<[^>]+>||go;
	s|&iexcl;||gio;
	s|\!||gio;
	s|&trade;||gio;
	s|&tm;||gio;
	s|&copy;||gio;
	s|&reg;||gio;
	s|&#x00B7;||gio;
	s|&#x02C[8C];||gio;
    }

    return $ac;
}


sub norm_arl1 {

    my($arl) = @_;

    for ($arl) {

	tr|A-Z|a-z|;

	s|  +| |go;
    }

    return $arl;
}


sub norm_arl2 {

    my($arl) = @_;

    for ($arl) {

	$_ = &hex2letter($_);

	s|&(.)acute;|$1|gio;
	s|&(.)grave;|$1|gio;
	s|&(.)cedil;|$1|gio;
	s|&(.)circ;|$1|gio;
	s|&(.)uml;|$1|gio;
	s|&(.)tilde;|$1|gio;

	s|&amp;| & |gio;
	s|&apos;|'|gio;

	s|&[^;]+;||gio;

	tr|A-Z|a-z|;
	tr|a-z0-9 ||cd;

	s|  +| |go;
    }

    return $arl;
}


sub norm_seo {

    my($wd,$pos) = @_;
    my($hm,$dup);

    $hm = (m|^[^>]* hm="([0-9]+)"|io ? " $1" : "");
    $pos = " $pos" if $pos;
    $dup = (m|^[^>]* dup="([^"]+)"|io ? " $1" : "");

    for ($wd = "$wd$hm$pos$dup") {

	tr| \-|___|;
	s|$|"_" . $seen{$_}++|e;
    }

    return $wd;
}


sub get_forms {

    my($bf) = @_;
    my(@bfs,@nbfs,%dup);

    return (&norm_arl1($bf), &norm_arl2($bf)) unless $bf =~ m| |o;

    @bfs = &perm_punc($bf);
    map {&norm_space($_)} @bfs;

    push(@nbfs, &norm_arl1($_), &norm_arl2($_)) foreach @bfs;

    return grep {!$dup{$_}++} @nbfs;
}


sub print_usage {

    my $status = shift();

    ($cmd = $0) =~ s|^.*/||o;

    print STDERR <<DONE;

USAGE:   $cmd [-f <filename>] [-hl8] ...

         -f:   load file <filename>.
         -h:   display usage (i.e. this info).
         -l:   record operations in log file.
         -8:   set I/O mode to UTF8.
DONE
    exit $status unless $status eq "-";
}
