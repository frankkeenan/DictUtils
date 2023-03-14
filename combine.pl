#!/usr/local/bin/perl
use Getopt::Std;

# program that makes a single file of the ald6 each evening

$, = ' ';               # set output field separator
$\ = "\n";              # set output record separator


&main;

sub usage
{
    printf(STDERR "USAGE: $0 [-u] -b basedir\n"); 
    printf(STDERR "\t-b :\tBase directory to combine from\n"); 
    printf(STDERR "\t-u:\tDisplay usage\n"); 
#    printf(STDERR "\t-x:\t\n"); 
    exit;
}

sub main
{
    getopts('db:ur:');
    &usage if ($opt_u);
    if ($opt_b)
    {
	$basedir = $opt_b;
    }
    else
    {
	&usage;
    }
    $DBG = 1;
    $dictfiles = sprintf("%s/dictfiles", $basedir);
    $VERBOSE = 1;
    if ($opt_r)
    {
	$resfile = $opt_r;
    }
    else
    {
	$resfile = sprintf("%s/combo.dat", $basedir);
    }
    
    open(res_fp, ">$resfile") || die "Unable to open $resfile";
#    open(FIND, "find $dictfiles -type f -print|");
    undef %STORED_E;
    $files_found = 0;
    $fname = "";
    $subdirs = "a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9";
#    $subdirs = "_";
    @SUBDIRS = split(/ +/, $subdirs);
    foreach $subdir (@SUBDIRS)
    {
	$dir = sprintf("%s/%s", $dictfiles, $subdir);
	if (-d $dir)
	{
	    $files = `ls $dir`;
	    chomp $files;
	    printf(STDERR "Starting dir: $dir\n");
	    @FILES = split(/\n/, $files);
	  FILE:
	    foreach $file (@FILES)
	    {
		chomp $file;       # strip record separator
#		next FILE unless ($file =~ /.sgm *$/i);
		next FILE unless ($file =~ /.xml *$/i);
		$fname = sprintf("%s/%s", $dir, $file);
		$files_found++;
		if ($VERBOSE)
		{
		    if (($files_found % 100) == 0)
		    {
			$date = `date`;
			chomp $date;
			printf(STDERR "files_found = %s [%s]\n", $files_found, $date); 
		    }
		}
		$sgm_file = `cat $fname`;
		$sgm_file =~ s|\n|&nl;|go;	# 
		$sgm_file =~ s|\r||go;	# BC 24Jun99 - to fix indexing problem in searcher
#		$sgm_file =~ s|<([^>]*)>|<\U$1\E>|gio;
		
		if ($sgm_file =~ m|^(.*?)(<ENTRY.*</ENTRY>)(.*?)$|i)
		{
		    $fhdr = $1;
		    $entries = $2;
		    $tail = $3;
		    $fhdr =~ s|&nl;|\n|go;
		    $tail =~ s|&nl;|\n|go;
		    
		    if ($entries =~ /<H>[^<]*[a-z]/io)
		    {
                        $entries =~ s|</ENTRY>|<!--file: $file-->$&|goi;
			$entries =~ s|(<ENTRY)|&split;$1|goi;
			
			undef @ENTRIES;
			@ENTRIES = split(/&split;/, $entries);
			foreach $e (@ENTRIES)
			{
			    unless ($e =~ /del="y"/i)
			    {
			        if ($e =~ /<entry/i)
			        {
				    $sk = &get_sortkey($e);
				    if ($STORED_E{$sk})
				    {
				        $STORED_E{$sk} .= $e;
				    }
				    else
				    {
				        $STORED_E{$sk} = $e;
				        $stored_entry_ct++;
				    }
			        }
			    }
			}
		    }
		}
	    }			# 
	}
	printf(STDERR "Finished dir: $dir\n");
    }
    printf(STDERR "Entries found: stored_entry_ct = $stored_entry_ct\n");
    printf(STDERR "files_found = $files_found\n");

    foreach $sk (sort keys %STORED_E)
    {
	$printed_entry_ct++;
	$e = $STORED_E{$sk};
	$e =~ s|&nl;| |goi;
	$e =~ s|<(/?[b])>|{{$1}}|goi;
	$e =~ s|<(/?it)>|{{$1}}|goi;
	$e =~ s|\t||goi;
	$e =~ s|  +| |goi;
	$e =~ s| *> *|>|goi;
	$e =~ s| *< *|<|goi;
	$e =~ s|\{\{|<|goi;
	$e =~ s|\}\}|>|goi;
	$e =~ s|(</entry>)|$1\n|gio;
	printf(res_fp "%s", $e); 
    }
    close(res_fp);

    printf(STDERR "printed_entry_ct = $printed_entry_ct\n");

}


sub get_hdwd
{
    my($e) = @_;
    if ($e =~ m|<h>(.*?)</h>|i)
    {
	return $1;
    }
    else
    {
	$file_hdwd = $fname;
	$file_hdwd =~ s|^.*/||o;
	$file_hdwd =~ s|\..*$||o;
	return $file_hdwd;
    }
}

sub get_sortkey
{
    my($e) = @_;
    my($h);
    my($hm);
    $hm = "";
    $h = "";
    
    if ($e =~ m|<h>(.*?)</h>|i)
    {
	$h = $1;
    }
    if ($e =~ m|<hm>(.*?)</hm>|i)
    {
	$hm = $1;
    }
    $h =~ s|&[spw]b?;||go;
    $h =~ s|&middot;||go;
    $h =~ s|&[spw];||go;
    $h =~ s|&(.).*?;|$1|go;
    $h =~ s|^the ||oi;
    $h =~ s|\'||oi; # ignore apostrophe in sort key ...
    $h2 = $h;
    if ($h2 =~ s|^\-+||o)
    {
	$h2 = sprintf("%s-", $h2);
    }
    $h =~ s|^\-*||o;
    $h =~ s|\-||go;
    $h =~ s|,.*||o;
    $h =~ s|[^a-zA-Z]||go;       
    $h =~ tr|A-Z|a-z|;
#    $psk = sprintf("%s#%s#%s", $h, $h2, $hm);
    $sk = sprintf("%-25s%-5s%-25s", $h, $h2, $hm);
    return $sk;
}




