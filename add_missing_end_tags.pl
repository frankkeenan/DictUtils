#!/usr/local/bin/perl

# replace all "/>" with an explicit end tag ...

while (<>)

{
    if (/<entry/)
	{
        s|(<([a-z][^ >]*) [^>]*)/>|$1></$2>|gi;
	}
	print;
}
