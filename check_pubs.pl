#!/usr/local/bin/perl
use Getopt::Std;
use autodie qw(:all);
require "/usrdata3/dicts/NEWSTRUCTS/progs/utils.pl";
require "/NEWdata/dicts/generic/progs/restructure.pl";
#require "/NEWdata/dicts/generic/progs/xsl_lib_fk.pl";
$LOG = 0;
$LOAD = 0;
$UTF8 = 0;
$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator
#undef $/; # read in the whole file at once
&main;

sub print_bord_entries
{
    printf("<h2><a name=\"bord_entries\" />Entries with bord=\"y\"</h2>\n"); 
    printf("<ul>\n"); 
    foreach $h (sort keys %BORD)
    {
	printf("<li>%s</li>\n", $h); 
    }
    printf("</ul>\n"); 
}

sub print_sup_entries
{
    printf("<h2><a name=\"sup_entries\" />Entries with sup=\"y\"</h2>\n"); 
    printf("<ul>\n"); 
    foreach $h (sort keys %SUP)
    {
	printf("<li>%s</li>\n", $h); 
    }
    printf("</ul>\n"); 
}

sub main
{
    getopts('uf:L:n:IO');
    &usage if ($opt_u);
    my($e, $res, $bit);
    my(@BITS);
    if ($opt_n)
    {
	$MAXCT = $opt_n;
    } else {
	$MAXCT = 10;
    }
#   $opt_L = ""; # name of file for the log_fp output to go to
    &open_debug_files;
    if ($LOAD){&load_file($opt_f, \%W);}
  line:    
    while (<>){
	chomp;       # strip record separator
	s|||g;
	if ($opt_I){
	    printf(bugin_fp "%s\n", $_);
	}
	s|<!--.*?-->||gio;
#	next line if (m|<entry[^>]*del=\"y|io);
	$h = &get_hex_h($_, "hex", 1); # the 1 says to remove stress etc
	$_ = restructure::delabel($_);	
	s| pub=\"all\"| |gi;
	s| +| |g;
	$e = $_;
	$_ = restructure::tag_delete($_, "pron-gs"); 
	if (m|<entry[^>]*sup=\"y|io)
	{
	    $SUP{$h} = 1;
	    next line;
	}
	if (s|(<entry[^>]* )bord=\"y\"|\1|io)
	{
	    $BORD{$h} = 1;	    
	}
	elsif (m| bord=\"y|i)
	{
	    &store_bord_elements($_);
	}
	next line unless (m| pub=|);
	$epub = restructure::get_tag_attval($_, "entry", "pub"); 
	unless ($epub =~ m|^ *$|)
	{
	    $sk = $h;
	    $sk =~ tr|A-Z|a-z|;
	    $EPUBVALS{$epub} = 1;
	    $pub_h = sprintf("%s\t%s\t%s", $epub, $sk, $h); 
	    $EPUB{$pub_h} = 1;
	}
	s|<entry[^>]*>||;
	next line unless (m| pub=|);
	&store_element_pubs($_);
#	print $_;
	if ($opt_O){
	    printf(bugout_fp "%s\n", $_); 
	}
    }
    printf("<html><body>\n<h1>Pub attribute checks</h1>\n"); 
    &print_menu;
    &print_element_pubs;
    &print_element_bords;
    &print_epubs;
    &print_sup_entries;
    &print_bord_entries;
    printf("</body>\n</html>\n"); 
    &close_debug_files;
}

sub store_bord_elements
{
    my($e) = @_;
    my($res, $eid);	
    my $h = &get_hex_h($e, "hex", 1); # the 1 says to remove stress etc
    $e =~ s|(<[^>]* bord=\"y[^>]*>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $tagname = restructure::get_tagname($bit);    
	    $BORDCT{$tagname}++;
	    $tag_h = sprintf("%s\t%s", $tagname, $h); 
	    $WHERE_BORD{$tagname} = sprintf("%s<li>%s</li>\n", $WHERE_BORD{$tagname}, $h);		
	}
    }
}

sub print_element_bords
{
    my($e) = @_;
    my($res, $eid, $pub, $prev_pub, $ct);	
    printf("<h2><a name=\"element_bords\" />Elements with bord=\"y\"</h2>\n<ul>\n", $pub, $pub); 
    my $open = 1;
#    printf("<ul>\n"); 
    foreach $tag (sort keys %BORDCT) 
    {
	if ($BORDCT{$tag} < $MAXCT)
	{
	    $where = $WHERE_BORD{$tag};
	    printf("<li>%s: %s</li>\n<ul>%s</ul>", $tag, $BORDCT{$tag}, $where); 
	} else {
	    printf("<li>%s: %s</li>\n", $tag, $BORDCT{$tag}); 
	}
    }
    printf("</ul>\n"); 
}

sub print_menu
{
    printf("<h4>Links:</h4>\n<ul>\n"); 
    printf("<li><a href=\"\#element_pubs\">Elements with pub values</a></li>\n"); 
    printf("<li><a href=\"\#element_bords\">Elements with bord=\"y\"</a></li>\n"); 
    printf("<li><a href=\"\#entry_pubs\">Entry tags with pub values</a></li>\n"); 
    printf("<ul>\n"); 
    foreach $pub (sort keys %EPUBVALS) 
    {
	printf("<li><a href=\"\#%s\">pub=\"%s\"</a></li>\n", $pub, $pub); 
    }
    printf("</ul>\n"); 
    printf("<li><a href=\"\#sup_entries\">Entries with sup=\"y\"</a></li>\n"); 
    printf("<li><a href=\"\#bord_entries\">Entries with bord=\"y\"</a></li>\n"); 
    printf("</ul>\n"); 
}

sub print_element_pubs
{
    my($e) = @_;
    my($res, $eid, $pub, $prev_pub, $ct);	
    printf("<h2><a name=\"element_pubs\" />Elements with pub values</h2>\n<ul>\n", $pub, $pub); 
    my $open = 1;
    foreach $pub_tag (sort keys %CT) 
    {
	($pub, $tag) = split(/\t/, $pub_tag);
	unless ($pub eq $prev_pub)
	{
	    if ($open)
	    {
		printf("</ul>\n"); 
		$open = 0;
	    }
	    printf("<h3>pub=\"%s\"</h3>\n<ul>\n", $pub); 
	    $open = 1;
	    $prev_pub = $pub;
	}
	if ($CT{$pub_tag} < $MAXCT)
	{
	    $where = $PTH{$pub_tag};
	    printf("<li>%s: %s</li>\n<ul>%s</ul>", $tag, $CT{$pub_tag}, $where); 
	} else {
	    printf("<li>%s: %s</li>\n", $tag, $CT{$pub_tag}); 
	}
    }
    if ($open)
    {
	printf("</ul>\n"); 
	$open = 0;
    }
}

sub store_element_pubs
{
    my($e) = @_;
    my($res, $eid);	
    my($bit, $res);
    my(@BITS);
    $h = &get_hex_h($_, "hex", 1); # the 1 says to remove stress etc
    $e =~ s|(<[^>]* pub=[^>]*>)|&split;&fk;$1&split;|gi;
    @BITS = split(/&split;/, $e);
    $res = "";
    foreach $bit (@BITS){
	if ($bit =~ s|&fk;||gi){
	    $tagname = restructure::get_tagname($bit);    
	    $pub = restructure::get_tag_attval($bit, $tagname, "pub"); 
	    unless ($pub =~ m|^ *$|)
	    {
		$pub_tag = sprintf("%s\t%s", $pub, $tagname); 
		++$CT{$pub_tag};
		$pub_tag_h = sprintf("%s\t%s\t%s", $pub, $tagname, $h); 
		$PTH{$pub_tag} = sprintf("%s<li>%s</li>\n", $PTH{$pub_tag}, $h);		
	    }
	}
	$res .= $bit;
    }
}

sub print_epubs
{
    my($h, $pub, $prev_pub, $ct);	
    printf("<h2><a name=\"entry_pubs\" />Entry tags with pub values</h2>\n<ul>\n", $pub, $pub); 
    foreach $epub (sort keys %EPUB)
    {
	($pub, $sk, $h) = split(/\t/, $epub);
	unless ($pub eq $prev_pub)
	{
	    if ($open)
	    {
		printf("</ul>\n"); 
		$open = 0;
	    }
	    printf("<h2><a name=\"%s\" />Pub: %s</h2>\n<ul>\n", $pub, $pub); 
	    $open = 1;
	}
	printf("\t<li>%s</li>\n", $h); 
	$prev_pub = $pub;
    }	
    if ($open)
    {
	printf("</ul>\n"); 
	$open = 0;
    }
    printf("</ul>\n");     
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
    my($f, $W) = @_;
    my ($res, $bit, $info);
    my @BITS;
    open(in_fp, "$f") || die "Unable to open $f"; 
    if ($UTF8){
	binmode(in_fp, ":utf8");
    }
    while (<in_fp>){
	chomp;
	s|||g;
	# ($id, $info) = split(/\t/);
	$W->{$_} = 1;
    }
    close(in_fp);
} 
