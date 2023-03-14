#!/usr/local/bin/perl
#
# $Id: utils.pl,v 1.1 2006/02/27 08:52:01 keenanf Exp keenanf $
# $Log: utils.pl,v $
# Revision 1.1  2006/02/27 08:52:01  keenanf
# Initial revision
#
#
use File::Compare;

package utils;
# utils::open_debug_files();

$SoundBase = "/usrdata3/audio";
$SOUND_DBASE = "/usrdata3/audio/DBASE.dat";



sub open_debug_files
{
    if ($UTF8){
	binmode(STDIN, ":utf8");
	binmode(STDOUT, ":utf8");
    }
    if ($LOG){
	open(log_fp, ">$0.log") || die "Unable to open >$0.log"; 
	if ($UTF8){
	    binmode(log_fp, ":utf8");
	}
    }
    if ($opt_I){
	open(bugin_fp, ">$0.in") || die "Unable to open >$0.in"; 
    }    
    if ($opt_O){
	open(bugout_fp, ">$0.out") || die "Unable to open >$0.out"; 
    }
}

sub close_debug_files
{
    if ($LOG){
	close(log_fp);
    }
    if ($opt_I){
	close(bugin_fp);
    }
    if ($opt_O){
	close(bugout_fp);
    }
}

sub get_phon_info
{
    my($e) = @_;
    my ($wd, $file, $phon, $lang);

    $wd = "";
    $file = "";
    $lang = "";
    $phon = "";
    if ($e =~ m| wd=\"(.*?)\"|io)
    {
	$wd = $1;
    }
    if ($e =~ m| file=\"(.*?)\"|io)
    {
	$file = $1;
    }
    $phon = $e;
    $phon =~ s|</?phon.*?>||gio;
    $phon =~ s|<\?xm-replace_text.*?\?>||gio;
    if ($e =~ m|<phon-gb|)
    {
	$lang = "gb";
    }
    else
    {
	$lang = "us";
    }
    return ($file, $lang, $phon, $wd);
}

sub get_name_date
{
    my ($date, $name, $comment);
    $date = scalar localtime;
    $name =  getlogin || (getpwuid($<)) [0];
    $comment = sprintf("<!-- Created by: %s Date: %s -->", $name, $date);
    return $comment;
}

sub my_name_date
{
    my ($date, $name, $comment);
    $date = scalar localtime;
    $name =  getlogin || (getpwuid($<)) [0];
    $comment = sprintf("Created by: %s Date: %s", $name, $date);
    return $comment;
}

sub gmt
{
    my($gmt) = @_;
    my($gmt_s, $gmt_m, $gmt_h, $gmt_md, $gmt_mon, $gmt_y, $gmt_d, $gmt_yd, $gmt_j);
    if ($gmt =~ m|^ *$|)
    {
	$gmt = time;
    }
    ($gmt_s, $gmt_m, $gmt_h, $gmt_md, $gmt_mon, $gmt_y, $gmt_d, $gmt_yd, $gmt_j) = gmtime($gmt);
    $gmt = sprintf("%02d:%02d:%02d\n", $gmt_h, $gmt_m, $gmt_s); 
    return $gmt;
}
##
sub get_xyz_file
{
    my($file, $BASE) = @_;
    my($fname, $fname2, $fcp, $resdir, $resfile);
    my($d1, $d2, $d3);
    $fcp = $file;
    $file =~ s|^.*/||;
    $file =~ tr|A-Z|a-z|;
    $file =~ s|^aux|xaux|;
    $file =~ s|^con|xcon|;
    $file =~ s|^nul|xnul|;
    $file =~ s| +& +|and|gio;
    $df = $file;
    $df =~ s|_.*$||;
    $df =~ s|$|__|;
    $df =~ s| +|_|gio;
    $df =~ s|[^a-z\_]+||gio;
    $file =~ s|[^a-z0-9\.\_]+||gio;
    if ($df =~ m|^(((.).).)|)
    {
	$d3 = $1;
	$d2 = $2;
	$d1 = $3;
	$resdir = sprintf("%s/%s/%s/%s", $BASE, $d1, $d2, $d3);
	$resfile = sprintf("%s/%s", $resdir, $file)
	}
    $resdir =~ tr|A-Z|a-z|;
    $resfile =~ tr|A-Z|a-z|;
    return ($resdir, $resfile);
}
##


sub get_fileh
{
    my($e) = @_;
    my $bit;
    my $h;
    my @BITS;

    $e =~ s|<\!--.*?-->||goi;
    $e =~ tr|A-Z|a-z|;
    $e =~ s|</?hs>||goi;
    $e =~ s|<ht>|<h>|goi;
    $e =~ s|</ht>|</h>|goi;
    $e =~ s|<hti>.*?</hti> *| |goi;
    $e =~ s|<hr>.*?</hr> *| |goi;
    # lose funnies
    $e =~ s|&[swp];||gio;
    $e =~ s|\$||gio;
    $e =~ s|&middot;||gio;
    $e =~ s|&trade;||gio;
    $e =~ s|&thinsp;||gio;
    $e =~ s|&[lr][sd]quo;| |gio;
    $e =~ s|<h> *|<h>|goi;
    if ($e =~ /<h> *(.*?)<\/h>/i)
    {
	$h = $1;
	if ($h =~ /&/)
	{
	    $h = &change_ae_ents($h);
	    $h = &ents2letter($h);
	}
	if ($h =~ /^ *$/)
	{
	    $h = "dk";
	}
	$h =~ s|^[\$\-]*||o;
	$h =~ s|^the ||o;
	$h =~ s|[^a-z0-9].*||io;
	return $h;
    }
}

sub get_target_fname
{
    my($h) = @_;
    my($fname);
    my($comm);
    my($firstletter);
    my($dir);
    $fname = $h;
    $fname =~ s|<hr>.*?</hr>||gio;
    $fname =~ s|<hti>.*?</hti>||gio;
    $fname =~ s|^[^a-z0-9]*||gio;
    $fname =~ tr|A-Z|a-z|;
    $fname =~ s|[^a-z0-9].*||;
#    $fname =~ s|\-.*||o;
    $firstletter = $fname;
    $firstletter =~ s|^(.).*$|$1|o;
    
    $dir = sprintf("%s/%s", $dictfiles, $firstletter);
    
    unless (-d $dir)
    {
	$comm = sprintf("mkdir -p %s", $dir);
	system($comm);
    }	
    $fname = sprintf("%s/%s.sgm", $dir, $fname);	
    $lockfile = $fname;
    $lockfile =~ s|/dictfiles/|/lockfiles/|o;
    $lockfile =~ s|\.sgm *$|\.lck|o;
    return($fname, $lockfile);
}

sub ents2letter
{
    my($e) = @_;
    $e = &lose_unicode_ents($e);
    $e =~ s|&[swp];||g;
    $e =~ s|&[lr][sd]quo;| |gio;
    $e =~ s|&nbhyph;|-|gio;
    $e =~ s| *&hellip; *| |gio;
    $e =~ s|&iexclam;| |go;
    $e =~ s|&iquest;| |go;
    $e =~ s| *&amp; *| and |gio;
    $e =~ s|&trade;||gio;
    $e =~ s|&reg;||gio;
    $e =~ s|&szlig;|ss|gio;
    $e =~ s| *&[^&; ]*thinsp[^&; ]*;||gio;
    $e =~ s| *&[^&; ]*hdwdsp[^&; ]*;||gio;
    $e =~ s|^ *||go;
    $e =~ s|&(.).*?;|$1|go;
    return $e;
}

sub get_hex_h
{
    my($e) = @_;
    my($h);
    $e =~ s|<ht([> ])|<h$1|gio;
    $e =~ s|</ht>|</h>|gio;
    $e =~ s|</?audio[^>]*>| |gio;
    $e =~ s|&\#x02C8;||go;
    $e =~ s|&\#x02CC;||go;
    $e =~ s|&\#x00B7;||go;
    $e =~ s|\'||go;
    $e =~ s|&\#x2122;||go;
    $e =~ s|&\#x2009;||go;
    $e =~ s|&\#x00AE;||go;
## quotes
    $e =~ s|&\#x00AB;||go;
    $e =~ s|&\#x201C;||go;
    $e =~ s|&\#x201E;||go;
    $e =~ s|&\#x2018;||go;
    $e =~ s|&\#x201A;||go;
    $e =~ s|&\#x0022;||go;
    $e =~ s|&\#x00BB;||go;
    $e =~ s|&\#x201D;||go;
    $e =~ s|&\#x201C;||go;
    $e =~ s|&\#x2019;||go;
    $e =~ s|&\#x2018;||go;
    $e =~ s|&[sp]stress;||gio;
    if ($e =~ m|(<h[ >].*?</h *>)|i)
    {
	$h = $1;
	$h =~ s|<.*?>||gio;
#	$h =~ s|,.*||;
	return $h;
    }
}

sub get_entry_id
{
    my($e) = @_;
    my $res;
    $res = "";
    if (m|<entry[^>]* e?id=\"(.*?)\"|i)
    {
	$res = $1;
    }
    return $res;
}


sub get_h
{
    my($e) = @_;
    my($h);
    $e = &lose_unicode_ents($e);
    $e =~ s|<ht([> ])|<h$1|gio;
    $e =~ s|</ht>|</h>|gio;
    $e =~ s|</?audio[^>]*>| |gio;
    $e =~ s|&[spw]b?;||go;
    $e =~ s|&middot;||go;
    $e =~ s|\'||go;
    $e =~ s|&trade;||go;
    $e =~ s|&[^&;]*thinsp;||go;
    $e =~ s|&[lr][sd]quo;||goi;
    $e =~ s|&[spw];||go;
    $e =~ s|&[sp]stress;||gio;
    if ($e =~ m|(<h[ >].*?</h *>)|i)
    {
	$h = $1;
	$h =~ s|<.*?>||gio;
	$h =~ s|,.*||;
	$h = &change_ae_ents($h);
	$h = &ents2letter($h);
	return $h;
    }
}


sub get_xml_h
{
    my($e) = @_;
    my($h);
    
    $e = &lose_unicode_ents($e);
    $e =~ s|<hm>.*?</hm>||gio;
#    $e =~ s|<.*?>||gio;
    $e =~ s|&\#x2122;||gio; # &tm;
    $e =~ s|&\#x2022;||gio; # &tm;
    $e =~ s| *$||;
    $e =~ s|<ht([> ])|<h$1|gio;
    $e =~ s|</ht>|</h>|gio;
    $e =~ s|</?audio[^>]*>| |gio;
    $e =~ s|&[spw]b?;||go;
    $e =~ s|&middot;||go;
    $e =~ s|\'||go;
    $e =~ s|&trade;||go;
    $e =~ s|&[^&;]*thinsp;||go;
    $e =~ s|&[lr][sd]quo;||goi;
    $e =~ s|&[spw];||go;
    $e =~ s|&[sp]stress;||gio;
    
    if ($e =~ m|(<h[ >].*?</h *>)|i)
    {
	$h = $1;
	$h =~ s|<.*?>||gio;
	$h =~ s|,.*||;
	$h = &change_ae_ents($h);
	$h = &ents2letter($h);
	return $h;
    }
}


sub get_dr
{
    my($e) = @_;
    my($h);
    $e = &lose_unicode_ents($e);
    $e =~ s|</?audio[^>]*>| |gio;
    $e =~ s|<(/?)zd([ >])|<$1dr$2|gi;
    $e =~ s|&[spw]b?;||go;
    $e =~ s|&middot;||go;
    $e =~ s|\'||go;
    $e =~ s|&trade;||go;
    $e =~ s|&[^&;]*thinsp;||go;
    $e =~ s|&[lr][sd]quo;||goi;
    $e =~ s|&[spw];||go;
    $e =~ s|&[sp]stress;||gio;
    if ($e =~ m|(<dr[ >].*?</dr *>)|i)
    {
	$h = $1;
	$h =~ s|<.*?>||gio;
	$h =~ s|,.*||;
	$h = &change_ae_ents($h);
	$h = &ents2letter($h);
	return $h;
    }
}

sub get_hdwd
{
    my($e) = @_;
    my($h);
    $e = &hex2letter($e);
    $e = &lose_unicode_ents($e);
    $e =~ s|<ht>|<h>|gio;
    $e =~ s|</ht>|</h>|gio;
    $e =~ s|</?audio[^>]*>||gio;
    $e =~ s|&[spw]b?;||go;
    $e =~ s|&middot;||go;
    $e =~ s|&trade;||go;
    $e =~ s|&thinsp;||go;
    $e =~ s|&[lr][sd]quo;||goi;
    $e =~ s|&[spw];||go;
    if ($e =~ m|(<h[ >].*?</h>)|i)
    {
	$h = $1;
	$h =~ s|<.*?>||gio;
	$h = &change_ae_ents($h);
	$h = &ents2letter($h);
	return $h;
    }
    else
    {
	return $file_hdwd;
    }
}

sub get_h_hm
{
    my($e) = @_;
    my($res);
    my $h;
    my $hm;
    $res = "";
    $h = "";
    $hm = "";
    $e = &lose_unicode_ents($e);
    $e =~ s|\t| |gio;
    $e =~ s|HT>|H>|gio;
    $e =~ s|HTI>|HR>|gio;
    if ($e =~ m|(<H[> ].*?</H>)|i)
    {
	$h = $1;
	$h =~ s|<HR>.*?</HR>||gio;
	$h =~ s|<[^>]*>||gio;
	$h =~ s|^ *||gio;
    }
    if ($e =~ m|<HM>(.*?)</HM>|i)
    {
	$hm = $1;
	$hm =~ s|^ *||gio;
    }
    $res = sprintf("<h>%s</h><hm>%s</hm>", $h, $hm);
    return $res;
}

sub get_topg
{
    my($e) = @_;
    if (m|^(.*?</top-g>)|io)
    {
	return $1;
    }
    return $e;
}

sub get_posg
{
    my($e) = @_;
    my($pres, $pbit, $ptag);
    my @PBITS;
    undef %PTMP;
    $e =~ s|(<p .*?>)|&split;&fk;$1&split;|gio;
    @PBITS = split(/&split;/, $e);
    $pres = "";
    foreach $pbit (@PBITS)
    {
	if ($pbit =~ s|&fk;||gio)
	{
	    if ($pbit =~ m| p=\"(.*?)\"|io)
	    {
		$ptag = $1;
		$PTMP{$ptag} = 1;
	    }
	}
    }
    foreach $ptag (sort keys %PTMP)
    {
	$pres = sprintf("%s%s\t", $pres, $ptag);
    }
    $pres =~ s|\t *$||;
    return $pres;
}

sub get_xh_xhm
{
    my($e) = @_;
    my($res);
    my $xh;
    my $xhm;
    my @XRS;
    my $xr;
    my $h_hm;
    $res = "";
    $xh = "";
    $xhm = "";
    $e =~ s|\t| |gio;
    return unless ($e =~ s|<XR |&split;<XR |gio);
    @XRS = split(/&split;/, $e);
  xrfloop:
    foreach $xr (@XRS)
    {
	next xrfloop unless ($xr =~ /<XR/i);
	if ($xr =~ m|<XHI?>(.*?)</XHI?>|i)
	{
	    $xh = $1;
	    $xh =~ s|^ *||gio;
	}
	if ($xr =~ m|<XHM>(.*?)</XHM>|i)
	{
	    $xhm = $1;
	    $xhm =~ s|^ *||gio;
	}
	$res = sprintf("%s<H>%s</H><HM>%s</HM>", $res, $xh, $xhm);
    }
    return $res;
}


sub get_sortkey
{
    my($e) = @_;
    my($h, $h2, $sk);
    my($hm);
    $hm = "";
    $h = "";
    
    if ($e =~ m|(<h[> ].*?</h>)|i)
    {
	$h = $1;
	$h =~ s|<[^>]*>||gio;
    }
    if ($e =~ m|<hm>(.*?)</hm>|i)
    {
	$hm = $1;
    }
    $h = &lose_unicode_ents($h);
    $h =~ s|&[spw]b?;||go;
    $h =~ s|&middot;||go;
    $h =~ s|&[spw];||go;
    $h =~ s|&(.).*?;|$1|go;
    $h =~ s|^the ||oi;
    $h =~ s|\'||oi; # ignore apostrophe in sort key ...
    $h2 = $h;
    if ($h2 =~ s|^\-+||o)
    {
	$h2 = sprintf("%s-", $h2);
    }
    $h =~ s|^\-*||o;
    $h =~ s|\-||go;
    $h =~ s|,.*||o;
    $h =~ s|[^a-zA-Z]||go;       
    $h =~ tr|A-Z|a-z|;
#    $psk = sprintf("%s#%s#%s", $h, $h2, $hm);
    $sk = sprintf("%-25s%-5s%-25s", $h, $h2, $hm);
    return $sk;
}

sub get_sortwd
{
    my($e) = @_;
    my($h, $h2, $sk);
    my($hm);
    $hm = "";
    $h = $e;
    
    $h = &lose_unicode_ents($h);
    $h =~ s|&[spw]b?;||go;
    $h =~ s|&middot;||go;
    $h =~ s|&[spw];||go;
    $h =~ s|&(.).*?;|$1|go;
    $h =~ s|^the ||oi;
    $h =~ s|\'||oi; # ignore apostrophe in sort key ...
    $h2 = $h;
    if ($h2 =~ s|^\-+||o)
    {
	$h2 = sprintf("%s-", $h2);
    }
    $h =~ s|^\-*||o;
    $h =~ s|\-||go;
    $h =~ s|,.*||o;
    $h =~ s|[^a-zA-Z]||go;       
    $h =~ tr|A-Z|a-z|;
#    $psk = sprintf("%s#%s#%s", $h, $h2, $hm);
    $sk = sprintf("%-25s%-5s", $h, $h2);
    return $sk;
}


sub def_prevletter
{
    my($letter) = @_;
    $prevletter{"a"} = "\'";
    $prevletter{"b"} = "a";
    $prevletter{"c"} = "b";
    $prevletter{"d"} = "c";
    $prevletter{"e"} = "d";
    $prevletter{"f"} = "e";
    $prevletter{"g"} = "f";
    $prevletter{"h"} = "g";
    $prevletter{"i"} = "h";
    $prevletter{"j"} = "i";
    $prevletter{"k"} = "j";
    $prevletter{"l"} = "k";
    $prevletter{"m"} = "l";
    $prevletter{"n"} = "m";
    $prevletter{"o"} = "n";
    $prevletter{"p"} = "o";
    $prevletter{"q"} = "p";
    $prevletter{"r"} = "q";
    $prevletter{"s"} = "r";
    $prevletter{"t"} = "s";
    $prevletter{"u"} = "t";
    $prevletter{"v"} = "u";
    $prevletter{"w"} = "v";
    $prevletter{"x"} = "w";
    $prevletter{"y"} = "x";
    $prevletter{"z"} = "y";
}

sub def_nextletter
{
    my($letter) = @_;
    $nextletter{"a"} = "b";
    $nextletter{"b"} = "c";
    $nextletter{"c"} = "d";
    $nextletter{"d"} = "e";
    $nextletter{"e"} = "f";
    $nextletter{"f"} = "g";
    $nextletter{"g"} = "h";
    $nextletter{"h"} = "i";
    $nextletter{"i"} = "j";
    $nextletter{"j"} = "k";
    $nextletter{"k"} = "l";
    $nextletter{"l"} = "m";
    $nextletter{"m"} = "n";
    $nextletter{"n"} = "o";
    $nextletter{"o"} = "p";
    $nextletter{"p"} = "q";
    $nextletter{"q"} = "r";
    $nextletter{"r"} = "s";
    $nextletter{"s"} = "t";
    $nextletter{"t"} = "u";
    $nextletter{"u"} = "v";
    $nextletter{"v"} = "w";
    $nextletter{"w"} = "x";
    $nextletter{"x"} = "y";
    $nextletter{"y"} = "z";
    $nextletter{"z"} = "z";
}

sub get_entry_file
{
    my($fname) = @_;
    $entry_file = `cat $fname`;    
    $entry_file =~ s|\n| |go;	# 
    $entry_file =~ s|||go;
    $entry_file =~ s|(<[^>]*)$|$1 |o;
    $entry_file =~ s|</ENTRY> *|</ENTRY>\n|goi;
    $entry_file =~ s| *<ENTRY|<ENTRY|goi;
    $entry_file =~ s|\n\n|\n|go;
    $entry_file =~ s|&middot;|&w;|go;
    return $entry_file;
}

sub get_date
{
    my($date);
    $date = `date +%y%m%d`;
    chomp $date;
    return $date;
}

sub get_date2
{
    my($date);
    $date = `date +%d/%m/%y`;
    chomp $date;
    return $date;
}

sub get_date3
{
    my($date);
    $date = scalar localtime;
    return $date;
}

sub get_logfile
{
    my($f) = @_;
    my($ct);
    my($date) = &get_date;
    $basef = $f;
    $f = sprintf("%s_%s.log", $f, $date);

    
    while (-f $f)
    {
	$ct++;
	$f = sprintf("%s_%s_%s.log", $basef, $date, $ct);
    }
    return $f;
}
sub open_logfile
{
    my($f, $mode) = @_;
    my $comment;
    if ($mode =~ m|o|)
    {
	open(log_fp, ">$f") || die "Unable to open >$f"; 
    }
    else
    {
	open(log_fp, ">>$f") || die "Unable to open >>$f"; 
    }
    $comment = &get_name_date;
    printf(log_fp "%s\n", $comment); 
    printf(STDERR "Log file opened: %s\n", $f); 
}

sub get_sound_dir
{
    my($wd) = @_;
    my($letters, $d1, $d2, $d3, $subdir, $add_the);
    $wd =~ s|^con|xcon|;
    # may not work as wanted the next one - aim is that the word with become "the accused" -> accused so that they are in the same folder with or without "the" at the start of the word
    
    $wd =~ s|^the[ _]||;
    
    $letters = sprintf("%s__", $wd);	    
    $letters =~ s|\#|__\#|;
    
    if ($letters =~ m|^(((.).).)|)
    {
	$d1 = $3;
	$d2 = $2;
	$d3 = $1;
	$subdir = sprintf("%s/%s/%s", $d1, $d2, $d3);
    }
    return $subdir;
}

sub mkdir
{
    my($dir, $log) = @_;
    my($comm);
    unless (-d $dir)
    {
	$comm = sprintf("mkdir -p %s", $dir);
	system($comm);
	if ($log)
	{
	    printf(log_fp "%s\n", $comm); 
	}
    }	
}

sub tidywd
{
    my($wd) = @_;
    $wd =~ tr|A-Z|a-z|;
    # get the entities to the base letter
    $wd = &hex2letter($wd);
    $wd =~ s|&(.)acute;|$1|gio;
    $wd =~ s|&(.)grave;|$1|gio;
    $wd =~ s|&(.)cedil;|$1|gio;
    $wd =~ s|&(.)circ;|$1|gio;
    $wd =~ s|&(.)uml;|$1|gio;
    $wd =~ s|&(.)tilde;|$1|gio;
    $wd =~ s|&trade;||gio;
    $wd =~ s|&tm;||gio;
    $wd =~ s|&copy;||gio;
    $wd =~ s|&reg;||gio;
    $wd =~ s|&.*?;||gio;
    $wd =~ s|[^a-z0-9_]||g;
    return $wd;
}

sub copyfile
{
    my($f, $res) = @_;
    $comm = sprintf("cp \"%s\" \"%s\"", $f, $res);
    if (-d $res)
    {
	$resf = $f;
	$resf =~ s|^.*/||;
	$resf = sprintf("%s/%s", $res, $resf);
	if (compare($f, $resf))
	{
	    system($comm);
	}
    }
    else
    {
	system($comm);
    }
}

sub lint
{
    my($xml_f, $combo, $dbg) = @_; 
    my $xmllint, $comm, $xml_errs_f, $lint_f, $combo_errs_f;
    $xmllint = "/usr/local/bin/xmllint --noout";
    $lint_f = sprintf("%s.errs", $xml_f);
    $comm  = sprintf("$xmllint $xml_f 2> $lint_f");
    printf("$comm\n"); 
    unless ($dbg)
    {
	system($comm);
	if (-s $lint_f)
	{
	    $xml_errs_f = sprintf("%s.errs", $xml_f);
	    $combo_errs_f = sprintf("%s.errs", $combo);
	    printf(STDERR "\n\nWARNING: There are XML errors in %s [see %s, %s, %s for details]\n\n", $xml_f, $lint_f, $xml_errs_f, $combo_errs_f); 
	    &load_lint_line_nums($lint_f);
	    &get_xml_err_lines($xml_f, $xml_errs_f);
	    unless ($combo =~ m|^ *$|)
	    {
#		printf("\n\n$combo ERRORS\n\n"); 
		
		&get_combo_errors($combo, $combo_errs_f);
	    }
	    return ($combo_errs_f);
	}
    }    
    return 0;
}

sub get_combo_errors
{
    my($f, $out_f) = @_;
    my $id;
    open(in_fp, "$f") || die "Unable to open $f"; 
    open(out_fp, ">$out_f") || die "Unable to open >$out_f"; 
    while (<in_fp>)
    {
	chomp;
	if (m|<entry[^>]*id=\"(.*?)\"|io)
	{
	    $id = $1;
	    if ($ERR_ID{$id})
	    {
		printf(out_fp "%s\n", $_);
	    }
	}
    }
    close(in_fp);
    close(out_fp);
} 


# print the error lines from XML and store the IDS that fail
sub get_xml_err_lines
{
    my($f, $out_f) = @_;
    my $lct, $id, %ERR_ID;
    open(lint_fp, "$f") || die "Unable to open $f"; 
    open(out_fp, ">$out_f") || die "Unable to open >$out_f"; 
    while (<lint_fp>)
    {
	chomp;
	if ($LINT_ERR{++$lct})
	{
	    if (m|<entry[^>]*id=\"(.*?)\"|io)
	    {
		$id = $1;
		$ERR_ID{$id} = 1;
	    }
	    printf(out_fp "%s\n", $_);
	}
    }
    close(lint_fp);
    close(out_fp);
} 


sub load_lint_line_nums
{
    my($f) = @_;
    open(lint_fp, "$f") || die "Unable to open $f"; 
    while (<lint_fp>)
    {
	chomp;
	s|^.*?:||gio;
	s|:.*||g;
	$LINT_ERR{$_} = 1;
    }
    close(lint_fp);
} 


sub get_pic_size
{
    my($f) = @_;
    my($comm);
    my($j);
    my($x, $y);    
    $comm = sprintf("identify -ping %s", $f);
    $j = `$comm`;
#    $j =~ s|\t| |g;
    if ($j =~ m|^.*? ([0-9]+)x([0-9]+) |)
    {
	$x = $1;
	$y = $2;
    }
#	printf("<file>%s</file><x>%s</x><y>%s</y>\n", $f, $x, $y); 
    return($y, $x); # return ht, width
}

sub lose_unicode_ents
{
    my($e) = @_;
    $e =~ s|&\#x2027;||gio; # &w;
    $e =~ s|&#x02C[C8];||gio;  # &[ps]
    $e =~ s|&#x2009;| |gio;
    $e =~ s|&#x2013;| |gio;
    $e =~ s|&\#x201C;||gio;
    $e =~ s|&\#x201D;||gio;
    $e =~ s|&\#x2022;||gio;
    $e =~ s|&\#x2026;||gio;
    $e =~ s|&\#x2027;||gio;
    $e =~ s|&\#x2122;||gio;
    $e =~ s|&\#x22C6;||gio;
    $e =~ s|&\#x25B8;||gio;
    $e =~ s|&\#x279C;||gio;
    $e =~ s|&\#x27A4;||gio;
    $e =~ s|&\#x27AA;||gio;
    $e =~ s|&\#x00B7;||gio;
    return $e;
}

sub norm_wd
{
    my($wd) = @_;
    $wd = &hex2letter($wd);
    $wd =~ s|&(.)acute;|$1|gio;
    $wd =~ s|&(.)grave;|$1|gio;
    $wd =~ s|&(.)cedil;|$1|gio;
    $wd =~ s|&(.)circ;|$1|gio;
    $wd =~ s|&(.)uml;|$1|gio;
    $wd =~ s|&(.)tilde;|$1|gio;
    $wd =~ s|&trade;||gio;
    $wd =~ s|&tm;||gio;
    $wd =~ s|&copy;||gio;
    $wd =~ s|&reg;||gio;
    $wd =~ tr|A-Z|a-z|;
    $wd =~ s|[^a-z0-9]+||gio;
    return $wd;
}

sub hex2letter
{
    my($e) = @_;
    unless ($e =~ m|&\#x|)
    {
	return $e;
    }
    $e =~ s|&\#x00C6;|AE|go;
    $e =~ s|&\#x00C0;|A|go;
    $e =~ s|&\#x00C1;|A|go;
    $e =~ s|&\#x00C2;|A|go;
    $e =~ s|&\#x00C3;|A|go;
    $e =~ s|&\#x00C4;|A|go;
    $e =~ s|&\#x00C5;|A|go;
    $e =~ s|&\#x00C7;|C|go;
    $e =~ s|&\#x00C8;|E|go;
    $e =~ s|&\#x00C9;|E|go;
    $e =~ s|&\#x00CA;|E|go;
    $e =~ s|&\#x00CB;|E|go;
    $e =~ s|&\#x00CC;|I|go;
    $e =~ s|&\#x00CD;|I|go;
    $e =~ s|&\#x00CE;|I|go;
    $e =~ s|&\#x00CF;|I|go;
    $e =~ s|&\#x00D1;|N|go;
    $e =~ s|&\#x00D2;|O|go;
    $e =~ s|&\#x00D3;|O|go;
    $e =~ s|&\#x00D4;|O|go;
    $e =~ s|&\#x00D5;|O|go;
    $e =~ s|&\#x00D6;|O|go;
    $e =~ s|&\#x00D8;|O|go;
    $e =~ s|&\#x00D9;|U|go;
    $e =~ s|&\#x00DA;|U|go;
    $e =~ s|&\#x00DB;|U|go;
    $e =~ s|&\#x00DC;|U|go;
    $e =~ s|&\#x00DD;|Y|go;
    $e =~ s|&\#x00DF;|sz|go;
    $e =~ s|&\#x00E0;|a|go;
    $e =~ s|&\#x00E1;|a|go;
    $e =~ s|&\#x00E2;|a|go;
    $e =~ s|&\#x00E3;|a|go;
    $e =~ s|&\#x00E4;|a|go;
    $e =~ s|&\#x00E5;|a|go;
    $e =~ s|&\#x00E6;|ae|go;
    $e =~ s|&\#x00E7;|c|go;
    $e =~ s|&\#x00E8;|e|go;
    $e =~ s|&\#x00E9;|e|go;
    $e =~ s|&\#x00EA;|e|go;
    $e =~ s|&\#x00EB;|e|go;
    $e =~ s|&\#x00EC;|i|go;
    $e =~ s|&\#x00ED;|i|go;
    $e =~ s|&\#x00EE;|i|go;
    $e =~ s|&\#x00EF;|i|go;
    $e =~ s|&\#x00F1;|n|go;
    $e =~ s|&\#x00F2;|o|go;
    $e =~ s|&\#x00F3;|o|go;
    $e =~ s|&\#x00F4;|o|go;
    $e =~ s|&\#x00F5;|o|go;
    $e =~ s|&\#x00F6;|o|go;
    $e =~ s|&\#x00F9;|u|go;
    $e =~ s|&\#x00FA;|u|go;
    $e =~ s|&\#x00FB;|u|go;
    $e =~ s|&\#x00FC;|u|go;
    $e =~ s|&\#x00FD;|y|go;
    $e =~ s|&\#x00FF;|y|go;
    $e =~ s|&\#x0100;|A|go;
    $e =~ s|&\#x0101;|a|go;
    $e =~ s|&\#x0102;|A|go;
    $e =~ s|&\#x0103;|a|go;
    $e =~ s|&\#x0104;|A|go;
    $e =~ s|&\#x0105;|a|go;
    $e =~ s|&\#x0106;|C|go;
    $e =~ s|&\#x0107;|c|go;
    $e =~ s|&\#x0108;|C|go;
    $e =~ s|&\#x0109;|c|go;
    $e =~ s|&\#x010A;|C|go;
    $e =~ s|&\#x010B;|c|go;
    $e =~ s|&\#x010C;|C|go;
    $e =~ s|&\#x010D;|c|go;
    $e =~ s|&\#x010E;|D|go;
    $e =~ s|&\#x010F;|d|go;
    $e =~ s|&\#x0110;|D|go;
    $e =~ s|&\#x0111;|d|go;
    $e =~ s|&\#x0112;|E|go;
    $e =~ s|&\#x0113;|e|go;
    $e =~ s|&\#x0116;|E|go;
    $e =~ s|&\#x0117;|e|go;
    $e =~ s|&\#x0118;|E|go;
    $e =~ s|&\#x0119;|e|go;
    $e =~ s|&\#x011A;|E|go;
    $e =~ s|&\#x011B;|e|go;
    $e =~ s|&\#x011C;|G|go;
    $e =~ s|&\#x011D;|g|go;
    $e =~ s|&\#x011E;|G|go;
    $e =~ s|&\#x011F;|g|go;
    $e =~ s|&\#x0120;|G|go;
    $e =~ s|&\#x0121;|g|go;
    $e =~ s|&\#x0122;|G|go;
    $e =~ s|&\#x0124;|H|go;
    $e =~ s|&\#x0125;|h|go;
    $e =~ s|&\#x0126;|H|go;
    $e =~ s|&\#x0127;|h|go;
    $e =~ s|&\#x0128;|I|go;
    $e =~ s|&\#x0129;|i|go;
    $e =~ s|&\#x012A;|I|go;
    $e =~ s|&\#x012B;|i|go;
    $e =~ s|&\#x012E;|I|go;
    $e =~ s|&\#x012F;|i|go;
    $e =~ s|&\#x0130;|I|go;
    $e =~ s|&\#x0131;|i|go;
    $e =~ s|&\#x0132;|IJ|go;
    $e =~ s|&\#x0133;|ij|go;
    $e =~ s|&\#x0134;|J|go;
    $e =~ s|&\#x0135;|j|go;
    $e =~ s|&\#x0136;|K|go;
    $e =~ s|&\#x0137;|k|go;
    $e =~ s|&\#x0139;|L|go;
    $e =~ s|&\#x013A;|l|go;
    $e =~ s|&\#x013B;|L|go;
    $e =~ s|&\#x013C;|l|go;
    $e =~ s|&\#x013D;|L|go;
    $e =~ s|&\#x013E;|l|go;
    $e =~ s|&\#x013F;|L|go;
    $e =~ s|&\#x0140;|l|go;
    $e =~ s|&\#x0141;|L|go;
    $e =~ s|&\#x0142;|l|go;
    $e =~ s|&\#x0143;|N|go;
    $e =~ s|&\#x0144;|n|go;
    $e =~ s|&\#x0145;|N|go;
    $e =~ s|&\#x0146;|n|go;
    $e =~ s|&\#x0147;|N|go;
    $e =~ s|&\#x0148;|n|go;
    $e =~ s|&\#x014C;|O|go;
    $e =~ s|&\#x014D;|o|go;
    $e =~ s|&\#x0152;|OE|go;
    $e =~ s|&\#x0153;|oe|go;
    $e =~ s|&\#x0154;|R|go;
    $e =~ s|&\#x0155;|r|go;
    $e =~ s|&\#x0156;|R|go;
    $e =~ s|&\#x0157;|r|go;
    $e =~ s|&\#x0158;|R|go;
    $e =~ s|&\#x0159;|r|go;
    $e =~ s|&\#x015A;|S|go;
    $e =~ s|&\#x015B;|s|go;
    $e =~ s|&\#x015C;|S|go;
    $e =~ s|&\#x015D;|s|go;
    $e =~ s|&\#x015E;|S|go;
    $e =~ s|&\#x015F;|s|go;
    $e =~ s|&\#x0160;|S|go;
    $e =~ s|&\#x0161;|s|go;
    $e =~ s|&\#x0162;|T|go;
    $e =~ s|&\#x0163;|t|go;
    $e =~ s|&\#x0164;|T|go;
    $e =~ s|&\#x0165;|t|go;
    $e =~ s|&\#x0166;|T|go;
    $e =~ s|&\#x0167;|t|go;
    $e =~ s|&\#x0168;|U|go;
    $e =~ s|&\#x0169;|u|go;
    $e =~ s|&\#x016A;|U|go;
    $e =~ s|&\#x016B;|u|go;
    $e =~ s|&\#x016C;|U|go;
    $e =~ s|&\#x016D;|u|go;
    $e =~ s|&\#x016E;|U|go;
    $e =~ s|&\#x016F;|u|go;
    $e =~ s|&\#x0172;|U|go;
    $e =~ s|&\#x0173;|u|go;
    $e =~ s|&\#x0174;|W|go;
    $e =~ s|&\#x0175;|w|go;
    $e =~ s|&\#x0176;|Y|go;
    $e =~ s|&\#x0177;|y|go;
    $e =~ s|&\#x0178;|Y|go;
    $e =~ s|&\#x0179;|Z|go;
    $e =~ s|&\#x017A;|z|go;
    $e =~ s|&\#x017B;|Z|go;
    $e =~ s|&\#x017C;|z|go;
    $e =~ s|&\#x017D;|Z|go;
    $e =~ s|&\#x017E;|z|go;
    $e =~ s|&\#x01F5;|g|go;
    $e =~ s|&\#xFB00;|ff|go;
    $e =~ s|&\#xFB01;|fi|go;
    $e =~ s|&\#xFB02;|fl|go;
    $e =~ s|&\#xFB03;|ffi|go;
    $e =~ s|&\#xFB04;|ffl|go;
    $e =~ s|&\#x[^ ;]*;||go;
    return $e;
}

sub utf82nimpho
{
    my($e) = @_;
    $e =~ s|&#x00E6;|&amp;|gio;
    $e =~ s|&#x025C;|3|gio;
    $e =~ s|&#x0025;|6|gio;
    $e =~ s|&#x02d0;|:|gio;
    $e =~ s|&#x02D0;|;|gio;
    $e =~ s|&#x0259;|\@|gio;
    $e =~ s|&#x0251;|A|gio;
    $e =~ s|&#x00F0;|D|gio;
    $e =~ s|&#x025B;|E|gio;
    $e =~ s|&#x02D0;|F|gio;
    $e =~ s|&#x026A;|I|gio;
    $e =~ s|&#x0259;|J|gio;
    $e =~ s|&#x014B;|N|gio;
    $e =~ s|&#x0254;|O|gio;
    $e =~ s|&#x0252;|Q|gio;
    $e =~ s|&#x0283;|S|gio;
    $e =~ s|&#x0275;|T|gio;
    $e =~ s|&#x028A;|U|gio;
    $e =~ s|&#x028C;|V|gio;
    $e =~ s|&#x025C;|W|gio;
    $e =~ s|&#x0292;|Z|gio;
    $e =~ s|&#x0261;|g|gio;
    $e =~ s|&#x02CC;|\"|gio;
    $e =~ s|&#x02C8;|%|gio;
    $e =~ s|&#x02C8;|\"|gio;
    $e =~ s|&#x02CC;|%|gio;
    $e =~ s|&#x0342;|~|gio;
    return $e;
}

&def_prevletter;
&def_nextletter;

1;
