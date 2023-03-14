#!/usr/local/bin/perl

# this program puts adjacent idiom groups into a simple alphabetic order ...

###########################################

while (<>)
{
    &sort_idioms;
	print;
}


###########################################

sub sort_idioms
{

    # keep adjacent id-g's together ...
    # and put a marker where the sorted idioms are to go ...

    s|</id-g><id-g|&adjacent_idgs;|gi;
    s|</id-g>|</id-g>&putresultshere;|gi; # could be several of these in an entry ...

    s|<id-g|&split;$&|g;
    $res = "";
    @BITS = split(/&split;/);
    foreach $bit (@BITS)
    {

	# where there are adjacent id-g's, sort them ...

	if ($bit =~ m|&adjacent_idgs;|)
	{
	    $bit =~ s|\*|&tempast;|g;
	    $bit =~ s|\(|&tempopenbra;|g;
	    $bit =~ s|\)|&tempclosebra;|g;
	    $bit =~ s|\+|&tempplus;|g;
	    $bit =~ s|\-<|&tempminus;<|g;
	    $bit =~ s|\?|&tempquest;<|g;

	    $bit =~ s|&adjacent_idgs;|</id-g><id-g|g;
	    while ($bit =~ m|<id-g([^>]*)><id[> ]([^<]*)</id>(.*?)</id-g>|i)
	    {
		$sortkey = $2;
		$foundidg = $&;
		$bit =~ s|$&||; # zap the found (unsorted) id-g ...

		$sortkey =~ s|&.*?;||gio;
		$sortkey =~ s|([A-Z])|\L$1\E|gio;
		$sortkey =~ s|([^a-z])||gio;
		
		$newidg = "<sortkey>$sortkey</sortkey>$foundidg";
		push (@NEWIDGS,$newidg);
	    }

	    @NEWIDGS = sort (@NEWIDGS);
	    $bit =~ s|&putresultshere;|@NEWIDGS|;
	    $bit =~ s|</id-g> <id-g|</id-g><id-g|g;
	    @NEWIDGS = "";

	    $bit =~ s|&tempopenbra;|(|g;
				     $bit =~ s|&tempclosebra;|)|g;
	    $bit =~ s|&tempplus;|+|g;
	    $bit =~ s|&tempast;|*|g;
	    $bit =~ s|&tempminus;<|-<|g;
	    $bit =~ s|&tempquest;<|?|g;

	}
        $res .= $bit;
        $_ = $res;
    }	

    s|&putresultshere;||g;
    s| ?<sortkey>.*?</sortkey>||gi;
}

###########################################

