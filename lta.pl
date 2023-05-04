#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
require "./utils.pl";
require "./restructure.pl";
#require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
$LOG = 1;
$LOAD = 1;
$UTF8 = 0;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub main
{
    getopts('uf:L:IOo');
    &usage if ($opt_u);
    my($e, $res, $bit);
    my(@BITS);
#   $opt_L = ""; # name of file for the log_fp output to go to
    $opt_L = $ARGV[0];
    $opt_L =~ s|\.[^\.]*$|_empty_defs.txt|;
    &open_debug_files;
    if ($opt_o)
    {
	$USE_OLD = 1;
    }
    $tags_file = "./LTA/tag_info.dat";
    $ents_file = "./LTA/ents_old_dtd.txt";
    $atts_file = "./LTA/attnames.txt";
    &load_tags_file($tags_file);
    &load_ents_file($ents_file);
    &load_atts_file($atts_file);
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){
	    printf(bugin_fp "%s\n", $_);
	}
	s|<!--.*?-->||gio;
	s|<\?.*?>||gi;
	s|<\!DOCTYPE.*?>||gi;
#	next line if (m|<entry[^>]*del=\"y|io);
#	next line if (m|<entry[^>]*sup=\"y|io);
	# $h = &get_hex_h($_, "hex", 1); # the 1 says to remove stress etc
	# $eid = &get_tag_attval($_, "entry", "eid");
	# $EntryId = &get_dps_entry_id($_);
	# $_ = &reduce_idmids($_);
	# s|£|&\#x00A3;|g;
	$_ = restructure::delabel($_);	
	&store_tags_and_atts_used($_);
	&store_ents_used($_);
	if ($opt_O){
	    printf(bugout_fp "%s\n", $_); 
	}
    }
    &print_usage;
    &close_debug_files;
}

sub store_ents_used
{
    my($e) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s|&(.*?);|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $ENT_CT{$bit}++;
	}
    }    
}

sub print_usage
{
    my($e) = @_;
    my($res, $eid);	
    printf("<h2>Tags used in the file</h2>\n"); 
    printf("<table><thead><tr><th>Tagname</th><th>Description</th><th>Frequency of use</th><th>Attributes and frequency of use</th></tr></thead>\n<tbody>\n");
    foreach $tagname (sort keys %TAGS_CT)
    {
	$att_info = &get_att_info($tagname);
	$info = $TAG_DESC{$tagname};
	if ($info =~ m|^ *$|)
	{
	    $cp = $tagname;
	    $cp =~ s|^zp.*|zp|;
	    $cp =~ s|.*space.*|z_space|;
	    $cp =~ s|^z_spc[^a-z].*|z_space|;
	    $cp =~ s|^z_sp[^a-z].*|z_space|;
	    $info = $TAG_DESC{$cp};
	    if ($info =~ m|^ *$|)
	    {
		printf(log_fp "%s\t\n", $tagname); 
	    }
	}
	printf("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>\n", $tagname, $info, $TAGS_CT{$tagname}, $att_info); 
    }
    printf("</tbody>\n</table>"); 
#
    printf(log_fp "\nATTRIBS\t\n"); 

    printf("<h2>Attributes</h2>\n"); 
    printf("<table><thead><tr><th>Attribute</th><th>Description</th><th>Frequency of use</th></tr></thead>\n<tbody>\n");
    foreach $att (sort keys %ATT_CT)
    {
	$desc = $ATT_DESC{$att};
	if ($desc =~ m|^ *$|)
	{
	    printf(log_fp "%s\t\n", $att); 
	}
	printf("<tr><td>%s</td><td>%s</td><td>%s</td></tr>\n", $att, $desc, $ATT_CT{$att});
    }
    printf("</tbody>\n</table>"); 

#
    printf(log_fp "\nENTITIES\t\n"); 
    printf("<h2>Entities used in the file</h2>\n"); 
    printf("<table><thead><tr><th>Entity</th><th>Description</th><th>Frequency of use</th></tr></thead>\n<tbody>\n");
    foreach $ent (sort keys %ENT_CT)
    {
	$desc = $ENT_DESC{$ent};
	if ($desc =~ m|^ *$|)
	{
##
	    $cp = $ent;
	    $cp =~ s|^zp.*|zp|;
	    if (($cp =~ m|space|) || ($cp =~ m|_sp|))
	    {
		$desc = "space";
	    } else {
		$cp =~ s|pstress.*|pstress|;
		$cp =~ s|sstress.*|sstress|;
		$desc = $ENT_DESC{$cp};
	    }
	    if ($desc =~ m|^ *$|)
	    {
		printf(log_fp "%s\t\n", $ent); 
		$desc = sprintf("&%s;", $ent); 
	    }

#	    printf(log_fp "%s\t\n", $ent); 
	}
	printf("<tr><td>&amp;%s;</td><td>%s</td><td>%s</td></tr>\n", $ent, $desc, $ENT_CT{$ent});
    }
    printf("</tbody>\n</table>"); 
}

