# package std;    # Needed for use v5.14

$FLAG = '&SIH-FLAG;';
$F_ELEM = '&SIH-ELEM;';
$F_SEP = '&SIH-SPLIT;';
$F_COMM = 'SIH-COMM';
$F_PI = 'SIH-PI';


sub entize {
    return "&".shift()."-".shift().";";
}


sub elemize {
    return "<".shift()." num=\"".shift()."\"/>";
}


sub hide_pis {

    my $hide_proc = (shift() ? \&elemize : \&entize);

    @PIS = ();

    my $i = 0;
    while (s|(<\?[^>]*?\?>)|&$hide_proc($F_PI, $i)|ioe) {
	$PIS[$i++] = $1;
    }
}


sub hide_comments_0 {

    my $hide_proc = (shift() ? \&elemize : \&entize);

    @COMMENTS = ();

    my $i = 0;
    while (s|(<!--.*?-->)|&$hide_proc($F_COMM, $i)|ioe) {
	$COMMENTS[$i++] = $1;
    }
}


sub hide_comments {

    $use_elems = shift();
    my $hide_proc = ($use_elems ? \&elemize : \&entize);

    &hide_pis($use_elems) if shift();

    @COMMENTS = ();

    my $i = 0;
    my $in_comment = 0;
    my $comment;
    my $this;

    s|(-->)|$F_SEP$1$F_SEP|gi;
    s|(<!--)|$F_SEP$1$F_SEP|gi;

    my @BITS;
  bit:
    foreach (@BITS = split /$F_SEP/) {

	$this = $_;

	if ($in_comment) {

	    $COMMENTS[$i] =~ s|$|$_|;

	    if (s|^-->$||) {

		--$in_comment or $i++;
		next bit;
	    }

	    $this = "";
	}

	if (m|^<!--$|) {

	    unless ($in_comment) {
		$COMMENTS[$i] = $_;
		$this = &$hide_proc($F_COMM, $i);
	    }

	    $in_comment++;
	}

	$_ = $this;
    }

    $_ = join("", @BITS);
}


sub restore_pis {

    s|<$F_PI num="([0-9]+)"/>|$PIS[$1]|gie or
	s|&$F_PI-([0-9]+);|$PIS[$1]|gie;
}


sub restore_comments {

    unless (shift()) {
	foreach (@COMMENTS) {
	    s|--|==|go;
	    s|==|--|o;
	    s|(.*)==|$1--|o;
	}
    }

    s|<$F_COMM num="([0-9]+)"/>|$COMMENTS[$1]|gie or
	s|&$F_COMM-([0-9]+);|$COMMENTS[$1]|gie;

    &restore_pis if @PIS;
}


sub zap_comments {

    my $in_comment = 0;

    s|(-->)|$F_SEP$1$F_SEP|gi;
    s|(<!--)|$F_SEP$1$F_SEP|gi;

    my @BITS;
  bit:
    foreach (@BITS = split /$F_SEP/) {

	if ($in_comment and s|^-->$||) {
	    $in_comment--;
	    next bit;
	}

	$in_comment++ if (m|^<!--$|);

	$_ = "" if $in_comment;
    }

    $_ = join("", @BITS);
}


