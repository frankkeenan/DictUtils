#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
#use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $opt_d, %W);
require "/NEWdata/dicts/generic/progs/utils.pl";
require "/NEWdata/dicts/generic/progs/restructure.pl";

use Getopt::Std;
$LOG = 1;

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator

&main;

sub main
{
    
    $NonPaired{"np"} = 1;
    $NonPaired{"zp"} = 1;
    getopts('eon:us');
    if ($opt_u)
    {
	printf(STDERR "Usage: $0 [-e] [-n]\n"); 
	printf(STDERR "-s: Work out the single tags to avoid\n"); 
	printf(STDERR "-e: list the error lines\n"); 
	printf(STDERR "-o: list the lines with overlapping tags\n"); 
	printf(STDERR "-n: list of tags not paired (e.g -n \"<np><zp>\"\n"); 
	printf(STDERR "\n"); 
	exit;
    }
    if ($opt_n)
    {
	$ncp = $opt_n;
	$ncp =~ s|<|&split;<|go;
	@TAGS = split(/&split;/, $ncp);
	foreach $tag (@TAGS)
	{
	    if ($tag =~ /<(.*?)>/)
	    {
		$NonPaired{$1} = 1;	
		$IGNORE{$1} = 1;	
	    }
	}
    }
    &open_debug_files;

    while (<>)
    {
	chomp;			# strip record separator
	s|<!--.*?-->||g;
	s|<\?xm-replace_text[^>]*\?>||gi;
	s|<\?xml .*?>||gi;
	s|<\?xm-replace_text .*?>||gi;
	s|<!DOCTYPE.*?>||gio;
	s|</?batch>||gio;
	s|(<([^ >]*) [^>]*)/>|$1></$2>|gi;
	$LINE[$i++] = $_;
	&count_tags;
    }

    &report_tag_count;
    &report_ent_count;
    &report_where;
    if (($opt_e) || ($opt_o))
    {
	for ($lct=0; $lct <= $#LINE; $lct++)
	{
	    $_ = $LINE[$lct];
	    $lnum = $lct + 1;
	    if ($opt_e)
	    {
		&list_balance_errs;
	    }
	    if ($opt_o)
	    {
		&check_overlap($_);
	    }
	}    
	if ($ERRS)
	{
	    # don't bother if already seen the errors
	    unless ($opt_e)
	    {
		printf(STDERR "Run with \n\t%s -e -n \"%s\"", $0, $except); 
		foreach $arg (@ARGV)
		{
		    printf(STDERR "%s ", $arg); 
		}
		printf(STDERR "\n"); 
	    }
	}
	unless ($WARNINGS =~ /^ *$/)
	{
	    printf("Tags and entities share the same name\n%s", $WARNINGS); 
	}
    }
    &close_debug_files;
}

sub report_where
{
    printf("\nFirst Instances of tags\n"); 
    printf("-----------------------\n"); 
    foreach $tag (sort keys %FIRST_H)
    {
	$eid = $FIRST_EID{$tag};
	printf("%s\t%s\t%s\n", $tag, $eid, $FIRST_H{$tag}); 
	unless ($P{$eid}++)
	{
	    printf(log_fp "%s\n", $FIRST_EID{$tag}); 
	}
    }
}

sub spot_mismatch
{
    my($e, $tag) = @_;
    my($bit, $res, $cct, $oct);
    my(@BITS);
    $tag =~ s|[<>]||gio;
    $e =~ s|<$tag>|<$tag >|gi;
    $e =~ s|(<$tag .*?>)|&split;&fk;$1&split;|gi;
    $e =~ s|(</$tag>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    $prev = 2;
    foreach $bit (@BITS)
    {
	if ($bit =~ s|&fk;||gio)
	{
	    if ($bit =~ m|</|)
	    {
		unless ($prev == 1)
		{
		    $bit = sprintf("<\#\#\[>%s", $bit);
		}
		$prev = 2;
	    }
	    else
	    {
		unless ($prev == 2)
		{
		    $bit = sprintf("<\]\#\#>%s", $bit);
		}
		$prev = 1;
	    }
	}
	$res .= $bit;
    }
    if ($prev == 1)
    {
	$res =~ s|^(.*)(<$tag )|$1<\#\#\[>$2|i;
    }
    $res =~ s| +>|>|gio;
    return $res;
}

sub check_overlap
{
    my($e) = @_;
    $_ = $e;
    s|>| >|gi;
    foreach $tag (sort keys %IGNORE) 
    {
	s|<($tag [^>]*)>|&_ot;$1&_ct;|gi;
	s|<(/$tag [^>]*)>|&_ot;$1&_ct;|gi;
    }
    s|\{|&obrace;|gi;
    s|\}|&cbrace;|gi;
    while (s|<([^/ ]*)( [^>]*)>([^<]*)</\1 >|&_ot;$1$2&_ct;$3&_ot;/$1&_ct;|i)
    {
    }

    if (m|<|)
    {
	s|<|<#|gio;
	s|&_ot;|<|gio;
	s|&_ct;|>|gio;
	s| *>|>|gio;
	s|&obrace;|\{|gio;
	s|&cbrace;|\}|gio;
	s|<\#entry>|<entry>|gio;
	s|<\#/entry>|</entry>|gio;
	printf("TAG OVERLAP: (line %d) %s\t%s\t(%s\t%s)\n", $lnum, $tag, $ct);
	printf("%s\n\n", $_); 
    }
}

sub list_balance_errs
{
    # want to see the indivual lines having errors
    foreach $tag (sort (keys %LFound)) {
	$ct = $LFound{$tag};
	$cct = $LCFound{$tag};
	$act_tag = $tag;
	unless ($NonPaired{$tag})
	{
	    if ($ct != $cct)
	    {
		$ctag = sprintf("</%s>", $tag);
		$tag = sprintf("<%s>", $tag);
		printf("TAG MISMATCH: (line %d) %s\t%s\t(%s\t%s)\n", $lnum, $tag, $ct, $ctag, $cct);
		$cp2 = &spot_mismatch($cp, $tag);
		printf("%s\n\n", $cp2); 
	    }
	}
    }
    # use these two arrays for individual line checks
    undef %LCFound;
    undef %LFound;
}

sub count_tags
{
    undef %LCFound;
    undef %LFound;
    $cp = $_;

    s|<!--.*?-->||go;
    $h = &get_hdwd($_);
    $eid = &get_entry_id($_);
    return if (m|<entry[^>]*del=\"y|io);
    # remove the marker from 3B2 to get the PDF letter headings
    s|<\?[^>]*>||g;

#	s|_|&uscore;|gio;
    s|<|&split;<|go;			
    @TAGS = split(/&split;/);	
    
  loop: 
    foreach $tag (@TAGS)
    {
	$tagname = "";
	if ($tag =~ /</)
	{
	    $tagname = $tag;
	    $tagname =~ s|[ >].*||o;
	    $tagname =~ s|</?||o;
	    $tagname =~ s|&uscore;|_|o;
	    $is_closer = ($tag =~ m|</|);
	    
	    if ($is_closer)
	    {
		++$CFound{$tagname};
		++$LCFound{$tagname};
	    }
	    else
	    {
		unless ($Found{$tagname})
		{
		    $FIRST_EID{$tagname} = $eid;
		    $FIRST_H{$tagname} = $h;
		}
		++$Found{$tagname};
		++$LFound{$tagname};
	    }
	}
	
	# don't do entities for phonetics fields
	next loop if $tagname =~ /i *$/i;
	next loop if $tagname =~ /y *$/i;
	next loop if $tagname =~ /ph *$/i;
	
	if ($tag =~ /&/)
	{
	    $tag =~ s|&|&split;&|go;
	    @ENTS = split(/&split;/, $tag);
	    
	  entloop: 
	    foreach $ent (@ENTS)
	    {			
		next entloop unless ($ent =~ /&/);
		$ent =~ s|[\.; ].*||o; # allow for ref comp and proper entities
		++$EntFound{$ent};
	    }			# 
	}			# 
    }
}

sub report_tag_count
{
    printf("TAGS and their frequencies\n");
    printf("--------------------------\n");
    foreach $tag (sort (keys %Found)) {
	$TAGERR = 0;
	$ct = $Found{$tag};
	$cct = $CFound{$tag};
	$act_tag = $tag;
	if ($NonPaired{$tag})
	{
#	    $cct = $ct;
	}
	$tag =~ s|&uscore;|_|gio;
	if ($ct != $cct)
	{
	    if ($cct == 0)
	    {
		$except = sprintf("%s<%s>", $except, $tag);
		$NonPaired{$tag} = 1;	
		$IGNORE{$tag} = 1;	
		
	    }
	    else
	    {
		$ERRS = 1;
		$TAGERR = 1;
	    }
	}
	$ctag = sprintf("</%s>", $tag);
	$tag = sprintf("<%s>", $tag);
	if ($TAGERR)
	{
	    printf("%s#%s#%s#%s#!!!!ERRS\n", $tag, $ct, $ctag, $cct);
	}
	else
	{
	    printf("%s#%s#%s#%s\n", $tag, $ct, $ctag, $cct);
	}
	$tagname = $tag;
	$tagname =~ s|[<>]||gio;
	$USEDTAG{$tagname} = 1;
    }
}

sub report_ent_count
{
    printf("\nENTITIES and their frequencies\n");
    printf("------------------------------\n");
    
    foreach $ent (sort (keys %EntFound))
    {				
	$ct = $EntFound{$ent};	
	$ent = sprintf("%s;", $ent);
	$entname = $ent;
	$entname =~ s|[&;]||gio;

	if ($USEDTAG{$entname})
	{
	    $WARNINGS = sprintf("%s%s\n", $WARNINGS, $entname);
	}

	unless ($ent =~ m|&uscore;|io)
	{
	    printf "%s#%s\n", $ent, $ct;
	}
    }				
}
