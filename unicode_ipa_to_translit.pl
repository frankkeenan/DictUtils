#!/usr/local/bin/perl

while (<>)

{
    &ipa_fix;

    s|&#x02C8;|&p;|g;
    s|&#x02CC;|&s;|g;

    print;
}
sub ipa_fix
{

    my(@BITS);
    my($bit);
    my($res);

    s|<phon-gb>|<phon-gb >|g;
    s|<phon-us>|<phon-us >|g;
    s|(<eph ([^>]*)>)(.*?)(</eph>)|$1&split;&IPA;$3&split;$4|g;
    s|(<phon-gb ([^>]*)>)(.*?)(</phon-gb>)|$1&split;&IPA;$3&split;$4|g;
    s|(<phon-us ([^>]*)>)(.*?)(</phon-us>)|$1&split;&IPA;$3&split;$4|g;
    s|(<i ([^>]*)>)(.*?)(</i>)|$1&split;&IPA;$3&split;$4|g;
    s|(<y ([^>]*)>)(.*?)(</y>)|$1&split;&IPA;$3&split;$4|g;

    @BITS = split(/&split;/);
    foreach $bit (@BITS)
    {
        if ($bit =~ m|&IPA;|)
        {
            $bit =~ s|&IPA;||gi;

            $bit =~ s|&#x02C8;|"|gi;
            $bit =~ s|&#x02CC;|%|gi;
            $bit =~ s|&p;|"|gi;
            $bit =~ s|&s;|%|gi;

            $bit =~ s|t(&#x032C;)+|X|g; # IPA "flap" t ...
            $bit =~ s|&#x00E6;tusipa&#x02D0;|X|g; # IPA "flap" t ...

            $bit =~ s|&#x00E6;|&amp;|g; # IPA ae lig ...
            $bit =~ s|&#x0261;|g|g; # IPA g ...
            $bit =~ s|&#x00F0;|D|g; # IPA d with strikethrough ...
            $bit =~ s|&#x025B;|E|g; # IPA "open e/reversed 3" character ...
            $bit =~ s|&#x014B;|N|g; # IPA n with hooked right descender ...
            $bit =~ s|&#x0251;|A|g; # IPA a enclosed ...
            $bit =~ s|&#x0252;|Q|g; # IPA a enclosed upside down ...
            $bit =~ s|&#x0254;|O|g; # IPA c upside down ...
            $bit =~ s|&#x0259;|\@|g; # IPA e upside down ...
            $bit =~ s|&#x025C;|3|g; # IPA "3" symbol ...
            $bit =~ s|&#x026A;|I|g; # IPA i dotless ...
            $bit =~ s|&#x0283;|S|g; # IPA s elongated ...
            $bit =~ s|&#x028A;|U|g; # IPA "u"/upsilon ...
            $bit =~ s|&#x028C;|V|g; # IPA v upside down...
            $bit =~ s|&#x0292;|Z|g; # IPA "3/z" symbol ...
            $bit =~ s|&#x02D0;|\:|g; # IPA triangular colon ...
            $bit =~ s|&#x03B8;|T|g; # IPA theta symbol...

        }

        $res .= $bit;
    }

    $_ = $res;
}
