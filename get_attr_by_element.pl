#!/usr/local/bin/perl

line:

while (<>)

{
    s| >|>|g;
    s|<!--.*?-->||g;
    s|<!DOCTYPE.*?>||g;
    s|<\?.*?>||g;
    s| e\:[a-z_]+=".*?"||gi;
    s| xmlns\:[a-z]+=".*?"||gi;
    s| xmlns=".*?"||gi;

# debug
#    m|<h[ >].*?</h>|i;
#    $head=$&;
#    $head =~ s|<.*?>||g;
#    print "\n=$head\n";

    s|</.*?>||g;
    s| +>|>|g;
    s| +/>|/>|g;

    next line unless (/<entry/i);

    $atts = "composite|corpus_freq|depth|eid|href|file|fold|freq|imported|l[123]|mediarecord|name|ox3000|parent|picref|psg|pub|ref|ref2|n|recdate|sk|source|subref|webref|wd|wdstress|";

    s/ ($atts)=".*?"/ $1="###"/gi;

    s| +| |g;

    while (/<([^> ]+?) /)
	{
	    s|<([^> ]+?) (([^<>= ]+?)=".*?")|<$1|;
		print "\n$1\t$2\n";
	}
}
