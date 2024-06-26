#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $opt_D, $opt_d, %W, %F);
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
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IODd');
    my($e, $res, $bit);
    my(@BITS);
    use open qw(:utf8 :std);
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	$_ = restructure::delabel($_);
	s|^ *||;
	s| *$||;
	s|\t| |g;
	s| +| |g;
	s|(</dps-data>)|\n\1|gi;
	s|(<entryGroup)|\n\1|gi;
	$_ = sprintf("%s ", $_);
	$_ =~ s|(</entryGroup>) *|\1\n|gi;
	printf("%s", $_); 
    }
}
