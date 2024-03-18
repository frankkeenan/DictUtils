require "/disk1/home/hughsoni/perl/lib/std.pl";


sub resolve_brackets {

    my($def) = @_;
    my(@defs,$phr,$newdef);

    for ($def) {

	s|\b(\w+)\s+\((.*?\betc\.?\s*)\)|$1, $2|gio;

	if (s|\((.*?)\)|$FLAG|o) {

	    for ($phr = $1) {

                if (s|^\s*=\s*||o) {

                    ($newdef = $def) =~ s|$FLAG||o;
                    push @defs, &resolve_brackets($newdef);

                    ($newdef = $def) =~ s|<xr(?=[ >])[^>]* xt="[a-z]*ndv"[ >].*?</xr>\s*$FLAG| $_ |i;
                    push @defs, &resolve_brackets($newdef);
                }

                if (s|^\s*called\s+||o) {

                    ($newdef = $def) =~ s|$FLAG||o;
                    push @defs, &resolve_brackets($newdef);

                    ($newdef = $def) =~ s|$FLAG| $_ |o;
                    push @defs, &resolve_brackets($newdef);
                }

                ($newdef = $def) =~ s|$FLAG||o;
                push @defs, &resolve_brackets($newdef);

                push @defs, $_;
	    }

	} else {

	    @defs = ($def);
	}
    }

    s|<[^>]*>||go foreach @defs;
    return map {&perm_alts($_)} @defs;
}


