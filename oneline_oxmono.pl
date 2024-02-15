#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $PDIR, %W, %USED, %F, %INFO);
#$PDIR = ".";
$PDIR = "/usr/local/bin/";

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
	s|(<e )|\n\1|gi;
	$_ = sprintf("%s ", $_);
	$_ =~ s|</e> *|</e>|g;
	printf("%s", $_); 
    }
}
