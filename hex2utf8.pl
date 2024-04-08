#!/usr/local/bin/perl
#
# Input = 
# Result = 
# $Id$
# $Log$
#
use Getopt::Std;
use Encode;
our $PDIR = $ENV{DICT_UTILS};
if ($PDIR =~ m|^ *$|)
{
    printf(STDERR "Need to set ENV for DICT_UTILS\n\n"); 
}
#$PDIR = ".";

require "$PDIR/utils.pl";
require "$PDIR/restructure.pl";



$LOG = 0;
$LOAD = 0;

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once

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
    getopts('uf:');
#    getopts('a:bz:');
#    stores value of arguments in $opt_a and $opt_z and BOOLEAN $opt_b
#
    binmode(STDOUT, ":utf8");
    if ($opt_u)
    {
	&usage;
    }
    if ($LOG)
    {
	open(log_fp, ">$0.log") || die "Unable to open >$0.log"; 
    }
    if ($LOAD)
    {
	&load_file($opt_f);
    }
  line:    
    while (<>) 
    {
	chomp;       # strip record separator
	s|||g;
	s|&\#x([0-9A-F]*);|chr(hex($1))|gie;
	print;
    }
    if ($LOG)
    {
	close(log_fp);
    }
}

sub load_file
{
    my($f) = @_;
    my $res;
    my @BITS;
    my $bit;

    open(in_fp, "$f") || die "Unable to open $f"; 
    while (<in_fp>)
    {
	chomp;
	s|||g;
	$W{$_} = 1;
    }
    close(in_fp);
} 
