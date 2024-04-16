#!/usr/local/bin/perl -i.BAK
use Getopt::Std;
use autodie qw(:all);
use open qw(:std :utf8);
use utf8;
use strict;
our ($LOG, $LOAD, $opt_a, $opt_f, $opt_u, $opt_D, $opt_I, $opt_O, $PDIR, %W, %USED, %F, %INFO, $p);
#$PDIR = ".";
our $PDIR = $ENV{DICT_UTILS};
if ($PDIR =~ m|^ *$|)
{
    printf(STDERR "Need to set ENV for DICT_UTILS\n\n"); 
}

require "$PDIR/utils.pl";
require "$PDIR/restructure.pl";

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
    getopts('uf:L:IOD');
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
    if ($LOAD){&load_file($opt_f);}
    my $found;
    my $config;
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){printf(bugin_fp "%s\n", $_);}	
	if (m|<!DOCTYPE|)
	{
	    $found = 0;
	}
	s|<rules>|<rules >|g;
	if (m|<config|)
	{
	    $config = $_;
	}
	if (m|<rules[ >]|)
	{
	    my $id = restructure::get_tag_attval($_, "rules", "xml:id");
	    unless ($found++)
	    {
		if ($id =~ m|^ *$|)
		{
		    $id = $ARGV;
		    $id =~ s|\.xml||;
		    $_ = restructure::set_tag_attval($_, "rules", "xml:id", $id); 
		}
#		printf("%s\t%s\n%s\n\n", $ARGV, $id, $_);
		&create_wrap($ARGV, $id, $config);
	    }
	    #	    $found = 1;
	}
	# s|<!--.*?-->||gio;
	#	next line if (m|<entry[^>]*sup=\"y|io);
	#	unless (m|<entry|){print $_; next line;}
	# my $h = &get_hex_h($_, "hex", 1); # the 1 says to remove stress etc
	# my $EntryId = &get_tag_attval($_, "entryGroup", "e:id");
	# $_ = &reduce_idmids($_);
	# s|£|&\#x00A3;|g;
        # $_ = restructure::delabel($_);	
	# my $tagname = restructure::get_tagname($bit);    
	print $_;
	if ($opt_O){printf(bugout_fp "%s\n", $_);}
  }
    &close_debug_files;
}

sub create_wrap
{
    my($f, $id, $config) = @_;
    my($res);	
    my $out_f = $f;
    $out_f =~ s|\.|_wrapper.|;
    open(out_fp, ">$out_f") || die "Unable to open >$out_f"; 
    binmode(out_fp, ":utf8");
    print out_fp '<?xml version="1.0" encoding="UTF-8"?>';
    print out_fp '<!DOCTYPE config SYSTEM "config.dtd"';
    print out_fp '	[';
    print out_fp '		<!--load entity declarations for digital symbols-->';
    print out_fp '		<!ENTITY % digital_symbols SYSTEM "digital_symbols.ent">';
    print out_fp '		%digital_symbols;';
    print out_fp '	]';
    print out_fp '>';
    printf(out_fp "%s\n", $config);
    printf(out_fp "<xi:include xmlns:xi=\"http://www.w3.org/2001/XInclude\" href=\"%s\" parse=\"xml\" xpointer=\"%s\"/>\n", $f, $id);
    printf(out_fp "</config>\n"); 
    close(out_fp);
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
	# $INFO{$eid} = $info;
    }
    close(in_fp);
} 
