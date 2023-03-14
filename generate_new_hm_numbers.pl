#!/usr/local/bin/perl

$lastentry="";
$lasthead="";
$lasthm=0;

while (<>)

{
    s|<hm[ >].*?</hm>||g;
    s|<h>|<h >|gi;
    m|<h (.*?)>(.*?)</h>|gi;
    $head=$2;
    $head =~ s|<.*?>||g;
    $head =~ s|&[psw];||g;

	&test_last_hm;
    $lastentry = $_;
}

$head="";
&test_last_hm;

#########################################

sub test_last_hm

{

	$lasthm++;

	if ($head eq $lasthead)
	{
		&print_lastentry;
	}
	else
	{
		if ($lasthm eq 1)
		{
			$lasthm="";
		}
		if ($lastentry)
		{
		    &print_lastentry;
		}
		$lasthead = $head;
		$lasthm="";
	}
}

#########################################

sub print_lastentry

{ 
    if ($lasthm)
	{
		$lastentry =~s |</h>|</h><hm>$lasthm</hm>|;
	}
    print "$lastentry";
}

#########################################
