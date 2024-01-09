#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_a, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $PDIR, %W, %USED, %F, %INFO, $p);
#$PDIR = ".";
$PDIR = "/usr/local/bin/";

require "$PDIR/utils.pl";
require "$PDIR/restructure.pl";

# require "/data_new/VocabHub/progs/VocabHub.pm";
#require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
$LOG = 1;
$LOAD = 1;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IOD');
    &usage if ($opt_u);
    my($e, $res, $bit);
    my(@BITS);
#   $opt_L = ""; # name of file for the log_fp output to go to
    &open_debug_files;
    use open qw(:utf8 :std);
    if ($opt_D)
    {
	binmode DB::OUT,":utf8";
    }
    if ($LOAD){&load_file($opt_f);}
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){printf(bugin_fp "%s\n", $_);}	
	$p = 0;
	# s|<!--.*?-->||gio;
#	next line if (m|<entry[^>]*sup=\"y|io);
	unless (m|<e |){print $_; next line;}
	# my $h = &get_hex_h($_, "hex", 1); # the 1 says to remove stress etc
	my $EntryId = &get_tag_attval($_, "e", "e:id");
	if ($W{$EntryId})
	{
	    $p = 1;
	}
	if ($p)
	{
	    s| e:[^ =]*=\".*?\"||gi;
	    s| xmlns[^ =]*=\".*?\"||gi;
	    printf("%s\n\n", $_); 
	}
	if ($opt_O){printf(bugout_fp "%s\n", $_);}
    }
    &close_debug_files;
}

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
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
  wloop:
    while (<in_fp>){
	chomp;
	s|||g;
	# my ($eid, $info) = split(/\t/);
	# $INFO{$eid} = $info;
	next wloop unless (m| e:version|);
	my $version = restructure::get_tag_attval($_, "e", "e:version"); 
	next wloop if ($version eq "1.0");
	my $EntryId = &get_tag_attval($_, "e", "e:id");
	$W{$EntryId} = 1;
	printf(log_fp "%s\n", $EntryId); 
  }
    close(in_fp);
} 
