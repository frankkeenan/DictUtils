#!/usr/local/bin/perl

while (<>)

{
    s|\r||g;

#   convert the IPA first ...

    &convert_ipa;


#   then the rest ...

    s|&#x00B0;|&deg;|g;
    s|&#x00B7;|&w;|g;
    s|&#x00BD;|&half;|g;
    s|&#x00E9;|&eacute;|g;
    s|&#x02C8;|&p;|g;
    s|&#x02CC;|&s;|g;
    s|&#x2002;|&ensp;|g;
    s|&#x2003;|&emsp;|g;
    s|&#x2009;|&thinsp;|g;
    s|&#x2014;|&mdash;|g;
    s|&#x2019;|&rsquo;|g;
    s|&#x201C;|&ldquo;|g;
    s|&#x201D;|&rdquo;|g;
    s|&#x2026;|&hellip;|g;
    s|&#x2122;|&trade;|g;
    s|&#x2194;|&pvarr;|g;
    s|&#x21E8;|&xrefarrow;|g;
    s|&#x25C7;|&xsep;|g;

    print;

}

########################################

sub convert_ipa
{
    my(@BITS);
    my($bit);
    my($res);
    my($splits);
    $splits ="(eph|i|phon-gb|phon-us|y)";
    s/<$splits([ >])/&split;$&/goi;
    s/<\/$splits>/$&&split;/goi;
    @BITS = split(/&split;/);
    foreach $bit (@BITS)
    {
	if ($bit =~ /<$splits([ >])/i)
	{
	    $bit =~ s|&#x00E6;|&amp;|g;	# ae lig
	    $bit =~ s|&#x014B;|N|g;	# n with hook
	    $bit =~ s|&#x0251;|A|g;	# closed lower case a
	    $bit =~ s|&#x0252;|Q|g;	# upside down closed lower case a
	    $bit =~ s|&#x0254;|O|g;	# upside down c
	    $bit =~ s|&#x0259;|\@|g;	# upside down e
	    $bit =~ s|&#x025B;|E|g;	# reversed 3-like character ???
	    $bit =~ s|&#x025C;|3|g;	# 3-like character
	    $bit =~ s|&#x0261;|g|g;	# g-like character
	    $bit =~ s|&#x026A;|I|g;	# dotless I
	    $bit =~ s|&#x0283;|S|g;	# long S
	    $bit =~ s|&#x028A;|U|g;	# u-like character
	    $bit =~ s|&#x028C;|V|g;	# upside down v
	    $bit =~ s|&#x0292;|Z|g;	# long tailed z
	    $bit =~ s|&#x02C8;|"|g;	# primary stress	
	    $bit =~ s|&#x02CC;|%|g;	# secondary stress
	    $bit =~ s|&#x02D0;|:|g;	# colon character
	    $bit =~ s|&#x03B8;|T|g;	# lower case theta chacater
	}
	$res .= $bit;
    }
    $_ = $res;
}

########################################

