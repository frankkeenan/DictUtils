#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $opt_D, $opt_d, %W, %F);
my $PDIR = $ENV{DICT_UTILS};

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
    getopts('uf:L:IODd');
    &usage if ($opt_u);
    my($e, $res, $bit);
    my(@BITS);
#   $opt_L = ""; # name of file for the log_fp output to go to
    &open_debug_files;
    use open qw(:utf8 :std);
    binmode DB::OUT,":utf8" if ($opt_D);
    
    foreach my $f (@ARGV)
    {
	my $to_fix  = &check_requires($f);
	if ($to_fix)
	{
	    my $comm = sprintf("perl %s/fix_requires_inplace.pl \"%s\"", $PDIR, $f); 
	    print $comm;
	    system($comm);
	}
    }
#    if ($LOAD){&load_file($f);}
    
    
    exit;
}

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    printf(STDERR "\t-u:\tDisplay usage\n"); 
#    printf(STDERR "\t-x:\t\n"); 
    exit;
}


sub check_requires
{
    my($f) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    binmode(in_fp, ":utf8");
    $res = 0;
    while (<in_fp>){
	chomp;
	s|||g;
	if (m|^\s*require \"(.*)\"|)
	{
	    my $file = $1;
	    if ($file =~ m|/.*/|)
	    {
#		printf("\t\t[%s]\n", $file); 
		$res = 1;
		last;
	    }
	}
	# my ($eid, $info) = split(/\t/);
	# $W{$_} = 1;
    }
    close(in_fp);
    return $res;
} 
