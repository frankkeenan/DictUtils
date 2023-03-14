#!/usr/local/bin/perl

# get extra entries to include all tags for licensing samples ...
# sort -un output and change &nl; to \n ...

######################################################

&load_array;

foreach $match (%ARRAY)
{
	open(SOURCE, "../3B2/combo.3b2");
	$count="";
	$entry="";
	&get_entry;
	close(SOURCE);
}	

######################################################

sub load_array

{

    open(ARRAY, "diff.tags");
    while (<ARRAY>)
	{
	    chomp;

		m|.+|;
		{
	    $key = $&;
	    $content = $&;
    	$ARRAY{$key} = "$content";
		}

	}
    close(ARRAY);

}

######################################################

sub get_entry

{
    line:
	while (<SOURCE>)
	{
		next line if (/<alpha_start/);
		
		$entry =~ s|$|$_|; # read lines from file until end of entry ...
		$entry =~ s|\n|&nl;|g;
		$entry =~ s|&nl;$|\n|;	
		
		if ($entry =~ m|</(cr_)?entry>|)
		{
			$count++;
			if ($entry =~ m|$match|)
			{
				print "$count\t$entry";
				return;
			}
			$entry="";
		}
	}
}

######################################################
