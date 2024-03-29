#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_a, $opt_t, $opt_D, $opt_I, $opt_O, $opt_D, $opt_d, %W, %F, %CT, @ATTS);
if (1)
{
    require "/NEWdata/dicts/generic/progs/utils.pl";
    require "/NEWdata/dicts/generic/progs/restructure.pl";
}
else {
    require "./utils.pl";
    require "./restructure.pl";
}
# require "/data_new/VocabHub/progs/VocabHub.pm";
#require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
$LOG = 0;
$LOAD = 0;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IODda:');
    &usage if ($opt_u);
    &usage unless ($opt_a);
    my($e, $res, $bit);
    my(@BITS);
    #   $opt_L = ""; # name of file for the log_fp output to go to
    &open_debug_files;
    use open qw(:utf8 :std);
    binmode DB::OUT,":utf8" if ($opt_D);
    my $attname = $opt_a;
    my($bit, $res);
    @ATTS = split(/[ \|,]+/, $opt_a);
    $res = "";
    if ($LOAD){&load_file($opt_f);}
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){printf(bugin_fp "%s\n", $_);}
	# s|<!--.*?-->||gio;
	#	unless (m|<e |){print $_; next line;}
	# my $eid = &get_tag_attval($_, "e", "e:id");
	# s|£|&\#x00A3;|g;
        # $_ = restructure::delabel($_);	
	foreach my $attname (@ATTS){
	    unless ($attname =~ m/^ *$/){
		&store_values($_, $attname);
	    }
	}	
    }
    foreach my $val (sort keys %CT)
    {
	printf("%s\t%s\n", $val, $CT{$val}); 
    }
    &close_debug_files;
}

sub store_values
{
    my($e, $attname) = @_;
    my($res, $eid);	
    $attname =~ s| *$||;
    $attname =~ s|^ *||;
    $e =~ s|(<[^>]* $attname=\"(.*?)\"[^>]*>)|&split;&fk;$1&split;|gi;
    my @BITS = split(/&split;/, $e);
    $res = "";
    foreach my $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    my $tagname = restructure::get_tagname($bit);
	    my $attval = restructure::get_tag_attval($bit, $tagname, $attname); 
	    my $tag_att = sprintf("%s\t%s=\"%s\"", $tagname, $attname, $attval); 		    
	    $CT{$tag_att}++;
	}
    }
}



sub usage
{
    printf(STDERR "USAGE: $0 -a \"Attnames\" (separate by comma, space or pipe)\n");
    printf(STDERR "\t-u:\tDisplay usage\n"); 
    #    printf(STDERR "\t-x:\t\n"); 
    exit;
}


sub load_file
{
    my($f) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    binmode(in_fp, ":utf8");
    while (<in_fp>){
	chomp;
	s|||g;
	# my ($eid, $info) = split(/\t/);
	# $W{$_} = 1;
    }
    close(in_fp);
} 