sub get_att_info
{
    my($tagname) = @_;
    my($res, $eid);	
    my($bit);
    my(@BITS);
    foreach $att (sort keys %ATT_CT)
    {
	$tagname_att = sprintf("%s\t%s", $tagname, $att); 
	my $ct = $TACT{$tagname_att};
	if ($ct > 0)
	{
	    $res = sprintf("%s%s<i>{%s}</i> ", $res, $att, $ct); 
	}
    }
    $res =~ s|^ *||;
    $res =~ s| *$||;
    return $res;
}

sub store_tags_and_atts_used
{
    my($e) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s|</[^>]*>||gi;
    $e =~ s|(<.*?>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $tagname = restructure::get_tagname($bit);    	    
	    $TAGS_CT{$tagname}++;
	    &store_atts($bit, $tagname);
	}
    }    
    return $res;
}

sub store_atts
{
    my($e, $tagname) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $e =~ s| *> *| |g;
    $e =~ s|^[^ ]* | |g;
    $e =~ s|=\".*?\"| |g;
    @BITS = split(/ +/, $e);
    $res = "";
    foreach $bit (@BITS){
	unless ($bit =~ m|^ *$|)
	{
	    $ATT_CT{$bit}++;
	    $tagname_att = sprintf("%s\t%s", $tagname, $bit); 
	    $TACT{$tagname_att}++;
	}
    }    
}

sub usage
{
    printf(STDERR "USAGE: $0 -u \n"); 
    printf(STDERR "\t-u:\tDisplay usage\n"); 
#    printf(STDERR "\t-x:\t\n"); 
    exit;
}


sub load_tags_file
{
    my($f, $WANTED) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    if ($UTF8){
	binmode(in_fp, ":utf8");
    }
    while (<in_fp>){
	chomp;
	s|||g;
	my ($tag, $desc, $old_new) = split(/\t/);
	if (m|<new|)
	{
	    unless ($USE_OLD)
	    {
		$desc = restructure::get_tag_contents($desc, "new"); 
	    }
	}
	$TAG_DESC{$tag} = $desc;
	# $W{$_} = 1;
    }
    close(in_fp);
} 

sub load_ents_file
{
    my($f, $WANTED) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    if ($UTF8){
	binmode(in_fp, ":utf8");
    }
    while (<in_fp>){
	chomp;
	s|||g;
	my ($ent, $desc, $old_new) = split(/\t/);
	$ENT_DESC{$ent} = $desc;
	# $W{$_} = 1;
    }
    close(in_fp);
} 


sub load_atts_file
{
    my($f, $WANTED) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    if ($UTF8){
	binmode(in_fp, ":utf8");
    }
    while (<in_fp>){
	chomp;
	s|||g;
	my ($att, $desc, $old_new) = split(/\t/);
	if (m|<new|)
	{
	    unless ($USE_OLD)
	    {
		$desc = restructure::get_tag_contents($desc, "new"); 
	    }
	}
	$ATT_DESC{$att} = $desc;
	# $W{$_} = 1;
    }
    close(in_fp);
} 
