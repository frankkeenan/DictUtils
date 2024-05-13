#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $opt_d, $opt_c, %W);
if (1)
{
    require "/usr/local/bin/utils.pl";
    require "/usr/local/bin/restructure.pl";
}
else {
    require "./utils.pl";
    require "./restructure.pl";
}
# require "/data_new/VocabHub/progs/VocabHub.pm";
#require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
$LOG = 0;
$LOAD = 0;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IODc:');
    &usage if ($opt_u);
    &usage unless ($opt_c);
    my($e, $res, $bit);
    my(@BITS);
#   $opt_L = ""; # name of file for the log_fp output to go to
    &open_debug_files;
    use open qw(:utf8 :std);
    my $resdir = sprintf("/data/data_c/Projects/OLT/%s", $opt_c);
    unless (-d $resdir)
    {
	my $comm = sprintf("mkdir -p \"%s\"", $resdir);
	printf(STDERR "%s\n\n", $comm);
	system($comm);
	
    }
    my $DPSPASS = $ENV{'DPSPASS'};
    my $DPSUSER = $ENV{'DPSUSER'};
    my $comm = sprintf("curl -s --user frank.keenan:%s \"https://dwst-dps.idm.fr/api/v1/projects/%s/entries/export/allInternalAttributesAndAdditionalMetadata\"  | perl  /usr/local/bin/add_missing_end_tags.pl  > %s/dps.xml", $DPSPASS, $opt_c, $resdir); 
    printf(STDERR "%s\n\n", $comm);
    unless ($opt_d)
    {
	system($comm);
    }
    exit;
}

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    printf(STDERR "\t-u:\tDisplay usage\n"); 
    printf(STDERR "\t-c:\tDictCode\n"); 
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
	s|
	# my ($eid, $info) = split(/\t/);
	# $W{$_} = 1;
    }
    close(in_fp);
} 