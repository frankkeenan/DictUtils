#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_t, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $PDIR, %W, %USED, %F, %INFO, %CHANGE, %TAGS, $p, %ALL);
#$PDIR = ".";
$PDIR = "/usr/local/bin/";

require "$PDIR/utils.pl";
require "$PDIR/restructure.pl";

# require "/data_new/VocabHub/progs/VocabHub.pm";
#require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
$LOG = 1;
$LOAD = 1;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

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
	my ($e_eid, $eid, $old, $new) = split(/\t/);
	$W{$e_eid} = 1;
	my $annotation = sprintf("<?dps_comment content=\"Was [%s]\" status=\"Imported\" topic=\"Gender_neutral\"?>", $old); 
	$new = sprintf("%s%s", $annotation, $new); 
	$CHANGE{$eid} = $new;
    } 
    close(in_fp);
}

sub main
{
    getopts('uf:L:IODt:');
    &usage if ($opt_u);
    my (%OLD_TC, %NEW_TC);
    my($e, $res, $bit);
    my(@BITS);
    #   $opt_L = ""; # name of file for the log_fp output to go to
    &open_debug_files;
    use open qw(:utf8 :std);
    if ($opt_D)
    {
	binmode DB::OUT,":utf8";
    }
    if ($LOAD){&load_file($opt_f);}
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){printf(bugin_fp "%s\n", $_);}	
	# s|<!--.*?-->||gio;
	#	next line if (m|<entry[^>]*sup=\"y|io);
	my $cp = $_;
	unless (m|<e|){
	    printf("%s\n\n", $_);
	    printf(log_fp "%s\n\n", $cp); 
	    next line;
	}	
	my $e_eid = restructure::get_tag_attval($_, "e", "e:id");
	next line unless ($W{$e_eid});
	$_ = &update_defs($_);
	printf("%s\n\n", $_);
	printf(log_fp "%s\n\n", $cp); 
	if ($opt_O){printf(bugout_fp "%s\n", $_);}
    }
    foreach my $eid (sort keys %CHANGE)
    {
	printf(STDERR "%s\t%s\n", $eid, $CHANGE{$eid}); 
    }
    &close_debug_files;
}

sub update_defs
{
    my($e) = @_;
    my($res, $eid);	
    $e =~ s|(<df[ >].*?</df>)|&split;&fk;$1&split;|gi;
    my @BITS = split(/&split;/, $e);
    my $res = "";
    foreach my $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    my $eid = restructure::get_tag_attval($bit, "df", "e:id"); 
	    my $new = $CHANGE{$eid};
	    unless ($new =~ m|^ *$|)
	    {
		$bit =~ s|>.*$|>$new</df>|;
		delete $CHANGE{$eid};
	    }
	}
	$res .= $bit;
    }    
    return $res;
}

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    printf(STDERR "\t-u:\tDisplay usage\n");
    printf(STDERR "\t-t:\tEN-PT, EN-ZH, PT-EN, IT-EN, EN-IT\n");
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
	my ($e_eid, $eid, $old, $new) = split(/\t/);
	$W{$e_eid} = 1;
	my $annotation = sprintf("<?dps_comment content=\"Was [%s]\" status=\"Imported\" topic=\"Gender_neutral\"?>", $old); 
	$new = sprintf("%s%s", $annotation, $new); 
	$CHANGE{$eid} = $new;
    } 
    close(in_fp);
}
