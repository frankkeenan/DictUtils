#!/usr/local/bin/perl5
use Getopt::Std;

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator

&main;

sub main
{
#    getopts('a:bz:');
#    stores value of arguments in $opt_a and $opt_z and BOOLEAN $opt_b
#
  line:    
    while (<>) 
    {
	chomp;       # strip record separator

	s|<h>|<h >|i;
	if (m|<h ([^>]*)>(.*?)</h>|io)
	{
	    $h = $2;
	    $h =~ s|&[wsp];||gio;
	}
	s|&|<split>&|gio;

	@BITS = split(/<split>/); 

      floop:
	foreach $bit (@BITS) 
	{
	    if ($bit =~ /(&.*?;)/)
	    {
		$ent = $1;
		next floop if ($USED{$ent});
		$USED{$ent} = $h;				
	    }
	}
    }

    foreach $ent (sort keys %USED) 
    {
	printf("%s\t%s\n", $ent, $USED{$ent}); 
    }
}
