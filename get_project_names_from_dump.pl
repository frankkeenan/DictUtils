#!/usr/bin/perl
use Getopt::Std;
use autodie qw(:all);
use utf8;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IOD');
    &usage if ($opt_u);
    my($e, $res, $bit);
    my(@BITS);
    use open qw(:std :utf8);
    if ($opt_D)
    {
	binmode DB::OUT,":utf8";
    }
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	$_ =~ s|(\:\[)|&split;&fk;$1|gi;
	$_ =~ s|,({\"code\")|,&split;&fk;$1|gi;
	@BITS = split(/&split;/, $_);
	foreach $bit (@BITS){
	    if ($bit =~ s|&fk;||gi){
		if ($bit =~ s|^.*\{\"code\":\"(.*?)\"|\1|)
		{
		    $code = $1;
		    if ($bit =~ m|\"name\":\"(.*?)\"|)
		    {
			$name = $1;
		    }
		    printf("%s\t%s\n", $code, $name); 
		}
	    }
	}
    }
}
