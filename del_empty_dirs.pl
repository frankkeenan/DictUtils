#!/usr/local/bin/perl
# $Id: del_empty_dirs.pl,v 1.1 2017/11/03 08:37:02 keenanf Exp keenanf $
# $Log: del_empty_dirs.pl,v $
# Revision 1.1  2017/11/03 08:37:02  keenanf
# Initial revision
#
#
use Getopt::Std;
use Cwd;
use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_d, $opt_D, $opt_I, $opt_O, %W, %USED, %F, %INFO, %CT);
our $PDIR = "/usr/local/bin/";
#$PDIR = ".";

require "$PDIR/utils.pl";
require "$PDIR/restructure.pl";

# find all the text files below the current directory

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator

&main;

sub main
{
    getopts('a:bz:f:');
    #    stores value of arguments in $opt_a and $opt_z and BOOLEAN $opt_b
    #
    my $pwd = getcwd;
    # chdir "/usrdata3/audio/WAVS";
    # First delete DS_Store files
    # To be added
    my $newdir = $opt_f;
    while (1)
    {
	my $ct = &del_folder($newdir);
	last if ($ct == 0);
    }
    chdir $pwd;
}

sub del_folder
{
    my($folder) = @_;
    my($ct, $eid);	
    chdir $folder;
    open(FIND, "find . -type d -empty -print|");
  FILE: 
    while (my $fname = <FIND>) 
  {
      chomp $fname;       # strip record separator
      # format will be ./1/10/10p/10p#_gb_1.mp3
      my $comm = sprintf("rmdir \"%s\"", $fname); 	
      printf("deleting \"$fname\"\n"); 
      unless ($USED{$fname}++)
      {
	  $ct++;
      }
      system($comm);
  }
    return($ct);
}

