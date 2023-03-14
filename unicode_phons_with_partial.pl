#!/usr/local/bin/perl

&load_phon_unicode;

sub phon_ents
    {
	my($e) = @_;
	my(@BITS);
	my($bit, $res);
	my($phon, $phon2);
	my($otag, $ctag);
	my(@CHARS);
	my($tname);

	#     $e =~ s|(<eph .*?</eph>)|&split;&fk;$1&split;|gio;
	#     $e =~ s|(<eph>.*?</eph>)|&split;&fk;$1&split;|gio;
	#     $e =~ s|(<[iy] .*?</[iy]>)|&split;&fk;$1&split;|gio;
	#     $e =~ s|(<[iy]>.*?</[iy]>)|&split;&fk;$1&split;|gio;

	#     $e =~ s|(<phon-gb .*?</phon-gb>)|&split;&fk;$1&split;|gio;
	#     $e =~ s|(<phon-gb>.*?</phon-gb>)|&split;&fk;$1&split;|gio;
	#     $e =~ s|(<phon-us .*?</phon-us>)|&split;&fk;$1&split;|gio;
	#     $e =~ s|(<phon-us>.*?</phon-us>)|&split;&fk;$1&split;|gio;
	#     $e =~ s|(<phon[ >].*?</phon>)|&split;&fk;$1&split;|gio;

	# SIH 21.11.13: The above catches a self-closing tag followed by 
	# arbitrary amounts of data and then a pair of opening and closing 
	# tags of the same element type.  (In the case of [iy], they might 
	# each be of either type - should capture the character matched and 
	# use \2 to ensure they're the same, or use a variable, as below.)

	foreach $tname (qw|eph i y phon-gb phon-us phon|) {
	    $e =~ s|(<$tname(?=[ >])[^>]*(?<!/)>.*?</$tname>)|&split;&fk;$1&split;|gi;
	}

	@BITS = split(/&split;/, $e); 
	$res = "";
	foreach $bit (@BITS) {
	    if ($bit =~ s|&fk;||gio) {
		$bit =~ s|<(eph)>|<$1 >|gio;
		$bit =~ s|<([iy])>|<$1 >|gio;
		$bit =~ s|<(phon)>|<$1 >|gio;
		$bit =~ s|<(phon-gb)>|<$1 >|gio;
		$bit =~ s|<(phon-us)>|<$1 >|gio;
		$bit =~ s|</?z.*?>||gio;
		#	    if ($bit =~ m|^(.*?>)(.*?)(</[iy]>)|io)
		if ($bit =~ m/^(.*?>)(.*?)(<\/(eph|i|y|phon|phon-gb|phon-us)>)/io) {
		    $otag = $1;
		    $phon = $2;
		    $ctag = $3;
		
		    #   hide the partial tags for now ...
		    @partial_tags = ();

		    while ($phon =~ s/(<\/?(?:partial|ptl)(?=[ >])[^>]*>)/\{\}/) {
			push @partial_tags, $1;
		    }

		    $phon =~ s|&nbhyph.*?;|-|gio;
		    $phon =~ s|&#x0026;|&|gio;
		    $phon =~ s|&amp;|&|gio;
		    $phon =~ s|&tusipa;|X|gio;
		    $phon =~ s|&ldquo[:;]|\"|gio;
		    $phon =~ s|&rdquo[:;]|\"|gio;

		    $phon2 = "";
		    @CHARS = split(//, $phon); 
		    foreach $ch (@CHARS) {
			if ($PHONUCODE{$ch}) {
			    $ch = $PHONUCODE{$ch};
			}
			$phon2 .= $ch;
		    }

		    #   reinstate the partial tags ...
		    foreach my $tag (@partial_tags) {
			$phon2 =~ s|\{\}|$tag|;
		    }
		}
		$bit = sprintf("%s%s%s", $otag, $phon2, $ctag);
		$bit =~ s| +>|>|go;
	    }
	    $res .= $bit;
	}
	$res =~ s|&#x(.*?);|&#x\U$1\E;|g;

	return $res;
    }

sub load_phon_unicode
    {
	$PHONUCODE{"-"} = "&#x2011;";
	$PHONUCODE{"6"} = "&#x0025;";
	$PHONUCODE{"&"} = "&#x00e6;";
	$PHONUCODE{"3"} = "&#x025c;";
	$PHONUCODE{"\@"} = "&#x0259;";
	$PHONUCODE{"A"} = "&#x0251;";
	$PHONUCODE{"D"} = "&#x00f0;";
	$PHONUCODE{"E"} = "&#x025b;";
	$PHONUCODE{"F"} = "&#x02d0;";
	#    $PHONUCODE{"F"} = ":";
	$PHONUCODE{"I"} = "&#x026a;";
	$PHONUCODE{"J"} = "&#x0259;";
	$PHONUCODE{"N"} = "&#x014b;";
	$PHONUCODE{"O"} = "&#x0254;";
	$PHONUCODE{"Q"} = "&#x0252;";
	$PHONUCODE{"S"} = "&#x0283;";
	#    $PHONUCODE{"T"} = "&#x0275;";
	$PHONUCODE{"T"} = "&#x03b8;";
	$PHONUCODE{"U"} = "&#x028a;";
	$PHONUCODE{"V"} = "&#x028c;";
	$PHONUCODE{"W"} = "&#x025c;";
	$PHONUCODE{"Z"} = "&#x0292;";
	$PHONUCODE{"g"} = "&#x0261;";
	$PHONUCODE{"X"} = "&#x0074;&#x032e;"; # flap t
	$PHONUCODE{"\""} = "&#x02cc;";
	$PHONUCODE{"%"} = "&#x02c8;";
	$PHONUCODE{"\""} = "&#x02c8;";
	$PHONUCODE{"%"} = "&#x02cc;";
	$PHONUCODE{"~"} = "&#x0303;";
	$PHONUCODE{":"} = "&#x02d0;";
	#    $PHONUCODE{";"} = ":";
	$PHONUCODE{";"} = "&#x02d0;";		
    }


1;
