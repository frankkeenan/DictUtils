#!/usr/local/bin/perl

$prev="";

line:

while (<>)

    {

    next line unless (/<hm[ >]/i);
#    next line if (/<entry([^>]*)><!--1e: bord="yes"-->/i);
#    next line if (/<entry([^>]*)><hsrch>([^<]*)<\/hsrch><!--1e: bord="yes"-->/i);

    s|<h>|<h >|gi;
    m|<h .*?>(.*?)</h>|i;
    $head=$1;
    $head =~ s|&[psw];||g;
    $head =~ s|<.*?>||g;

    s|<hm>|<hm >|gi;
    m|<hm .*?>(.*?)</hm|i;
    $hm=$1;

    $current= "$head";
    $hm =~ s|^0||g;

    unless ($current eq $prev)
	{
	if ($count eq "1")
	    {
	    print "\t\tERROR ABOVE - ONLY ONE HM\n";
	    }
	$prev=$current;
	$count="";
	}
    $count++;
    unless ($hm eq $count)
	{
	$_ =~ s|.+|$&\tUNEXPECTED HOMONYM NUMBER|g;
	} 
    print "$current\t$hm\n";
    }
