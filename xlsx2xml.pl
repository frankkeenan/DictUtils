#!/usr/bin/perl
use Text::Iconv;
use Getopt::Std;
no warnings 'uninitialized';

my $converter = Text::Iconv -> new ("utf-8", "utf-8");

# Text::Iconv is not really required.
# This can be any object with the convert method. Or nothing.

use Spreadsheet::XLSX;

getopts('uf:L:IOD');
if ($opt_f =~ m|^ *$|)
{
    $infile = @ARGV[0];
} else {
    $infile = $opt_f;
}

if ($infile =~ m|^ *$|)
{
    printf(STDERR "USAGE: $0 -f fname.xlsx\n");
    exit;
}
#my $excel = Spreadsheet::XLSX -> new ('infile.xlsx', $converter);
my $excel = Spreadsheet::XLSX -> new ($infile, $converter);

printf("<xlsx>\n"); 
foreach my $sheet (@{$excel -> {Worksheet}})
{    
    printf("<Worksheet name=\"%s\">\n", $sheet->{Name});
    
    $sheet -> {MaxRow} ||= $sheet -> {MinRow};
    
    foreach my $row ($sheet -> {MinRow} .. $sheet -> {MaxRow})
    {

	printf("<row row=\"%s\">", $row); 
	$sheet -> {MaxCol} ||= $sheet -> {MinCol};	
	my $frow_col = $sheet->{MaxCol} + 1;
	foreach my $col ($sheet -> {MinCol} ..  $sheet -> {MaxCol})
	{
	    
	    my $cell = $sheet -> {Cells} [$row] [$col];
	    
	    if ($cell)
	    {
		printf("<col col=\"%s\">%s</col>", $col, $cell -> {Val});
	    }	    
	}
	my $frow;
	if ($row == 0)
	{
	    $frow = "FileRow";
	} else {
	    $frow  = sprintf("%s_%s", $infile, $row);
	}
	$frow =~ s|^.*/||;
	printf("<col col=\"%s\">%s</col>", $frow_col, $frow);
	printf("</row>\n"); 	
    }
    printf("</Worksheet>\n");    
}
printf("</xlsx>\n");
