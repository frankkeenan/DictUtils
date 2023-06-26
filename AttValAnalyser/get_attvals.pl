#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, %W, %USED, %F, %IGNORE, %CT);
if (1)
{
    require "/NEWdata/dicts/generic/progs/utils.pl";
    require "/NEWdata/dicts/generic/progs/restructure.pl";
}
else {
    require "./utils.pl";
    require "./restructure.pl";
}
# require "/data_new/VocabHub/progs/VocabHub.pm";
#require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
$LOG = 0;
$LOAD = 1;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IODt:');
    &usage if ($opt_u);
    my($e, $res, $bit);
    my(@BITS);
    #   $opt_L = ""; # name of file for the log_fp output to go to
    &open_debug_files;
    use open qw(:utf8 :std);
    if ($opt_D)
    {
	binmode DB::OUT,":utf8";
    }
    unless ($opt_f)
    {
	$opt_f = "get_attvals.pl.dat";
    }
    if ($LOAD){&load_file($opt_f);}
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){printf(bugin_fp "%s\n", $_);}
	$_ = restructure::delabel($_);	
	$_ =~ s|(<[^/].*?>)|&split;&fk;$1&split;|gi;
	my @BITS = split(/&split;/, $_);
	my $res = "";
	foreach my $bit (@BITS){
	    if ($bit =~ s|&fk;||gi){
		&store_attribs($bit);
	    }
	    $res .= $bit;
	}	
#	print $_;
	if ($opt_O){printf(bugout_fp "%s\n", $_);}
    }
    foreach my $bit (sort keys %CT)
    {
	printf("%s\t%s\n", $bit, $CT{$bit}); 
    }
    &close_debug_files;
}

sub store_attribs
{
    my($e) = @_;
    my($res, $eid);	
    my $tagname = restructure::get_tagname($e);    
    return unless ($tagname =~ m|^[A-Za-z]|);
    $e =~ s| e:[^ =]*=\".*?\"||gi;
    $e =~ s| xmlns[^ =]*=\".*?\"||gi;
    $e =~ s| psg[^ =]*=\".*?\"||gi;
    $e =~ s| eid[^ =]*=\".*?\"||gi;
    $e =~ s| lexid[^ =]*=\".*?\"||gi;
    $e =~ s| dpsref[^ =]*=\".*?\"||gi;
    $e =~ s|^.*? | |;
    $e =~ s|[> ]*$| |;
    $e =~ s| +([a-z0-9A-Z\-_]+=.*?)|&split;&fk;$1|gi;
    my @BITS = split(/&split;/, $e);
    my $res = "";
  floop:
    foreach my $attrib (@BITS){
	if ($attrib =~ s|&fk;||gi){
	    $attrib =~ s| *$||;
	    my $attname = $attrib;
	    my $attval = $attrib;
	    $attname =~ s|\=.*||;
	    $attval =~ s|^.*?\=||;
	    my $tag_attname = sprintf("%s\t%s", $tagname, $attname); 
	    next floop if ($IGNORE{$attname});
	    next floop if ($IGNORE{$tag_attname});
	    
	    my $tag_attrib = sprintf("%s\t%s", $tagname, $attrib);
	    $CT{$tag_attrib}++;
	}
    }
    return;
}




sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    printf(STDERR "\t-u:\tDisplay usage\n"); 
    #    printf(STDERR "\t-x:\t\n"); 
    exit;
}


sub load_file
{
    my($f) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    binmode(in_fp, ":utf8");
    while (<in_fp>){
	chomp;
	s|||g;
	# my ($eid, $info) = split(/\t/);
	unless (m|^[ \t]*$|)
	{
	    $IGNORE{$_} = 1;
	}
    }
    close(in_fp);
} 
