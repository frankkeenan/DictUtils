#!/usr/local/bin/perl5.003

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
$DBG = 0;

# require "/data/dicts/guide/progs/utils.pl";

&main;

sub main
{
line:    while (<>) 
    {
	chomp;       # strip record separator
	s|& |&amp; |go;
#	s|(<[^ >]*)|\L$1\E|gio;
	s|<ENTRYid>|<ent_id>|gio;
	s|</ENTRYid>|</ent_id>|gio;
	if ($_ =~ m|<entry|i)
	{
	    &save($_);
	}
    }
  &print_res;
}

sub save
{
    my($e) = @_;
    my($key);
    my($hdr);
#    $e =~ s|@*<ENTRY|<ENTRY|goi;
    if ($e =~ s/^(.+?)<ENTRY/<entry/i)
    {
	$hdr = $1;
#	$hdr =~ s|\@|\n|go;
	printf("%s\n", $hdr) unless ($HDR_DONE);
	$HDR_DONE = 1;
    }
    # get the sort key
    $key = &get_sortkey($e);
    return if ($key =~ /^[ \t]*$/);
#    $key =~ tr|A-Z|a-z|;
    ;
    $key = sprintf("%s=%2d", $key, ++$KEYCT{$key});
    
#    printf("KEY = |%s|\n", $key);
    unless ($e =~ /<ENTRY [^>]*DEL=\"Y\"/i)
    {
	$SAVE{$key} = $e;
    }
}

sub print_res
{
    my($e);
    foreach $key (sort keys %SAVE)
    {
	$e = $SAVE{$key};
	$e =~ s|(<[^> ]*)|\L$1\E|g;
#	$e =~ s|\@|\n|go;
#	s|&atsym;|\@|go;
	if ($DBG)
	{
	    printf("<KEY>%s</KEY>%s\n", $key, $e);
	}
	else
	{
	    printf("%s\n", $e);
	}
    }
}


sub get_ent_letter
{
    my ($line) = @_;
    $line =~ s|&r[sd]quo;||go;
    $line =~ s|&l[sd]quo;||go;
    $line =~ s|&([A-Za-z]).*?;|\1|go;
    $line =~ s|&\#128;|A|go;
    $line =~ s|&\#129;|A|go;

    $line =~ s|&\#130;|C|go;
    $line =~ s|&\#131;|E|go;
    $line =~ s|&\#132;|N|go;
    $line =~ s|&\#133;|O|go;
    $line =~ s|&\#134;|U|go;

    $line =~ s|&\#135;|a|go;
    $line =~ s|&\#136;|a|go;
    $line =~ s|&\#137;|a|go;
    $line =~ s|&\#138;|a|go;
    $line =~ s|&\#139;|a|go;
    $line =~ s|&\#140;|a|go;

    $line =~ s|&\#141;|c|go;
    $line =~ s|&\#142;|e|go;
    $line =~ s|&\#143;|e|go;
    $line =~ s|&\#144;|e|go;
    $line =~ s|&\#145;|e|go;
    $line =~ s|&\#146;|i|go;
    $line =~ s|&\#147;|i|go;
    $line =~ s|&\#148;|i|go;
    $line =~ s|&\#149;|i|go;

    $line =~ s|&\#150;|n|go;
    $line =~ s|&\#151;|o|go;
    $line =~ s|&\#152;|o|go;
    $line =~ s|&\#153;|o|go;
    $line =~ s|&\#154;|o|go;
    $line =~ s|&\#155;|o|go;
    $line =~ s|&\#156;|u|go;
    $line =~ s|&\#157;|u|go;
    $line =~ s|&\#158;|u|go;
    $line =~ s|&\#159;|u|go;

    $line =~ s|&\#163;|p|go;
    $line =~ s|&\#174;|A|go;
    $line =~ s|&\#190;|a|go;
    $line =~ s|&\#191;|o|go;

    $line =~ s|&\#192;|i|go;
    $line =~ s|&\#201;|h|go;
    $line =~ s|&\#203;|A|go;

    $line =~ s|&\#204;|A|go;
    $line =~ s|&\#205;|O|go;
    $line =~ s|&\#216;|y|go;

    $line =~ s|&\#229;|A|go;
    $line =~ s|&\#230;|E|go;
    $line =~ s|&\#231;|A|go;
    $line =~ s|&\#232;|E|go;
    $line =~ s|&\#233;|E|go;
    $line =~ s|&\#234;|I|go;
    $line =~ s|&\#235;|I|go;
    $line =~ s|&\#236;|I|go;
    $line =~ s|&\#237;|I|go;
    $line =~ s|&\#238;|O|go;
    $line =~ s|&\#239;|O|go;

    $line =~ s|&\#241;|O|go;

    $line =~ s|&\#242;|U|go;
    $line =~ s|&\#243;|U|go;
    $line =~ s|&\#244;|U|go;

    
    return($line);
}

$hdr = "<!DOCTYPE BATCH SYSTEM \"ALD6_SQ.DTD\">\n<batch>\n";
$basedir = "/data/dicts/ald6";
$dictfiles = sprintf("%s/dictfiles", $basedir);

sub get_target_fname
{
    my($h) = @_;
    my($fname);
    my($comm);
    my($firstletter);
    my($dir);
    $fname = $h;
    $fname =~ s|^ ||o;
    $fname =~ s|&middot;||go;
    $fname =~ s|&[spw];||go;
    $fname =~ s|&(.).*?;|$1|go;
    $fname =~ s|^the ||oi;
    $fname =~ s| .*||o;
    $fname =~ s|^\-*||o;
    $fname =~ s|\-.*||o;
    $fname =~ tr|A-Z|a-z|;
    $fname =~ s|[^a-z]||go;   
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

sub get_h_hm
{
    my($e) = @_;
    my($hm, $hw, $h_hm);

    $hw = $e;
    $hw =~ s|&[spw][\.;]||goi;
    $hw =~ s|&middot[\.;]||goi;
    $hw =~ s|&sb[\.;]||goi;
    $hw =~ s|</h>.*||io;
    $hw =~ s|^.*>||io;


    $h_hm = sprintf("<h>%s</h>", $hw);

    if ($e =~ /<HM/i)
    {
	$hm = $e;
	$hm =~ s|</hm>.*||io;
	$hm =~ s|^.*>||io;
	$h_hm = sprintf("%s<hm>%s</hm>", $h_hm, $hm); # 
    }
    $h_hm =~ s|> *|>|go;
    $h_hm =~ s| *<|<|go;
    return $h_hm;
}

sub get_hdwd
{
    my($e) = @_;
    my($hm, $hw, $h_hm);

    $hw = $e;
    $hw =~ s|&[spw][\.;]||goi;
    $hw =~ s|&middot[\.;]||goi;
    $hw =~ s|&sb[\.;]||goi;
    $hw =~ s|</h>.*||io;
    $hw =~ s|^.*>||io;

    return $hw;
}
sub get_entry_file
{
    my($fname) = @_;
    $entry_file = `cat $fname`;    
    $entry_file =~ s|\n| |go;	# 
    $entry_file =~ s|||go;
    $entry_file =~ s|(<[^>]*)$|$1 |o;
    $entry_file =~ s|</ENTRY> *|</entry>\n|goi;
    $entry_file =~ s| *<ENTRY|<entry|goi;
    $entry_file =~ s|\n\n|\n|go;
	
    $entry_file =~ s|&middot;|&w;|go;
    return $entry_file;
}
sub get_sortkey
{
    my($e) = @_;
    my($h);
    my($h2);
    my($hm);
    my($sk);
    my($psk);
    $hm = "";
    $h = "";

    if ($e =~ /<ENTRY[^<]*SK=\"?([A-Z0-9a-z ]+)/i)
    {
	$usersk = $1;
	# it can go screwy if this is mixed case here so we need to put in
	# a double sortkey
	$usersk =~ s| *||go;
	$sk2 = $usersk;

	$sk2 =~ tr|A-Z|a-z|;
	$sk = sprintf("%-25s%-5s", $sk2, $usersk);

	return $sk;
    }
    $e =~ s|</?hs>||goi;
    $e =~ s|<ht>|<h>|goi;
    $e =~ s|</ht>|</h>|goi;
    $e =~ s|<hti>.*?</hti> *| |goi;

	
    if ($e =~ m|<h>(.*?)</h>|i)
    {
	$h = $1;
    }
    if ($e =~ m|<hm>(.*?)</hm>|i)
    {
	$hm = $1;
    }
    $h =~ s|&[spw]b?;||go;
    $h =~ s|&middot;||go;
    $h =~ s|&trade;||go;
    $h =~ s|&thinsp;||go;
    $h =~ s|&[lr][sd]quo;||goi;

    $h =~ s|&[spw];||go;
    $h =~ s|&(.).*?;|$1|go;
    $h =~ s|^the ||oi;
    $h2 = $h;
    $h2 =~ s|<.*?>||go;
    if ($h2 =~ s|^\-+||o)
    {
	$h2 = sprintf("%s-", $h2);
    }
    $h =~ s|<hr>.*?</hr> *| |goi;
    $h =~ s|^\-*||o;
    $h =~ s|\-||go;
    $h =~ s|,.*||o;
    $h =~ s|[^a-zA-Z0-9]||go;           
    $h =~ tr|A-Z|a-z|;
    $psk = sprintf("%s#%s#%s", $h, $h2, $hm);
    $sk = sprintf("%-25s%-5s%-25s", $h, $h2, $hm);
    return $sk;
}
