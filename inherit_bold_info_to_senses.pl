#!/usr/local/bin/perl
#
# Input = 
# Result = 
# $Id$
# $Log$
#
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
require "/usrdata3/dicts/NEWSTRUCTS/progs/utils.pl";
require "/NEWdata/dicts/generic/progs/restructure.pl";

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
    use open qw(:utf8 :std);
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
	# $_ = &reduce_idmids($_);
	# s|£|&\#x00A3;|g;
	$_ = restructure::lose_tag($_, "st"); # lose the tags but not the contents
	s|</alt><alt[^>]*>|/|gi;
	s|</?alt[^>]*>||gi;
	$_ = restructure::expand_sb_sth($_);
	$_ = &mark_dummy_senses($_);
	$_ = restructure::attrib_rename($_, "p", "p", "pos");
	$_ = restructure::tag_rename($_, "p", "pos"); 
	$_ =~ s|somebody *<er[^>]*>or</er> *something|sb/sth|gi;
	$h = &get_hex_h($_, "hex", 1); # the 1 says to remove stress etc
	if (m|<subentry|)
	{
	    $_ = &add_h_to_subentry($_, $h);
	}
	$_ = &inherit_bold_info_to_senses($_, "idm-g", "idm", "idm");
	$_ = &inherit_bold_info_to_senses($_, "pv-g", "pv", "pv");
	$_ = &inherit_bold_info_to_senses($_, "dr-g", "dr", "");
	$_ = &inherit_bold_info_to_senses($_, "bf-g", "bf", "bf");
	$_ = &inherit_bold_info_to_senses($_, "subentry-g", "h", "");
	$_ = &inherit_bold_info_to_senses($_, "h-g", "h", "");
	print $_;
	if ($opt_O){
	    printf(bugout_fp "%s\n", $_); 
	}
    }
    &close_debug_files;
}

sub add_h_to_subentry
{
    my($e, $h) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s|(<subentry-g[ >].*?</subentry-g>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $bit =~ s|(<top-g[^>]*>)|\1<h type="subentry">$h</h>|;
	}
	$res .= $bit;
    }    
    return $res;
}

sub mark_dummy_senses
{
    my($e) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s|(<sn-g[ >].*?</sn-g>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $contents = restructure::get_tag_contents($bit, "sn-g"); 
	    $contents = restructure::tag_delete($contents, "xr-gs"); 
	    if ($contents =~ m|^ *$|)
	    {
		$bit = restructure::set_tag_attval($bit, "sn-g", "xrefonly", "y"); 
	    }
	}
	$res .= $bit;
    }    
    return $res;
}

sub inherit_bold_info_to_senses
{
    my($e, $group, $btag, $pos) = @_;
#($_, "h-g", "h");
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    unless ($e =~ m|<$group[ >]|i)
    {
	return($e);
    }
    $e =~ s|(<$group[ >].*?</$group>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $bold = restructure::get_tag_contents($bit, $btag); 
	    $bold =~ s| *<er[^>]*>or</er> *|/|gi;
	    $bold =~ s|<!--.*?-->||gi;
	    $bold =~ s|&\#x02C.;||gi;
	    $bold =~ s|&\#x00B7;||gi;
	    $topg = restructure::get_tag_contents($bit, "top-g"); 
	    $topg_pos = restructure::get_tag_attval($topg, "pos", "pos"); 
	    unless ($topg_pos =~ m|^ *$|)
	    {
		$pos = $topg_pos;
	    }
	    if ($pos =~ m|^ *$|)
	    {
		$pos = restructure::get_tag_attval($bit, "pos", "pos"); 
	    }
	    $bit = &add_info_to_sngs($bit, $bold, $pos);
	}
	$res .= $bit;
    }    
    return $res;
}

sub add_info_to_sngs
{
    my($e, $bold, $pos) = @_;
    my($res, $eid);	
    my($bit, $oldbold, $localpos);
    my(@BITS);
    $e =~ s|(<sn-g[ >].*?</sn-g>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $oldbold = restructure::get_tag_attval($bit, "sn-g", "bold");  
	    if ($oldbold =~ m|^ *$|)
	    {
		$localpos = restructure::get_tag_attval($bit, "pos", "pos"); 
		if ($localpos =~ m|[a-z]|i)
		{
		    $bit = restructure::set_tag_attval($bit, "sn-g", "pos", $localpos); 
		}
		else {
		    unless ($pos =~ m|^ *$|)
		    {
			$bit = restructure::set_tag_attval($bit, "sn-g", "pos", $pos); 
		    }
		}
		$bit = restructure::set_tag_attval($bit, "sn-g", "bold", $bold); 
	    }
	}
	$res .= $bit;
    }    
    return $res;
}

sub add_info_to_senses
{
    my($e, $bold, $pos) = @_;
    my($res, $eid);	
    my($bit, $oldbold, $localpos);
    my(@BITS);
    $e =~ s|(<sn-g[ >].*?</sn-g>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $oldbold = restructure::get_tag_attval($bit, "sn-g", "bold");  
	    if ($oldbold =~ m|^ *$|)
	    {
		$bit = restructure::set_tag_attval($bit, "sn-g", "bold", $bold); 
		$localpos = restructure::get_tag_attval($bit, "pos", "pos"); 
		if ($localpos =~ m|[a-z]|i)
		{
		    $bit = restructure::set_tag_attval($bit, "sn-g", "pos", $localpos); 
		}
		else {
		    unless ($pos =~ m|^ *$|)
		    {
			$bit = restructure::set_tag_attval($bit, "sn-g", "pos", $pos); 
		    }
		}
	    }
	}
	$res .= $bit;
    }    
    return $res;
}


sub load_file
{
    my($f) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    if ($UTF8){
	binmode(in_fp, ":utf8");
    }
    while (<in_fp>){
	chomp;
	s|||g;
	# ($id, $info) = split(/\t/);
	$W{$_} = 1;
    }
    close(in_fp);
} 
