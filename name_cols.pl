#!/usr/bin/perl
use Getopt::Std;
use autodie qw(:all);
use utf8;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_d, $opt_D, $opt_I, $opt_O, %W, %USED, %F, %INFO);
our $PDIR = "/usr/local/bin/";
#$PDIR = ".";

require "$PDIR/utils.pl";
require "$PDIR/restructure.pl";

$LOG = 0;
$LOAD = 0;
$UTF8 = 1;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IOc:h');
 #   &usage unless ($opt_c);
    &usage if ($opt_u);
    my($e, $res, $bit);
    my(@BITS);
    #   $opt_L = ""; # name of file for the log_fp output to go to
    use open qw(:std :utf8);
    &open_debug_files;
    #    binmode DB::OUT,":utf8";
#    $col = $opt_c;
    if ($LOAD){&load_file($opt_f, \%WANTED);}
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){printf(bugin_fp "%s\n", $_);}
	#	unless (m|<entry|){print $_; next line;}
	# s|<!--.*?-->||gio;
	#	next line if (m|<entry[^>]*del=\"y|io);
	#	next line if (m|<entry[^>]*sup=\"y|io);
	# $h = &get_hex_h($_, "hex", 1); # the 1 says to remove stress etc
	# $eid = &get_tag_attval($_, "entry", "eid");
	# $e_eid = &get_dps_entry_id($_);
	# $_ = &reduce_idmids($_);
	# s|£|&\#x00A3;|g;
        # $_ = restructure::delabel($_);	
	# $tagname = restructure::get_tagname($bit);    
	if (m| row=\"0\"|)
	{
	    &get_tag_names($_);
	    unless ($opt_h)
	    {
		next line;
	    }
	}
	$_ = &set_tag_names($_);
	print $_;
	if ($opt_O){printf(bugout_fp "%s\n", $_);}
    }
    &close_debug_files;
}

sub set_tag_names
{
    my($e) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s|(<col[ >].*?</col>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $colnum = restructure::get_tag_attval($bit, "col", "col"); 
	    $name = $NAME[$colnum];
	    $bit = restructure::tag_rename($bit, "col", $name); #, "TOFIX", "PSGCOMMENT"); 
	}
	$res .= $bit;
    }    
    return $res;
}

sub get_tag_names
{
    my($e) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s|(<col[ >].*?</col>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $colnum = restructure::get_tag_attval($bit, "col", "col"); 
	    $name = restructure::get_tag_contents($bit, "col");
	    if ($colnum == 0)
	    {
		if ($name =~ m|^[0-9a-f]+:|)
		{
		    $name = "E_EID";
		}
	    }
	    $name =~ s|[^a-z0-9_]+|_|gi;
	    $name =~ s|_$||;
	    $NAME[$colnum] = $name;		 
	}
	$res .= $bit;
    }    
    return $res;
}


sub get_col_contents
{
    my($e, $tcol) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s|(<col[ >].*?</col>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    my $col = restructure::get_tag_attval($bit, "col", "col"); 
	    if ($col eq $tcol)
	    {
		$res = restructure::get_tag_contents($bit, "col"); 
		return $res;
	    }
	}
    }    
    return;
}

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    #    printf(STDERR "\t-u:\tDisplay usage\n"); 
    printf(STDERR "\t-c:\tcol\n"); 
    exit;
}


sub load_file
{
    my($f, $WANTED) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    if ($UTF8){
	binmode(in_fp, ":utf8");
    }
    while (<in_fp>){
	chomp;
	s|||g;
	# my ($eid, $info) = split(/\t/);
	# $W{$_} = 1;
    }
    close(in_fp);
} 
