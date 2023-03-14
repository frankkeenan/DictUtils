#!/usr/local/bin/perl
#
# Input = 
# Result = 
# $Id$
# $Log$
#
use Getopt::Std;
require "/usrdata3/dicts/NEWSTRUCTS/progs/utils.pl";
require "/NEWdata/dicts/generic/progs/unicode_to_named_ents.pl";

$LOG = 0;
$LOAD = 0;
$UTF8 = 0;

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
    getopts('uf:L:IO');
#    getopts('a:bz:');
#    stores value of arguments in $opt_a and $opt_z and BOOLEAN $opt_b
#
    if ($opt_u){
	&usage;
    }
    &open_debug_files;
    if ($LOAD){
	&load_file($opt_f);
    }
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){
	    printf(bugin_fp "%s\n", $_);
	}
	# fk1
	# s|<!--.*?-->||gio;
#	next line if (m|<entry[^>]*del=\"y|io);
	# $h = &get_hdwd($_);
	# $eid = &get_tag_attval($_, "entry", "eid");
	# $dps_eid = &get_dps_entry_id($_);
	# $_ = &lose_idm_ids($_);
	$_ = &unicode_to_named_ents($_);
	print $_;
	if ($opt_O){
	    printf(bugout_fp "%s\n", $_); 
	}
    }
    &close_debug_files;
}

sub load_file
{
    my($f) = @_;
    my $res;
    my @BITS;
    my $bit;
    open(in_fp, "$f") || die "Unable to open $f"; 
    if ($UTF8){
	binmode(in_fp, ":utf8");
    }
    while (<in_fp>){
	chomp;
	s|||g;
	$W{$_} = 1;
    }
    close(in_fp);
} 
