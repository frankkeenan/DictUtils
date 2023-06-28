#!/usr/bin/perl
use Getopt::Std;

require "/disk1/home/keenanf/perl/utils.pl";

$, = "";			# set output field separator
$\ = "\n";			# set output record separator
## undef $/;			# read in the whole file at once


getopts('e:t:c:i:v:w:r:dDLpPTh8');

&print_usage(0) if ($opt_h);
&print_usage(1) if ($opt_c and $opt_i);
&print_usage(1) if ($opt_v and $opt_w);
&print_usage(1) if ($opt_p and $opt_P);
&print_usage(1) if ($opt_t and $opt_T);

if ($opt_8) {
    binmode(STDIN, ":utf8");
    binmode(STDOUT, ":utf8");
}

unless ($opt_t)
{
    $opt_t = "/data/dicts/dps_entry_editor_master_config/Projects/PEU_DIAG_TESTS/peu_diag_tests.dtd";
}
$DEFAULT_DTD = "/data/dicts/dps_entry_editor_master_config/Projects/PEU_DIAG_TESTS/peu_diag_tests.dtd";
$dtd = $DEFAULT_DTD if $opt_T;
$dtd ||= $opt_t;

$htag = ($opt_e or "h");
$idex = ($opt_L ? qr/e:id/io : qr/(?:eid|id)/io);

($wheat = $ARGV[0]) =~ s!(?:\.xml|)$!$1\_wheat.xml!io 
    unless ($wheat = ($opt_w or $opt_v));

open(WHEAT, ">$wheat") || die "Unable to write to $wheat";
binmode(WHEAT, ":utf8") if ($opt_8);

($chaff = $ARGV[0]) =~ s!(?:\.xml|)$!$1\_chaff.xml!io 
    unless ($chaff = ($opt_c or $opt_i));

open(CHAFF, ">$chaff") || die "Unable to write to $chaff";
binmode(CHAFF, ":utf8") if ($opt_8);


### `main' routine ###

&proc_file;

### end `main' routine ###


close(WHEAT);
close(CHAFF);


sub proc_file {

    my(@header,$header,$footer,$lint,$ofp,$pr_full,$h);

  header:
    while (<>) {

	chomp;
	s|||g;

	last header if m|<entry[ >]|io;
	push @header, $_;
    }

    $header = join "\n", @header;
    $header =~ s|<!DOCTYPE [^>]*>||i;
    if ($header =~ m|\bDOCTYPE\s+(\w+)|io) {

	$footer = "</$1>";
	$pr_full = !$opt_P;

#	$dtd ||= $1 if ($header =~ m|\bSYSTEM\s+"([^"]*)"|io);

    } else {

	$opt_r ||= "dps-data";
	$pr_full = !$opt_p;
    }

    $dtd ||= $DEFAULT_DTD;
    ($sys_dtd = $dtd) =~ s|.*/||io;

    if ($opt_r) {
	$header = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<!DOCTYPE $opt_r SYSTEM \"$sys_dtd\">\n<$opt_r>";
	$footer = "</$opt_r>";
    }

    if ($pr_full) {

	print WHEAT $header;
	print CHAFF $header;
    }

    $lint = "xmllint --noout --nowarning --dtdvalid $dtd - > /dev/null 2>&1 <<END_DOC";

  line:
    while ($_) {

	if (m|<entry[ >]|io and (not m|^[^>]+ del="y|io or $opt_D)) {

	    if ($opt_d) {
		print STDERR "Cmd:\n$lint\n";
		print STDERR "Data:\n$header$_$footer\nEND_DOC\n";
	    }

	    if (system "$lint\n$header$_$footer\nEND_DOC\n") {

		if (m|<$htag([ >].*?)</$htag>|io) {
		    $h = &get_hdwd("<h$1</h>");
		    $h .= (m| hm="([0-9]+)"|io ? " ($1)" : "");
		} else {
		    $h = "???";
		}

		$h .= (m|^[^>]* $idex="([^"]*)"|io ? " [$1]" : " []");

	      err:
		for $err ($? >> 8) {

		    if ($err == 1) {
#			print STDERR "$h: Parsing error ($err)";
			last err;
		    }

		    if ($err == 2) {
			print STDERR "$h: DTD error ($err)";
			last err;
		    }

		    if ($err == 3 or $err == 4) {
#			print STDERR "$h: Validation error ($err)";
			last err;
		    }

		    if ($err == 130) {
			print STDERR "\nProgram terminated by keyboard interrupt";
			exit $err;
		    }

		    print STDERR "$h: Odd error ($err)";
		}

		print CHAFF;

	    } else {

		print WHEAT;
	    }
	    chomp;
	    s|||g;

	}

	if (defined ($_ = <>)) {

	    chomp;
	    s|||g;
	}
    }

    if ($pr_full) {

	print WHEAT $footer;
	print CHAFF $footer;
    }
}


sub print_usage {

    my $status = shift();

    ($cmd = $0) =~ s|^.*/||o;

    print STDERR "\nUSAGE:   $cmd [-t <filename> | -T] [-r <elemname>] [-v|w <filename>] [-i|c <filename>] [-DLpP] [-dh8]";
    print STDERR <<DONE;

         -c:   output invalid entries to file <filename>.
         -d:   debug mode: output command and data for each system call.
         -D:   include entries marked del="y".
         -e:   specify <elemname> as element containing entry headword.
         -h:   display usage (i.e. this info).
         -i:   output invalid entries to file <filename>.
         -L:   use long (IDM) element ids instead of short (PSG) ones.
         -p:   output document prolog and root element tags.
         -P:   suppress output of document prolog and root element tags.
         -r:   specify <elemname> as root element.
         -t:   use dtd in file <filename>.
         -T:   use default dtd.
         -v:   output valid entries to file <filename>.
         -w:   output valid entries to file <filename>.
         -8:   set character coding to UTF8.
DONE
    exit $status;
}
