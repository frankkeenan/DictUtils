#!/usr/local/bin/perl
# $Id$
# $Log$
#
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
use Cwd;
our ($LOG, $LOAD, $opt_a, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $PDIR, %W, %USED, %F, %INFO, $p);
#$PDIR = ".";
$PDIR = "/usr/local/bin/";

require "$PDIR/utils.pl";
require "$PDIR/restructure.pl";

# find all the text files below the current directory

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator

&main;

sub main
{
#    getopts('a:bz:');
#    stores value of arguments in $opt_a and $opt_z and BOOLEAN $opt_b
#
    my $pwd = getcwd;
    my $fname;
    my $tc = sprintf("perl /usr/local/bin/tc.pl"); 
    my $dictDir = "/home/keenanf/DICTS";
    chdir $dictDir;
    open(FIND, "find . -type f -print|");
 FILE: 
    while ($fname = <FIND>) 
    {
	chomp $fname;       # strip record separator
	# format will be ./1/10/10p/10p#_gb_1.mp3
	if ($fname =~ m|/dps.*xml *$|)
	{
	    my $fullf =  $fname;
	    $fullf =~ s|^\./?|$dictDir/|;
	    my $tcf = sprintf("%s.tc", $fullf);
	    my $comm = sprintf("%s %s > %s", $tc, $fullf, $tcf); 
	    printf("%s\n", $comm);
	}

    }
    chdir $pwd;
}

