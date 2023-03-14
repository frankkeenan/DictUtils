#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
require "/usrdata3/dicts/NEWSTRUCTS/progs/utils.pl";
require "/NEWdata/dicts/generic/progs/restructure.pl";
#require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
$LOG = 1;
$UTF8 = 0;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IOxat');
    &usage if ($opt_u);
    my($e, $res, $bit);
    my(@BITS);
    $ids_f = "/NEWdata/dicts/generic/progs/reduce_dpsids.data"; # name of file for the log_fp output to go to
    &open_debug_files;
    &load_shortforms($ids_f);
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){
	    printf(bugin_fp "%s\n", $_);
	}
	# s|<!--.*?-->||gio;
#	next line if (m|<entry[^>]*del=\"y|io);
#	next line if (m|<entry[^>]*sup=\"y|io);
	# $h = &get_hdwd($_);	# fk1
	# $h = &get_hex_h($_, "hex", 1); # the 1 says to remove stress etc
	# $eid = &get_tag_attval($_, "entry", "eid");
	# $dps_eid = &get_dps_entry_id($_);
	# $_ = &reduce_idmids($_);
	# s|£|&\#x00A3;|g;
	$e = $_;
	if ($opt_a)
	{
	    s| xmlns=\".*?\"||gi;
	    s| xmlns:[^ =]*=\".*?\"||gi;
	    s| e:dbid=\".*?\"||gi;
	    s| e:version=\".*?\"||gi;
	    s| dpsid=\".*?\"||gi;
	    s| sourceid=\".*?\"||gi;
	    s| dupedid=\".*?\"||gi;
	}
	if ($opt_t)
	{
	    # 1st column is an e:id which needs to be reduced
	    s|^(.*?)\t|<tmptag e:id=\"\1\"></tmptag>\t|;
	}
	$_ = &reduce_dpsids($_);
	if ($opt_t)
	{
	    ($tmp, $info) = split(/\t/);
	    $eid = restructure::get_tag_attval($tmp, "tmptag", "e:id"); 
	    $_ = sprintf("%s\t%s", $eid, $info); 
	}
	unless ($opt_x)
	{
	    print $_;
	}
	if ($opt_O){
	    printf(bugout_fp "%s\n", $_); 
	}
    }
    &write_shortforms($ids_f);
    &close_debug_files;
}

sub reduce_dpsids
{
    my($e) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s|( e:id=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( dpsid=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( topic=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( bookmark=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( href=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( name=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( e:targetid=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( e:targeteltid=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( e:mediarecord=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( mediarecord=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;
    $e =~ s|( xmlid=\")(.*?)\"|\1&split;&fk;$2&split;\"|gi;

    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    if ($bit =~ m|^(.*)\.(.*?)$|)
	    {
		$base = $1;
		$id = $2;
		$shortform = $SHORTFORM{$base};
		if ($shortform =~ m|^ *$|)
		{
		    $shortform = &get_new_short_form($base);
		}
		$bit = sprintf("%s.%s", $shortform, $id);
	    }
	}
	$res .= $bit;
    }
    return $res;
}

sub get_new_short_form
{
    my($e) = @_;
    my($res, $eid, $short, $ct, $l);	
    $short = sprintf("E%03x", ++$ct);
    while ($SHORTUSED{$short})
    {
	$short = sprintf("E%03x", ++$ct);
    }
    $SHORTUSED{$short} = 1;
    $SHORTFORM{$e} = $short;
    $l = sprintf("%s\t%s", $short, $e); 
    $STORE{$l} = 1;
    return $short;
}

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    printf(STDERR "\t-u:\tDisplay usage\n"); 
#    printf(STDERR "\t-x:\t\n"); 
    exit;
}

sub write_shortforms
{
    my($f) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(out_fp, ">$f") || die "Unable to open >$f"; 
    if ($UTF8){
	binmode(out_fp, ":utf8");
    }
    foreach $l (sort keys %STORE)
    {
	printf(out_fp "%s\n", $l); 
    }
    if (0)
    {
	foreach $base (sort keys %SHORTFORM)
	{
	    printf(out_fp "%s\t%s\n", $SHORTFORM{$base}, $base); 
	}
    }
    close(out_fp);
} 

sub load_shortforms
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
	($short, $base) = split(/\t/);
	$SHORTFORM{$base} = $short;
	$SHORTUSED{$short} = 1;
	$STORE{$_} = 1;
    }
    close(in_fp);
} 


sub load_file
{
    my($f, $W) = @_;
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
	$W->{$_} = 1;
    }
    close(in_fp);
} 
