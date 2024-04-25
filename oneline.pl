#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $PDIR, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $opt_D, $opt_d, $opt_e, %W, %F);
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
    getopts('uf:L:IODde:');
    my($e, $res, $bit);
    my(@BITS);
    use open qw(:utf8 :std);
    my $etag = $opt_e;
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	$_ = restructure::delabel($_);
	if ($etag =~ m|^ *$|)
	{
	    if (m|<(SuperEntry)|)
	    {
		$etag = $1;
	    }
	    elsif (m|<(entryGroup)|)
	    {
		$etag = $1;
	    }
	    elsif (m|<(morphEntry)|)
	    {
		$etag = $1;
	    }	    
	    elsif (m|<(entry)|)
	    {
		$etag = $1;
	    }
	    elsif (m|<(e)[ >]|)
	    {
		$etag = $1;
	    }
	}
	s|^ *||;
	s| *$||;
	s|\t| |g;
	s| +| |g;
	s|(</dps-data>)|\n\1|gi;
	s|(<$etag[ >])|\n\1|gi;
	$_ = sprintf("%s ", $_);
	$_ =~ s|</$etag> *|</$etag>|g;
	printf("%s", $_); 
    }
}
