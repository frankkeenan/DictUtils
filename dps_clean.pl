#!/usr/local/bin/perl

# clean up exports from DPS ...

while (<>)

{

#   zap unwanted end tags on empty elements ...

    s|</etymref>||g;
    s|</g>||g;
    s|</gi>||g;
    s|</gr>||g;
    s|</guide_sense>||g;
    s|</guide_infobox>||g;
    s|</il>||g;
    s|</ill>||g;
    s|</p>||g;
    s|</pt>||g;
    s|</pvpt>||g;
    s|</r>||g;
    s|</s>||g;
    s|</set>||g;
    s|</wfp>||g;
    s|</unp>||g;
    s|</vpref>||g;
    s|</zp_key>||g;

    s|\{synsep\}|&synsep;|g;

    print;

}


