#!/usr/local/bin/perl
use Getopt::Std;

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator

&main;

sub main
{
    getopts('uf:IOl:');
    $lct = 0;
    $Found{"alpha_start"} = 1;
    $Found{"runhd"} = 1;
    printf("<batch>\n<alpha_start>Aa</alpha_start>\n"); 
    unless ($opt_l)
    {
	$opt_l = 500;
    }
	if ($opt_l = 1)
	{
		$opt_l = 0;
	}
line:
    while (<>) 
    {
	chomp;			# strip record separator
	next line unless (m|<entry|);
	s|</?batch[^>]*>||g;
	if (m|^ *$|)
	{
	    next line;
	}
#	tr|A-Z|a-z|;
	if (m|(<h[ >].*?)</h>|i)
	{
	    $h = $1;
	    $h =~ s|<.*?>||gi;
	}
	$lct++;
	undef %LCFound;
	undef %LFound;
	unless (m|</entry>|)
	{
	    $_ = &get_more($_);
	}
	$cp = $_;
	$cp =~ s|<nl */>|\n|g;
	if ($ct++ < $opt_l)
	{
	    printf("%s\n", $cp); 
	}
	s|<!--.*?-->||go;	
	s|<\?\".*?>||gio;
	# open before open tags
	s|(<[^/])|&split;$1|go;			
	s|(</[^>]*>)|$1&split;|gio; # close after closers
	$p = 0;
	@TAGS = split(/&split;/);	
      loop: 
	foreach $tag (@TAGS)
	{
	    $tagname = "";
	    if ($tag =~ m|<[^/]|)
	    {
		$tagname = $tag;
		$tag =~ s|<|\{|g;
		$tag =~ s|>|\}|g;
		$tagname =~ s|[ >].*||o;
		$tagname =~ s|<||o;
		unless ($Found{$tagname})
		{
		    $p = 1;
		    $Found{$tagname} = 1;
		    $TAG_EG{$tagname} = sprintf("<entry><h>$tagname</h><z> used for text [</z>$tag<z>] inside entry </z><ei>$h</ei></entry>"); 
		    $TAG_ENTRY{$tagname} = $cp;
		}
	    }	    	    
	    if ($tag =~ /&/)
	    {
		$tag =~ s|&|&split;&|go;
		@ENTS = split(/&split;/, $tag);		
	      entloop: 
		foreach $ent (@ENTS)
		{			
		    next entloop unless ($ent =~ /&/);
		    $ent =~ s|;.*|;|o; 
		    $entname = $ent;
		    $entname =~ s|[&;]||g;
		    unless ($Found{$entname})
		    {
			$p = 1;
			$Found{$entname} = 1;
			$ENT_EG{$entname} = sprintf("<entry><h>$entname</h><z> used for text [</z>$ent<z>] inside entry </z><ei>$h</ei></entry>"); 
			$ENT_ENTRY{$entname} = $cp;
		    }
		}			# 
	    }			# 
	}
    }    
    $e =~ s|<nl />|\n|g;
    printf("<entry><h>TAG SAMPLES</h></entry>\n\n"); 
    foreach $tag (sort keys %TAG_EG)
    {
	printf("%s\n", $TAG_EG{$tag}); 
	$e = $TAG_ENTRY{$tag};
	if ($e =~ m|(<h>.*?</h>)|i)
	{
	    $h = $1;
	    unless ($h eq $last_h)
	    {
		printf("%s\n\n", $e); 
	    }
	    $last_h = $h;
	}
	else
	{
	    printf("%s\n\n", $e); 
	    $last_h = "";
	}
    }
    $last_h = "";
    foreach $ent (sort keys %ENT_EG)
    {
	printf("%s\n", $ENT_EG{$ent}); 
	$e = $ENT_ENTRY{$ent}; 
	if ($e =~ m|(<h>.*?</h>)|i)
	{
	    $h = $1;
	    unless ($h eq $last_h)
	    {
		printf("%s\n\n", $e); 
	    }
	    $last_h = $h;
	}
	else
	{
	    printf("%s\n\n", $e); 
	    $last_h = "";

	}
    }
    printf("</batch>\n"); 
}

sub get_more
{
    my($e) = @_;
    my($res);
    $res = sprintf("%s<nl />", $e);
    while (<>)
    {
	chomp;
	if (m|</entry>|)
	{
	    $res = sprintf("%s%s", $res, $_);
	    return($res);
	}
	else
	{
	    $res = sprintf("%s%s<nl />", $res, $_);
	}
    }
}
