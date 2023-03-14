#!/usr/local/bin/perl

print "<\?xml version=\"1\.0\"\?>\n<batch>\n";

line:

while (<>)

{

    next line unless (/<(alpha_start|entry)/i);

    print;

}

print "</batch>\n";

