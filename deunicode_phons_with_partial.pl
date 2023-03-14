#!/usr/local/bin/perl

&load_phon_unicode;

sub phon_ents
{
    my($e) = @_;
    my @BITS;
    my $bit, $res;
    my $phon, $phon2;
    my $otag, $ctag;
    my $partial_start;

    $e =~ s|(<eph .*?</eph>)|&split;&fk;$1&split;|gio;
    $e =~ s|(<eph>.*?</eph>)|&split;&fk;$1&split;|gio;
    $e =~ s|(<[iy] .*?</[iy]>)|&split;&fk;$1&split;|gio;
    $e =~ s|(<[iy]>.*?</[iy]>)|&split;&fk;$1&split;|gio;

    $e =~ s|(<phon-gb .*?</phon-gb>)|&split;&fk;$1&split;|gio;
    $e =~ s|(<phon-gb>.*?</phon-gb>)|&split;&fk;$1&split;|gio;
    $e =~ s|(<phon-us .*?</phon-us>)|&split;&fk;$1&split;|gio;
    $e =~ s|(<phon-us>.*?</phon-us>)|&split;&fk;$1&split;|gio;

    @BITS = split(/&split;/, $e); 
    $res = "";
    foreach $bit (@BITS) 
    {
	if ($bit =~ s|&fk;||gio)
	{
	    $bit =~ s|<(eph)>|<$1 >|gio;
	    $bit =~ s|<([iy])>|<$1 >|gio;
	    $bit =~ s|<(phon-gb)>|<$1 >|gio;
	    $bit =~ s|<(phon-us)>|<$1 >|gio;
	    $bit =~ s|</?z.*?>||gio;
#	    if ($bit =~ m|^(.*?>)(.*?)(</[iy]>)|io)
	    if ($bit =~ m/^(.*?>)(.*?)(<\/(eph|i|y|phon-gb|phon-us)>)/io)
	    {
		$otag = $1;
		$phon = $2;
		$ctag = $3;
		
#   hide the partial tags for now ...
		$partial_start="";		
		$phon =~ s|<partial(.*?)>|\{|;
		$partial_start=$&;
		$phon =~ s|</partial>|\}|;

		foreach my $code (keys %PHONUCODE) {
		    $phon =~ s|$code|$PHONUCODE{$code}|gi;
		}

		$phon =~ s|&|&amp;|gio;
#		$phon =~ s|-|&nbhyph;|gio;
		$phon =~ s|X|&tusipa;|gio;
#		$phon =~ s|\"|&ldquo;|gio;
#		$phon =~ s|\"|&rdquo;|gio;

#   reinstate the partial tags ...
		$phon =~ s|\{|$partial_start|;
		$phon =~ s|\}|</partial>|;
	    }
	    $bit = sprintf("%s%s%s", $otag, $phon, $ctag);
	}
	$res .= $bit;
    }
    return $res;
}

sub load_phon_unicode
{
    $PHONUCODE{"&#x2011;"} = "-";
    $PHONUCODE{"&#x00E6;"} = "&";
    $PHONUCODE{"&#x025C;"} = "3";
    $PHONUCODE{"&#x0025;"} = "6";
    $PHONUCODE{"&#x02d0;"} = ":";
    $PHONUCODE{":"} = ";";
    $PHONUCODE{"&#x02D0;"} = ";";
    $PHONUCODE{"&#x0259;"} = "\@";
    $PHONUCODE{"&#x0251;"} = "A";
    $PHONUCODE{"&#x00F0;"} = "D";
    $PHONUCODE{"&#x025B;"} = "E";
    $PHONUCODE{"&#x02D0;"} = "F";
#    $PHONUCODE{":"} = "F";
    $PHONUCODE{"&#x026A;"} = "I";
#    $PHONUCODE{"&#x0259;"} = "J";
    $PHONUCODE{"&#x014B;"} = "N";
    $PHONUCODE{"&#x0254;"} = "O";
    $PHONUCODE{"&#x0252;"} = "Q";
    $PHONUCODE{"&#x0283;"} = "S";
#    $PHONUCODE{"&#x0275;"} = "T";
    $PHONUCODE{"&#x03B8;"} = "T";
    $PHONUCODE{"&#x028A;"} = "U";
    $PHONUCODE{"&#x028C;"} = "V";
    $PHONUCODE{"&#x025C;"} = "W";
    $PHONUCODE{"&#x0292;"} = "Z";
    $PHONUCODE{"&#x0261;"} = "g";
    $PHONUCODE{"&#x0074;&#x032E;"} = "X"; # flap t
    $PHONUCODE{"&#x02C8;"} = "\"";
    $PHONUCODE{"&#x02CC;"} = "%";
    $PHONUCODE{"&#x0303;"} = "~";
}


1;