sub zap_placeholders {

    s|\bsb(?:'s)?\b||gi;
    s|\bsth(?:'s)?\b||gi;

    s|\bsomebody(?:'s)?\b||gi;
    s|\bsomething(?:'s)?\b||gi;

    s|\bjd[mns]\b||gi;
    s|\betw\b||gi;

    s|\bq[cn]\b||gi;

    s|\balg[no]\b||gi;

    s|\balgu&eacute;m||gi;
    #    s|\balgo\b||gi;

    if (m| p *= *["']v[a-z]*["']|gi) {
	s|(<h(?=[ >])[^<>]*>) *to +|$1|gi;
	s|(<ts(?=[ >])[^<>]*>) *to +|$1|gi;
    }

    s| *\+[^<>()]*||g;
}


sub expand_placeholders {

    s|\bsb('s)?\b|sb$1/somebody$1|gi;
    s|\bsth('s)?\b|sth$1/something$1|gi;

    s|\bsomebody('s)?\b|sb$1/somebody$1|gi;
    s|\bsomething('s)?\b|sth$1/something$1|gi;

    s|\b(jd([mns]))\b|$1/jede$2|gi;
    s|\b(etw)\b|$1/etwas|gi;

    s|\b(qc)\b|$1/qualcosa|gi;
    s|\b(qn)\b|$1/qualcuno|gi;

    s|\b(algn)\b|$1/alguien|gi;
}


sub collapse_placeholders {

    s|\bsomebody('s)?\b|sb$1|gi;
    s|\bsomeone('s)?\b|sb$1|gi;
    s|\bsomething('s)?\b|sth$1|gi;

    s|\bjede([mns])\b|jd$1|gi;
    s|\betwas\b|etw|gi;

    s|\bqualcosa\b|qc|gi;
    s|\bqualcuno\b|qn|gi;

    s|\balguien\b|algn|gi;
}


sub perm_punc {

    my($str) = @_;
    my(@alt_strs,%alt_strs,$sym,$pre,$post,$p1,$p2);

    for ($str) {

	s|&ob;|/|gio;

	if (s{\s*&(pvarr|#x2194);\s*}{ \&$1; }io) {

	    $sym = "&$1;";

	    s|(<alt-g[ >].*?</alt-g>)( $sym)|$2|i or s|([^ ]+)( $sym)|$2|i;
	    $p1 = $1;

	    s|($sym )(<alt-g[ >].*?</alt-g>)|$1|i or s|($sym )([^ ]+)|$1|i;
	    $p2 = $2;

	    m|(.*) $sym (.*)|i;
	    $pre = $1;
	    $post = $2;

    # Permute optional (bracketed) elements first, then alternative 
    # (slashed) ones...

	    foreach $str ("$pre $p1 $p2 $post", "$pre $p2 $p1 $post") {

		push @alt_strs, &perm_alts($_) foreach &perm_opts($str);

	    }

	} else {

	    push @alt_strs, &perm_alts($_) foreach &perm_opts($str);
	}
    }

    foreach (@alt_strs) {

	s|\s*,\s*etc\.?||gio;
	s!\b(your|one's)\s+!$1+!gio;
	s{\s*&(?:pvarr|#x2194);\s*}{ }io;
	s!\b(your|one's)\+!$1 !gio;
	s|\s+([\.\!\?])$|$1|o;

	$alt_strs{$_} = 1;
    }

    return sort keys %alt_strs;
}


sub perm_opts {

    my($str) = @_;
    my($opts, $cap_prefix, $new_str, @alt_strs, @new_strs);
    my $B_FLAG = "&sih-bracket;";

    # Extract first bracketed element, if any, leaving placeholder
    if ($str =~ s|\((.*?)\)|$B_FLAG|) {

	$alts = $1;

	# Allow for German compound nouns with optional initial elements
	$cap_prefix = ($str =~ m|$B_FLAG[^ ]|) && ($alts =~ m|^[A-Z]|);

	# Permute alternatives within the optional element
	foreach $alt (&perm_alts($alts), "") {

	    # Insert alternative into original string and recurse to process 
	    # any more optional elements
	    ($new_str = $str) =~ s|$B_FLAG|$alt|;
	    @new_strs = &perm_opts($new_str);

	    # Ensure capitalisation of German compound nouns
	    if ($cap_prefix) {
		for $new_str (@new_strs) {
		    $new_str = ucfirst($new_str);
		}
	    }

	    # Accumulate results
	    push @alt_strs, @new_strs;
	}
    }
    # Otherwise, nothing to do
    else {
	push @alt_strs, $str;
    }

    return @alt_strs;
}


sub perm_alts {

    my($str) = @_;
    my($ALT_FLAG, @alts, @alt_strs, $new_str) = "&SIH-ALT;";

    # Remove slashes left dangling after placeholder zapping
    $str =~ s| +/| |go;
    $str =~ s|/ +| |go;

    for ($str) {

	&norm_space;

	last if m|^$|;

	# Deal with "etc." lists, if any, before anything else
	if (s|([^ ,<>]+(?:, ?[^ ,<>]+)*),? *e[tc]c\.?|$ALT_FLAG|io) {

	    @alts = split(/, /, $1);
	}

	# Deal with "and"/"or" lists, if any, next
	elsif (s{((?:[^ ,<>]+, ?)+[^ ,<>]+),? (?:and|or)( [^ ,<>]+)}{$ALT_FLAG}io) {

	    @alts = split(/, ?/, "$1,$2");
	}

	# Otherwise, deal with alternatives, if any
	elsif (s|(<alt-g[ >].*?</alt-g>)| $ALT_FLAG |io) {

	    for ($new_str = $1) {
		s|<alt(?=[ >])[^>]*>\s*etc\.?</alt>||gio;
		s|(?:<[^>]+>\s*){2}||o;
		s|(?:<[^>]+>\s*){2}$||o;
	    }

	    @alts = split(/(?:<[^>]+>\s*){2}/, $new_str);
	}
	elsif (s|([^ /,<>]+[/,][^ /,<>]+)|$ALT_FLAG|io) {

	    @alts = split(/[\/,]/, $1);
	}

	# Otherwise, nothing to do
	else {
	    push @alt_strs, $_;
	    last;
	}

	foreach $alt (@alts) {

	    # Insert alternative into original string and recurse to process 
	    # any more alternative elements, accumulating results
	    ($new_str = $_) =~ s|$ALT_FLAG|$alt|;
	    push @alt_strs, &perm_alts($new_str);
	}
    }

    return @alt_strs;
}


sub norm_space {

    s|^ +||;
    s| +$||;
    s|(?<=[>(]) +||g;
    s| +(?=[<)])||g;
    s| +| |g;
}


1;