sub new_comment {

    my $comment = shift();
    my $hide_proc = ($use_elems ? \&elemize : \&entize);

    $comment =~ tr|<>|{}|;
    push @COMMENTS, "<!-- $comment -->";

    return &$hide_proc($F_COMM, $#COMMENTS);
}


sub get_hdwd0 {

    my($h) = @_;

    for ($h) {

	s|&ob;|/|go;
	s|&hellip;|...|go;
	s|&pvarr;| |go;

	s|&#x002F;|/|gio;
	s|&#x2026;|...|gio;
	s|&#x2194;| |gio;

	s|&#x201[89];|'|go;

	s|,|#|go;

	$_ = &get_hdwd($_);

	s|#|,|go;
    }

    return $h;
}


sub get_hdwd1 {

    my($h) = @_;

    for ($h) {

	s|<| <|go;
	s|>|> |go;

	$_ = &get_hdwd0($_);

	s|^ +||o;
	s| +$||o;
	s|  +| |go;

	s| ?- ?|-|go;
	s| ?/ ?|/|go;
    }

    return $h;
}


sub open_log {

    my($utf8) = @_;

    open(LOG_FP, ">$0.log") || die "Unable to open >$0.log"; 
    binmode(LOG_FP, ":utf8") if $utf8;
}


sub close_log {

    close(LOG_FP);
}


sub write_log {

    print LOG_FP @_;
}


sub elem {

    my($name,$atts,@cont) = @_;

    my(@atts) = map {$_ = "$_='$$atts{$_}'"} keys %$atts;

    if (@cont) {
	return (join " ", "<$name", @atts) . ">" . (join "", @cont)  . "</$name>";
    } else {
	return (join " ", "<$name", @atts) . "/>";
    }
}


# sub elem {

#     my($name,$atts,$cont) = @_;

#     if (defined $cont) {
# 	return (join " ", "<$name", @$atts) . ">" . (join "", @$cont)  . "</$name>";
#     } else {
# 	return (join " ", "<$name", @$atts) . "/>";
#     }
# }


sub wrap {

    my($group,@elemlist) = @_;

    s|£|&#x00A3;|gio;

    foreach my $elem (@elemlist) {
	s|(<$elem[ >].*?</$elem>)|<$group>£$1</$group>£|gi;
	s|(<$elem(?=[ />])[^>]*?/>)|<$group>£$1</$group>£|gi;
    }

    1 while (s|(<$group>£[^£]*)<$group>£([^£]*)</$group>£|$1$2|i
		 or s|<$group>£([^£]*)</$group>£([^£]*</$group>£)|$1$2|i);

    s|£||gio;

    s|</$group>\s*<$group>||gi;
}


sub unwrap {

    my($group,@elemlist) = @_;
    my($ename,@BITS,$contents0,$content1);

    if (s|(<$group[ >].*?</$group>)|$F_SEP$F_ELEM$1$F_SEP|gi) {

	foreach (@BITS = split /$F_SEP/) {

	    if (s|$F_ELEM||gio) {

		($contents0 = $_) =~ s|^<[^>]+>||i;
		$contents0 =~ s|</[^>]+>$||i;
		$contents1 = $contents0;

		foreach $ename (@elemlist) {
		    $contents1 =~ s|<$ename[ >].*?</$ename>||gi;
		    $contents1 =~ s|<$ename(?=[ >])[^>]*/>||gi;
		}

		$_ = $contents0 if $contents1 =~ m|^\s*$|o;
	    }
	}
	$_ = join "", @BITS;
    }
}


sub shuffle {

    my($inout,$leftright,$tag,@elemlist) = @_;
    my($shuffleproc,@BITS,$head,$tail);

    if ($leftright eq left) {
	$shuffleproc = \&lshuffle;
    } elsif ($leftright eq right) {
	$shuffleproc = \&rshuffle;
    } else {
	return;
    }

    $head = $tail = "";

    if ($inout eq out) {

	if (s|(<$tag[ >].*?</$tag>)|$F_SEP$F_ELEM$1$F_SEP|gi) {

	    foreach (@BITS = split /$F_SEP/) {

		if (s|$F_ELEM||gio) {

		    foreach $elem (@elemlist) {
			s|(<$elem[ >].*?</$elem>)|$F_SEP$F_ELEM$1$F_SEP|gi;
			s|(<$elem(?=[ />])[^>]*?/>)|$F_SEP$F_ELEM$1$F_SEP|gi;
		    }

		    &$shuffleproc;
		}
	    }

	    $_ = join "", @BITS;
	}

    } elsif ($inout eq in) {

	if (s|(<$tag(?=[ >])[^>]*>)(.*?)(</$tag>)|$1$F_SEP$F_ELEM$2$F_SEP$3|gi) {

	    @BITS = split /$F_SEP/;

	    $head = shift @BITS unless $leftright eq right;
	    $tail = pop @BITS unless $leftright eq left;

	    foreach (@BITS) {

		unless (s|$F_ELEM||gio) {

		    foreach $elem (@elemlist) {
			s|(<$elem[ >].*?</$elem>)|$F_SEP$F_ELEM$1$F_SEP|gi;
			s|(<$elem(?=[ />])[^>]*?/>)|$F_SEP$F_ELEM$1$F_SEP|gi;
		    }

		    &$shuffleproc;
		}
	    }

	    $_ = join "", $head, @BITS, $tail;
	}

    } else {
	return;
    }
}


sub lshuffle {

    my($tag,@BITS,$shuffled);

    $tag = (s|(<[^>]+>)||o ? $1 : "");
    $shuffled = "";

  lshuffle_bit:
    foreach (@BITS = split /$F_SEP/) {

	if (s|$F_ELEM||gio) {

	    $shuffled =~ s|$|$_|;
	    $_ = "";

	    next lshuffle_bit;
	}

	last lshuffle_bit unless m|^\s*$|o;
    }

    $_ = join "", @BITS;
    s|$F_ELEM||gio;

    s|^|$shuffled$tag|;
}


sub rshuffle {

    my($tag,@BITS,$shuffled);

    s|(<[^>]+>)$||o and $tag = $1;

  rshuffle_bit:
    foreach (@BITS = reverse split /$F_SEP/) {

	if (s|$F_ELEM||gio) {

	    $shuffled =~ s|^|$_|;
	    $_ = "";

	    next rshuffle_bit;
	}

	last rshuffle_bit unless m|^\s*$|o;
    }

    $_ = join "", reverse @BITS;
    s|$F_ELEM||gio;

    s|$|$tag$shuffled|;
}


# Usage example for the two subs following.
#
# In <tcfe>s inside <p-g>s, change <tam> to <tobj> and <tamb> to <topt>.
#
#     &cic(sub {
# 	     &change_elems(
# 		 tam => "tobj",
# 		 tamb => "topt",
# 	     )
# 	 }, 
# 	 qw|p-g tcfe|
#      );


sub cic {

    # code/command in context
    # ^   /^       ^  ^

    my($func,@context) = @_;
    my($ename,@BITS,@res);

    if (@context) {

	$ename = shift @context;

	if (s|(<$ename[ >].*?</$ename>)|$F_SEP$F_ELEM$1$F_SEP|gi 
		or s|(<$ename(?=[ >])[^>]*/>)|$F_SEP$F_ELEM$1$F_SEP|gi) {

	    foreach (@BITS = split /$F_SEP/) {

		push @res, &cic($func, @context) if s|$F_ELEM||gio;
	    }

	    $_ = join "", @BITS;
	}

    } elsif (defined $func) {

	push @res, &$func;
    }

    return @res;
}


sub change_elems {

    my(@names) = @_;
    my($old,$new);

    s|(</?)$old([ />])|$1$new$2|gi 
	while (($old, $new) = splice(@names, 0, 2));
}


sub change_att {

    my($name,$vals,$delete) = @_;
    my($old,$new);

    ($old,$new) = %$name;
    $new ||= $old;

    if (%$vals) {
	if ($delete) {
	    s| $old=(["'])(.*?)\1|($$vals{$2} ? " $new=$1$$vals{$2}$1" : "")|ie;
	} else {
	    s| $old=(["'])(.*?)\1|" $new=$1" . ($$vals{$2} or $2) . $1|ie;
	}
    } else {
	s| $old=| $new=|i;
    }
}


1;
