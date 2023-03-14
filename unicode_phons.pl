#!/usr/local/bin/perl

&load_phon_unicode;

sub phon_ents
{
    my($e) = @_;
    my @BITS;
    my $bit, $res;
    my $phon, $phon2;
    my $otag, $ctag;
    my @CHARS;
    
    $e =~ s|<eph([ >])|<i$1|gio; # BC 21Oct04
    $e =~ s|</eph>|</i>|gio; # BC 21Oct04
    $e =~ s|(<[iy] .*?</[iy]>)|&split;&fk;$1&split;|gio;
    $e =~ s|(<[iy]>.*?</[iy]>)|&split;&fk;$1&split;|gio; # BC 15Sep04

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
	    $bit =~ s|<([iy])>|<$1 >|gio;
	    $bit =~ s|<(phon-gb)>|<$1 >|gio;
	    $bit =~ s|<(phon-us)>|<$1 >|gio;
	    $bit =~ s|</?z.*?>||gio;
#	    if ($bit =~ m|^(.*>)(.*?)(</[iy]>)|io)
	    if ($bit =~ m/^(.*>)(.*?)(<\/(i|y|phon-gb|phon-us)>)/io)
	    {
		$otag = $1;
		$phon = $2;
		$ctag = $3;		
		$phon =~ s|&nbhyph.*?;|-|gio;
		$phon =~ s|&#x0026;|&|gio;
		$phon =~ s|&amp;|&|gio;
		$phon =~ s|&tusipa;|X|gio;
		$phon =~ s|&ldquo[:;]|\"|gio;
		$phon =~ s|&rdquo[:;]|\"|gio;
		$phon2 = "";
		@CHARS = split(//, $phon); 
		foreach $ch (@CHARS) 
		{
		    if ($PHONUCODE{$ch})
		    {
			$ch = $PHONUCODE{$ch};
		    }
		    $phon2 .= $ch;
		}
	    }
	    $bit = sprintf("%s%s%s", $otag, $phon2, $ctag);
	}
	$res .= $bit;
    }
    return $res;
}

sub load_phon_unicode
{
    $PHONUCODE{"-"} = "&#x2011;";
    $PHONUCODE{"&"} = "&#x00E6;";
    $PHONUCODE{"3"} = "&#x025C;";
    $PHONUCODE{"6"} = "&#x0025;";
    $PHONUCODE{":"} = "&#x02d0;";
    $PHONUCODE{";"} = ":";
    $PHONUCODE{";"} = "&#x02D0;";
    $PHONUCODE{"\@"} = "&#x0259;";
    $PHONUCODE{"A"} = "&#x0251;";
    $PHONUCODE{"D"} = "&#x00F0;";
    $PHONUCODE{"E"} = "&#x025B;";
    $PHONUCODE{"F"} = "&#x02D0;";
#    $PHONUCODE{"F"} = ":";
    $PHONUCODE{"I"} = "&#x026A;";
    $PHONUCODE{"J"} = "&#x0259;";
    $PHONUCODE{"N"} = "&#x014B;";
    $PHONUCODE{"O"} = "&#x0254;";
    $PHONUCODE{"Q"} = "&#x0252;";
    $PHONUCODE{"S"} = "&#x0283;";
#    $PHONUCODE{"T"} = "&#x0275;";
    $PHONUCODE{"T"} = "&#x03B8;";
    $PHONUCODE{"U"} = "&#x028A;";
    $PHONUCODE{"V"} = "&#x028C;";
    $PHONUCODE{"W"} = "&#x025C;";
    $PHONUCODE{"Z"} = "&#x0292;";
    $PHONUCODE{"g"} = "&#x0261;";
    $PHONUCODE{"X"} = "&#x0074;&#x032E;"; # flap t
    $PHONUCODE{"\""} = "&#x02CC;";
    $PHONUCODE{"%"} = "&#x02C8;";
    $PHONUCODE{"\""} = "&#x02C8;";
    $PHONUCODE{"%"} = "&#x02CC;";
    $PHONUCODE{"~"} = "&#x0303;";
}


1;
