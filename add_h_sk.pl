#!/usr/local/bin/perl
#
# Input = 
# Result = 
# 
#
#
use Getopt::Std;
require "/disk1/home/keenanf/perl/utils.pl";

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    printf(STDERR "\t-u:\tDisplay usage\n"); 
#    printf(STDERR "\t-x:\t\n"); 
    exit;
}

&main;

sub main
{
    getopts('u');
#    getopts('a:bz:');
#    stores value of arguments in $opt_a and $opt_z and BOOLEAN $opt_b
#
    if ($opt_u)
    {
	&usage;
    }
  line:    
    while (<>) 
    {
	next line unless (/<entry/i);

	chomp;       # strip record separator
	if (m|(<h[ >].*?)</h>|io)
	{
	    $h = $1;
	    $h =~ s|<.*?>||gio;
	    $h =~ s|</?z_core_h>||gio;
	    $h =~ s|</?wb>||gio;
	    $h =~ s|&#x0026;|and|gio;
	    $h =~ s|,.*||gio;
	    $h =~ s|&\#x02C[C8];||gio;
	    $h =~ s|&.*?;||gio;
	    $h =~ s|[^a-z0-9]||gio;
	    $h =~ tr|A-Z|a-z|;
	}
	printf("%s#%s\n", $h, $_);
    }
}
