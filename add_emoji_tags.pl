#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_d, $opt_D, $opt_I, $opt_O, %W, %USED, %F, %INFO, %CT, $p);
our $PDIR = $ENV{DICT_UTILS};
if ($PDIR =~ m|^ *$|)
{
    printf(STDERR "Need to set ENV for DICT_UTILS\n\n"); 
}
#$PDIR = ".";

require "$PDIR/utils.pl";
require "$PDIR/restructure.pl";

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
    my $caps = "\x{0040}-\x{005A}";
    my $vietnamese = "\x{1EA1}-\x{1EF9}";
    my $accented = "\x{00C0}-\x{01BF}";
    my $letters = "\x{0040}-\x{005A}\x{0061}-\x{007A}";
    my $emojis = "\x{1F300}-\x{1FaF7}\x{2600}-\x{27C0}";
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){printf(bugin_fp "%s\n", $_);}	
	# Match the hex caps &#x00C0;-&#x017E;
#	s|([^a-zA-Z0-9£\'\x{00C0}-\x{017E}])sb([^a-zA-Z0-9£\'\x{00C0}-\x{017E}])|$1<FK>SOMEBODY</FK>$2|g;
#	s|([$letters]+)|<letters>$1</letters>|g;
	s|([$emojis]+)|<emojis>$1</emojis>|g;
#	s|([$caps]+)|<caps>$1</caps>|g;
	print $_;
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
    while (<in_fp>){
	chomp;
	s|||g;
	# my ($eid, $info) = split(/\t/);
	# $INFO{$eid} = $info;
	# $W{$_} = 1;
    }
    close(in_fp);
} 
