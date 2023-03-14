#!/usr/local/bin/perl
use Getopt::Std;

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
require "/disk1/home/keenanf/perl/utils.pl";

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    printf(STDERR "\t-u:\tDisplay usage\n"); 
    printf(STDERR "\t-b base_dir:\tTop level folder where the dict is stored\n"); 
    printf(STDERR "\t-f fname:\tUse fname instead of combo.dat as the input\n"); 
    printf(STDERR "\t-c:\tForce a combine\n"); 
    printf(STDERR "\t-i:\tInDesign output\n"); 
    printf(STDERR "\t-x:\tXDCC/CDROM output\n"); 
    printf(STDERR "\t-w:\tFirefox proofer output\n"); 
    exit;
}

&main;

sub main
{
    getopts('b:df:cixwu');
    if ($opt_d)
    {
	$DBG = 1;
    }
#    getopts('a:bz:');
#    stores value of arguments in $opt_a and $opt_z and BOOLEAN $opt_b
#
    ### NEXT LINE SHOULD BE THE ONLY ONE THAT NEEDS TO CHANGE ###
    if ($opt_u)
    {
	&usage;
    }
    if ($opt_b)
    {
	$base_dir = $opt_b;
    }
    else
    {
	$base_dir = "/data/dicts/espkt4e";
    }
    $dir3b2 = sprintf("%s/Proofer", $base_dir);
    $progdir = sprintf("%s/progs", $base_dir);
    $gprogdir = "/data/dicts/generic/progs";    # generic programs
    $oneline = sprintf("perl %s/oneline.pl", $gprogdir);
    $sorter = sprintf("perl %s/sorter.pl", $gprogdir);
    $add_sortkey = sprintf("perl %s/add_h_sk.pl", $gprogdir);
    $dictname = $base_dir;
    $dictname =~ s|/ *$||;
    $dictname =~ s|^.*/||;
    $punc_prog = sprintf("perl %s/punc_%s.pl", $progdir, $dictname);
    $do_lint = 1;
    if ($opt_f)
    {
	$combo_file = $opt_f;
    }
    else
    {
	$combo_file = sprintf("%s/combo.dat", $base_dir);
    }
    $resfile = $combo_file;
    unless ($resfile =~ m|\.|)
    {
	$resfile .= ".dat";
    }
    $flags = "";
    if ($opt_i)
    {
	# InDesign
	$tweak = sprintf("perl %s/tweak_indesign.pl", $progdir);
	$resfile =~ s|\.[^\.]*$|_indesign\.xml|io;
    }
    elsif (($opt_x) || ($opt_w))
    {
	# XDCC
	$tweak = sprintf("perl %s/tweak_cdrom.pl", $progdir);
	$resfile =~ s|\.[^\.]*$|_cdrom\.xml|io;
	$flags = "-c"
    }
    else
    {
	# 3B2
	$tweak = sprintf("perl %s/tweak_3b2.pl", $progdir);
	$resfile =~ s|\.[^\.]*$|_3b2\.xml|io;
	$resfile =~ s|^.*/||g;
	$resfile = sprintf("%s/%s", $dir3b2, $resfile);
	$do_lint = 0;
    }

    # CREATE COMBO.DAT IF CURRENT ONE OLDER THAN ONE DAY OR -c FLAG
    $combo_age = -M $combo_file;
    if (($combo_age > 1) || ($opt_c))
    {
	$comm = sprintf("perl %s/combine.pl -b \"$base_dir\"", $gprogdir);
	printf("%s\n", $comm); 
	unless ($DBG)
	{
	    system($comm);
	}
    }
    
    $comm = sprintf("$oneline %s | $sorter | $punc_prog -x $flags | $tweak > %s", $combo_file, $resfile);    
    printf("%s\n", $comm);
    unless ($DBG)
    {
	system($comm);
    }
    if ($do_lint)
    {
	&lint($resfile, $combo_file, $DBG);
    }
    if ($opt_w)
    {
	# FIREFOX WEB PROOFER
	$tweak = sprintf("perl %s/tweak_cdrom.pl | %s", $progdir, $add_sortkey);
	$resfile2 = $resfile;
	$resfile2 =~ s|_cdrom\.xml|_firefox\.xml|io;
	$comm = sprintf("%s \"$resfile\" > \"$resfile2\"", $add_sortkey);
	printf("%s\n", $comm); 
	unless ($DBG)
	{
	    system($comm);
	}

    }
}				# 
1;

















