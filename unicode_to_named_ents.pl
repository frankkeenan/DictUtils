#!/usr/local/bin/perl

sub unicode_to_named_ents
{
    my($e) = @_;
    unless ($NO_SYM_CHANGE)
    {
	$e =~ s|&\#x2021;|&Dagger;|gio;
	$e =~ s|&\#x2033;|&Prime;|gio;
	$e =~ s|&\#x279E;|&arrow;|gio;
	$e =~ s|&\#x2423;|&blank;|gio;
	$e =~ s|&\#x279E;|&blarrow;|gio;
	$e =~ s|&\#x2592;|&blk12;|gio;
	$e =~ s|&\#x2591;|&blk14;|gio;
	$e =~ s|&\#x2593;|&blk34;|gio;
	$e =~ s|&\#x2588;|&block;|gio;
	$e =~ s|&\#x2022;|&bull;|gio;
	$e =~ s|&\#x2105;|&careof;|gio;
	$e =~ s|&\#x2041;|&caret;|gio;
	$e =~ s|&\#x2713;|&check;|gio;
	$e =~ s|&\#x25CB;|&cir;|gio;
	$e =~ s|&\#x2663;|&clubs;|gio;
	$e =~ s|CO<z_sub>2</z_sub>|&co2;|gio;
	$e =~ s|&\#x00A9;|&copy;|gio;
	$e =~ s|&\#x2117;|&copysr;|gio;
	$e =~ s|&\#x2605;|&coresym;|gio;
	$e =~ s|&\#x2717;|&cross;|gio;
	$e =~ s|&\#x271D;|&crossl;|gio;
	$e =~ s|&\#x1D15F;|&crotchet;|gio;
	$e =~ s|&\#x221B;|&cuberoot;|gio;
	$e =~ s|&\#x00A4;|&curren;|gio;
	$e =~ s|&\#x2020;|&dagger;|gio;
	$e =~ s|&\#x2193;|&darr;|gio;
	$e =~ s|&\#x2010;|&dash;|gio;
	$e =~ s|&\#x00B0;|&deg;|gio;
	$e =~ s|&\#x03B4;|&delta;|gio;
	$e =~ s|&\#x2666;|&diams;|gio;
	$e =~ s|&\#x3003;|&ditto;|gio;
	$e =~ s|&\#x230D;|&dlcrop;|gio;
	$e =~ s|\.|&dp;|gio;              # SIH 26Mar12 - was s|.|&dp;|gio; ...
	$e =~ s|&\#x230C;|&drcrop;|gio;
	$e =~ s|&\#x25BF;|&dtri;|gio;
	$e =~ s|&\#x25BE;|&dtrif;|gio;
	$e =~ s|&\#x2004;|&emsp13;|gio;
	$e =~ s|&\#x2005;|&emsp14;|gio;
	$e =~ s|&\#x2003;|&emsp;|gio;
	$e =~ s|&\#x2002;|&ensp;|gio;
	$e =~ s|&\#x20AC;|&euro;|gio;
	$e =~ s|&\#x2640;|&female;|gio;
	$e =~ s|&\#x266D;|&flat;|gio;
	$e =~ s|&\#x00BD;|&frac12;|gio;
	$e =~ s|&\#x2153;|&frac13;|gio;
	$e =~ s|&\#x00BC;|&frac14;|gio;
	$e =~ s|&\#x2155;|&frac15;|gio;
	$e =~ s|&\#x2159;|&frac16;|gio;
	$e =~ s|&\#x215B;|&frac18;|gio;
	$e =~ s|&\#x2154;|&frac23;|gio;
	$e =~ s|&\#x2156;|&frac25;|gio;
	$e =~ s|&\#x00BE;|&frac34;|gio;
	$e =~ s|&\#x2157;|&frac35;|gio;
	$e =~ s|&\#x215C;|&frac38;|gio;
	$e =~ s|&\#x2158;|&frac45;|gio;
	$e =~ s|&\#x215A;|&frac56;|gio;
	$e =~ s|&\#x215D;|&frac58;|gio;
	$e =~ s|&\#x215E;|&frac78;|gio;
	$e =~ s|&\#x2322;|&frown;|gio;
	$e =~ s|&\#x201E;|&gql;|gio;
	$e =~ s|&\#x201C;|&gqr;|gio;
	$e =~ s|&\#x201F;|&gqr;|gio;      # SIH 18May16
	$e =~ s|H<z_sub>2</z_sub>O|&h2o;|gio;
	$e =~ s|&\#x200A;|&hairsp;|gio;
	$e =~ s|&\#x2665;|&hearts;|gio;
	$e =~ s|&\#x2026;|&hellip;|gio;
	$e =~ s|&\#x2015;|&horbar;|gio;
	$e =~ s|&\#x2043;|&hybull;|gio;
	$e =~ s|&\#x2010;|&hyphen;|gio;
	$e =~ s|&\#x2105;|&incare;|gio;
	$e =~ s|&\#x221E;|&infin;|gio;
	$e =~ s|&\#x2190;|&larr;|gio;
	$e =~ s|&\#x201C;|&ldquo;|gio;
	$e =~ s|&\#x201E;|&ldquor;|gio;
	$e =~ s|&\#x2584;|&lhblk;|gio;
	$e =~ s|&\#x25CA;|&loz;|gio;
	$e =~ s|&\#x2726;|&lozf;|gio;
	$e =~ s|&\#x2018;|&lsquo;|gio;
	$e =~ s|&\#x201A;|&lsquor;|gio;
	$e =~ s|&\#x25C3;|&ltri;|gio;
	$e =~ s|&\#x25C2;|&ltrif;|gio;
	$e =~ s|&\#x2642;|&male;|gio;
	$e =~ s|&\#x2720;|&malt;|gio;
	$e =~ s|&\#x25AE;|&marker;|gio;
	$e =~ s|&\#x2014;|&mdash;|gio;
	$e =~ s|&\#x2212;|&minus;|gio;
	$e =~ s|&\#x2026;|&mldr;|gio;
	$e =~ s|&\#x03BC;|&mu;|gio;
	$e =~ s|&\#x266E;|&natur;|gio;
	$e =~ s|&\#x2009;|&nbthinsp;|gio;
	$e =~ s|&\#x2013;|&ndash;|gio;
	$e =~ s|&\#x2260;|&ne;|gio; 
	$e =~ s|&\#x2025;|&nldr;|gio;
	$e =~ s|&\#x00AC;|&not;|gio;
	$e =~ s|&\#x0023;|&num;|gio;
	$e =~ s|&\#x2007;|&numsp;|gio;
	$e =~ s|&\#x0151;|&odblac;|gio;
	$e =~ s|&\#x2126;|&ohm;|gio;
	$e =~ s|&\#x03C9;|&omega;|gio;
#	s|o|&omicron;|go;        # SIH 28Jun12
	$e =~ s|&\#x00AA;|&ordf;|gio;
	$e =~ s|&\#x00BA;|&ordm;|gio;
	$e =~ s|&\#x00B6;|&para;|gio;
#	s||&pause;|go;
	$e =~ s|&\#x03D5;|&phi;|gio; # BC 15Sep04
	$e =~ s|&\#x260E;|&phone;|gio;
	$e =~ s|&\#x03C0;|&pi;|gio;
	$e =~ s|&\#x03C0;r&\#x00B2;|&pir2;|gio; 
	$e =~ s|&\#x002B;|&plus;|gio;
	$e =~ s|&\#x00B1;|&plusmn;|gio;
	$e =~ s|&\#x2032;|&prime;|gio;
	$e =~ s|&\#x03C8;|&psi;|gio;
	$e =~ s|&\#x2008;|&puncsp;|gio;
	$e =~ s|&\#x266A;|&quaver;|gio;
	$e =~ s|&\#x221A;|&radic;|gio;
	$e =~ s|&\#x2192;|&rarr;|gio;
	$e =~ s|&\#x201D;|&rdquo;|gio;
	$e =~ s|&\#x201C;|&rdquor;|gio;
	$e =~ s|&\#x25AD;|&rect;|gio;
	$e =~ s|&\#x00AE;|&reg;|gio;
	$e =~ s|&\#x03C1;|&rho;|gio;
	$e =~ s|&\#x2019;|&rsquo;|gio;
	$e =~ s|&\#x2018;|&rsquor;|gio;
	$e =~ s|&\#x25B9;|&rtri;|gio;
	$e =~ s|&\#x25B8;|&rtrif;|gio;
	$e =~ s|&\#x211E;|&rx;|gio;
	$e =~ s|&\#x1D15D;|&semibrev;|gio;
	$e =~ s|&\#x1D161;|&semiquav;|gio;
	$e =~ s|&\#x2736;|&sext;|gio;
	$e =~ s|&\#x266F;|&sharp;|gio;
	$e =~ s|&\#x03C3;|&sigma;|gio;
	$e =~ s|&\#x2323;|&smile;|gio;
	$e =~ s|&\#x2660;|&spades;|gio;
#	s| |&spc_sl2;|go;          SIH 28Jun12
#	s| |&spc_ssym;|go;         SIH 28Jun12
#	s| |&spc_xhm;|go;          SIH 28Jun12
	$e =~ s|&\#x25A1;|&squ;|gio;
	$e =~ s|&\#x25AA;|&squf;|gio;
	$e =~ s|&\#x22C6;|&star;|gio;
	$e =~ s|&\#x2605;|&starf;|gio;
	$e =~ s|&\#x2669;|&sung;|gio;
	$e =~ s|&#x2027;|&synsep;|gio;
	$e =~ s|&\#x2316;|&target;|gio;
	$e =~ s|&\#x03C4;|&tau;|gio;
	$e =~ s|&\#x1D120;|&tclef;|gio;
	$e =~ s|&\#x2315;|&telrec;|gio;
	$e =~ s|&\#x2009;|&thinsp;|gio;
	$e =~ s|&\#x2009;|&thinsp[^;]*;|gio;
	$e =~ s|&\#x2713;|&tick;|gio;
	$e =~ s|&\#x2122;|&trade;|gio;
	$e =~ s|&\#x2191;|&uarr;|gio;
	$e =~ s|&\#x2580;|&uhblk;|gio;
	$e =~ s|&\#x230F;|&ulcrop;|gio;
	$e =~ s|&\#x230E;|&urcrop;|gio;
	$e =~ s|&\#x25B5;|&utri;|gio;
	$e =~ s|&\#x25B4;|&utrif;|gio;
	$e =~ s|&\#x22EE;|&vellip;|gio;
	$e =~ s|&#x2022;|&w;|gio;
	$e =~ s|&\#x03BE;|&xi;|gio;
	$e =~ s|&#x27B1;|&xrefarrow;|gio;
	$e =~ s|&#x27B1;|&xrsym;|gio;
    }
#    s||&shy;|go;
#    s|&ensp;|&en;|go;       SIH 28Jun12
#    s|&rsquo;|&cq;|go;       "     "
#    s|&lsquo;|&oq;|go;       "     "
#    s|&lsquo;|&asp;|gio;     "     "
#    s|&hellip;|&ddd;|gio;    "     "
#    s|&thorn;|&th;|gio;      "     "
    $e =~ s|(&[^; ]*)caron;|$1hacek;|gio;
    $e =~ s|(&[^; ]*)caron;|$1breve;|gio;
    $e =~ s|(&[^; ]*)macr;|$1bar;|gio;
#    $e =~ s|(&[^; ]*)cedil;|$1ced;|gio;       SIH 06May16
    $e =~ s|(&[^; ]*)dot;|$1dabove;|gio;    
    $e =~ s|(&[^; ]*)ogon;|$1hook;|gio;    
    $e =~ s|&\#x013C;|&ldbelow;|gio;
    $e =~ s|&\#x0146;|&ndbelow;|gio;
    $e =~ s|&\#x0157;|&rdbelow;|gio;
    $e =~ s|&\#x015F;|&sdbelow;|gio;
    $e =~ s|&\#x0163;|&tdbelow;|gio;
    $e =~ s|&\#x0137;|&kdbelow;|gio;
    
    $e =~ s|&\#x00C6;|&AElig;|gio;
    $e =~ s|&\#x00C1;|&Aacute;|gio;
    $e =~ s|&\#x00C5;|&Aang;|gio;
    $e =~ s|&\#x0102;|&Abreve;|gio;
    $e =~ s|&\#x00C2;|&Acirc;|gio;
    $e =~ s|&\#x00C0;|&Agrave;|gio;
    $e =~ s|&\#x0102;|&Ahacek;|gio;
    $e =~ s|&\#x0100;|&Amac;|gio;
    $e =~ s|&\#x0100;|&Amacr?;|gio;
    $e =~ s|&\#x0104;|&Aogon;|gio;
    $e =~ s|&\#x00C5;|&Aring;|gio;
    $e =~ s|&\#x00C3;|&Atilde;|gio;
    $e =~ s|&\#x00C4;|&Auml;|gio;
    $e =~ s|&\#x0106;|&Cacute;|gio;
    $e =~ s|&\#x010C;|&Cbreve;|gio;
    $e =~ s|&\#x010C;|&Ccaron;|gio;
    $e =~ s|&\#x00C7;|&Ccedil;|gio;
    $e =~ s|&\#x0108;|&Ccirc;|gio;
    $e =~ s|&\#x010A;|&Cdot;|gio;
    $e =~ s|&\#x010C;|&Chacek;|gio;
    $e =~ s|&\#x010E;|&Dbreve;|gio;
    $e =~ s|&\#x010E;|&Dcaron;|gio;
    $e =~ s|&\#x0394;|&Delta;|gio;
    # $e =~ s|&\#x00B7;|&Dot;|gio;    SIH 10Jan19
    $e =~ s|&\#x0110;|&Dstrok;|gio;
    $e =~ s|&\#x014A;|&ENG;|gio;
    $e =~ s|&\#x00D0;|&ETH;|gio;
    $e =~ s|&\#x00C9;|&Eacute;|gio;
    $e =~ s|&\#x011A;|&Ebreve;|gio;
    $e =~ s|&\#x011A;|&Ecaron;|gio;
    $e =~ s|&\#x00CA;|&Ecirc;|gio;
    $e =~ s|&\#x0116;|&Edot;|gio;
    $e =~ s|&\#x00C8;|&Egrave;|gio;
    $e =~ s|&\#x0112;|&Emac;|gio;
    $e =~ s|&\#x0112;|&Emacr?;|gio;
    $e =~ s|&\#x0118;|&Eogon;|gio;
    $e =~ s|&\#x00CB;|&Euml;|gio;
    $e =~ s|&\#x0393;|&Gamma;|gio;
    $e =~ s|&\#x011E;|&Gbreve;|gio;
    $e =~ s|&\#x0122;|&Gcedil;|gio;
    $e =~ s|&\#x011C;|&Gcirc;|gio;
    $e =~ s|&\#x0120;|&Gdot;|gio;
    $e =~ s|&\#x0124;|&Hcirc;|gio;
    $e =~ s|&\#x0126;|&Hstrok;|gio;
    $e =~ s|&\#x0132;|&IJlig;|gio;
    $e =~ s|&\#x00CD;|&Iacute;|gio;
    $e =~ s|&\#x00CE;|&Icirc;|gio;
    $e =~ s|&\#x0130;|&Idot;|gio;
    $e =~ s|&\#x00CC;|&Igrave;|gio;
    $e =~ s|&\#x012A;|&Imacr?;|gio;
    $e =~ s|&\#x012E;|&Iogon;|gio;
    $e =~ s|&\#x0128;|&Itilde;|gio;
    $e =~ s|&\#x00CF;|&Iuml;|gio;
    $e =~ s|&\#x0134;|&Jcirc;|gio;
    $e =~ s|&\#x0136;|&Kcedil;|gio;
    $e =~ s|&\#x0139;|&Lacute;|gio;
    $e =~ s|&\#x039B;|&Lambda;|gio;
    $e =~ s|&\#x013D;|&Lbreve;|gio;
    $e =~ s|&\#x013D;|&Lcaron;|gio;
    $e =~ s|&\#x013B;|&Lcedil;|gio;
    $e =~ s|&\#x0141;|&Lcross;|gio;
    $e =~ s|&\#x013F;|&Llmiddot;|gio;
    $e =~ s|&\#x013F;|&Lmidot;|gio;
    $e =~ s|&\#x0141;|&Lstrok;|gio;
    # $e =~ s|&ndash;|&NDASH;|go;      SIH 02May14
    $e =~ s|&\#x0143;|&Nacute;|gio;
    $e =~ s|&\#x0147;|&Nbreve;|gio;
    $e =~ s|&\#x0147;|&Ncaron;|gio;
    $e =~ s|&\#x0145;|&Ncedil;|gio;
    $e =~ s|&\#x00D1;|&Ntilde;|gio;
    $e =~ s|&\#x0152;|&OElig;|gio;
    $e =~ s|&\#x00D3;|&Oacute;|gio;
    $e =~ s|&\#x00D4;|&Ocirc;|gio;
    $e =~ s|&\#x0150;|&Odblac;|gio;
    $e =~ s|&\#x00D2;|&Ograve;|gio;
    $e =~ s|&\#x014C;|&Omacr?;|gio;
    $e =~ s|&\#x03A9;|&Omega;|gio;
    $e =~ s|&\#x00D8;|&Oslash;|gio;
    $e =~ s|&\#x00D5;|&Otilde;|gio;
    $e =~ s|&\#x00D6;|&Ouml;|gio;
    $e =~ s|&\#x03A6;|&Phi;|gio;
    $e =~ s|&\#x03A0;|&Pi;|gio;
    $e =~ s|&\#x03A8;|&Psi;|gio;
    $e =~ s|&\#x0154;|&Racute;|gio;
    $e =~ s|&\#x0158;|&Rbreve;|gio;
    $e =~ s|&\#x0158;|&Rcaron;|gio;
    $e =~ s|&\#x0156;|&Rcedil;|gio;
    $e =~ s|&\#x015A;|&Sacute;|gio;
    $e =~ s|&\#x0160;|&Sbreve;|gio;
    $e =~ s|&\#x0160;|&Scaron;|gio;
    $e =~ s|&\#x015E;|&Scedil;|gio;
    $e =~ s|&\#x015C;|&Scirc;|gio;
    $e =~ s|&\#x03A3;|&Sigma;|gio;
    $e =~ s|&\#x00DE;|&THORN;|gio;
    $e =~ s|&\#x0164;|&Tbreve;|gio;
    $e =~ s|&\#x0164;|&Tcaron;|gio;
    $e =~ s|&\#x0162;|&Tcedil;|gio;
    $e =~ s|&\#x0398;|&Theta;|gio;
    $e =~ s|&\#x0166;|&Tstrok;|gio;
    $e =~ s|&\#x00DA;|&Uacute;|gio;
    $e =~ s|&\#x016C;|&Ubreve;|gio;
    $e =~ s|&\#x00DB;|&Ucirc;|gio;
    $e =~ s|&\#x0170;|&Udblac;|gio;
    $e =~ s|&\#x00D9;|&Ugrave;|gio;
    $e =~ s|&\#x016A;|&Umacr?;|gio;
    $e =~ s|&\#x0172;|&Uogon;|gio;
    $e =~ s|&\#x03D2;|&Upsi;|gio;
    $e =~ s|&\#x016E;|&Uring;|gio;
    $e =~ s|&\#x0168;|&Utilde;|gio;
    $e =~ s|&\#x00DC;|&Uuml;|gio;
    $e =~ s|&\#x0174;|&Wcirc;|gio;
    $e =~ s|&\#x039E;|&Xi;|gio;
    $e =~ s|&\#x00DD;|&Yacute;|gio;
    $e =~ s|&\#x0176;|&Ycirc;|gio;
    $e =~ s|&\#x0178;|&Yuml;|gio;
    $e =~ s|&\#x0179;|&Zacute;|gio;
    $e =~ s|&\#x017D;|&Zbreve;|gio;
    $e =~ s|&\#x017D;|&Zcaron;|gio;
    $e =~ s|&\#x017B;|&Zdot;|gio;
    $e =~ s|&\#x00E1;|&aacute;|gio;
    $e =~ s|&\#x00E5;|&aang;|gio;
    $e =~ s|&\#x0105;|&abcedil;|gio;
    $e =~ s|&\#x0103;|&acaron;|gio;
    $e =~ s|&\#x00E2;|&acirc;|gio;
    $e =~ s|&\#x01FD;|&aeacute;|gio;
    $e =~ s|&\#x00E6;|&aelig;|gio;
    $e =~ s|&\#x01E3;|&aemac;|gio;
    $e =~ s|&\#x00E0;|&agrave;|gio;
    $e =~ s|&\#x0103;|&ahacek;|gio;
    $e =~ s|&\#x03B1;|&alpha;|gio;
    $e =~ s|&\#x0101;|&amacr?;|gio;
    $e =~ s|&\#x0026;|&amp;|gio;
    $e =~ s|&\#x0105;|&aogon;|gio;
    $e =~ s|&apos;|&ap;|gio;
    $e =~ s|&\#x0027;|&apos;|gio;
    $e =~ s|&\#x00E5;|&aring;|gio;
    $e =~ s|&\#x002A;|&ast;|gio;
    $e =~ s|&\#x00E3;|&atilde;|gio;
    $e =~ s|&\#x00E4;|&auml;|gio;
    $e =~ s|&\#x1D122;|&bclef;|gio;
    $e =~ s|&\#x03B2;|&beta;|gio;
    $e =~ s|&\#x00A6;|&brvbar;|gio;
    $e =~ s|&\#x005C;|&bsol;|gio;
    $e =~ s|&\#x0107;|&cacute;|gio;
    $e =~ s|&\#x010D;|&cbreve;|gio;
    $e =~ s|&\#x010D;|&ccaron;|gio;
    $e =~ s|&\#x00E7;|&ccedil;|gio;
    $e =~ s|&\#x0109;|&ccirc;|gio;
    $e =~ s|&\#x010B;|&cdot;|gio;
    $e =~ s|&\#x00B8;|&cedil;|gio;
    $e =~ s|&\#x00A2;|&cent;|gio;
    $e =~ s|&\#x010D;|&chacek;|gio;
    $e =~ s|&\#x03C7;|&chi;|gio;
    $e =~ s|&\#x005E;|&circ;|gio;
    $e =~ s|&\#x003A;|&colon;|gio;
    $e =~ s|&\#x002C;|&comma;|gio;
    $e =~ s|&\#x0040;|&commat;|gio;
    $e =~ s|&\#x010F;|&dbreve;|gio;
    $e =~ s|&\#x010F;|&dcaron;|gio;
    $e =~ s|&\#x00F7;|&divide;|gio;
    $e =~ s|&\#x0131;|&dlessi;|gio;
    $e =~ s|&\#x0024;|&dollar;|gio;
    $e =~ s|&\#x0111;|&dstrok;|gio;
    $e =~ s|&\#x00E9;|&eacute;|gio;
    $e =~ s|&\#x0119;|&ebcedil;|gio;
    $e =~ s|&\#x011B;|&ebreve;|gio;
    $e =~ s|&\#x011B;|&ecaron;|gio;
    $e =~ s|&\#x00EA;|&ecirc;|gio;
    $e =~ s|&\#x0117;|&edot;|gio;
    $e =~ s|&\#x00E8;|&egrave;|gio;
    $e =~ s|&\#x0113;|&emacr?;|gio;
    $e =~ s|&\#x014B;|&eng;|gio;
    $e =~ s|&\#x0119;|&eogon;|gio;
    $e =~ s|&\#x03F5;|&epsi;|gio;
    $e =~ s|&\#x003D;|&equals;|gio;
    $e =~ s|&\#x03B7;|&eta;|gio;
    $e =~ s|&\#x00F0;|&eth;|gio;
    $e =~ s|&\#x00EB;|&euml;|gio;
    $e =~ s|&\#x0021;|&excl;|gio;
    $e =~ s|1/1000|&f1d1000;|gio;
    $e =~ s|1/100|&f1d100;|gio;
    $e =~ s|1/10|&f1d10;|gio;
    $e =~ s|1/15|&f1d15;|gio;
    $e =~ s|1/16|&f1d16;|gio;
    $e =~ s|&\#xFB03;|&ffilig;|gio;
    $e =~ s|&\#xFB00;|&fflig;|gio;
    $e =~ s|&\#xFB04;|&ffllig;|gio;
    $e =~ s|&\#xFB01;|&filig;|gio;
    $e =~ s|&\#xFB02;|&fllig;|gio;
    $e =~ s|1/7|&frac17;|gio;
    $e =~ s|1/9|&frac19;|gio;
    $e =~ s|7/6|&frac76;|gio;
    $e =~ s|&\#x01F5;|&gacute;|gio;
    $e =~ s|&\#x03B3;|&gamma;|gio;
    $e =~ s|&\#x011F;|&gcaron;|gio;
    $e =~ s|&\#x011D;|&gcirc;|gio;
    $e =~ s|&\#x0121;|&gdot;|gio;
#    s|,|&gdp;|go;              SIH 28Jun12
    $e =~ s|&\#x0060;|&grave;|gio;
#    s|/|&grslash;|go;          SIH 28Jun12
    $e =~ s|&\#x003E;|&gt;|gio;
    $e =~ s|&\#x00BD;|&half;|gio;
    $e =~ s|&frac12;|&half;|gio;
    $e =~ s|&\#x0125;|&hcirc;|gio;
    $e =~ s|&\#x0127;|&hstrok;|gio;
    $e =~ s|&\#x00ED;|&iacute;|gio;
    $e =~ s|&\#x012D;|&icaron;|gio;
    $e =~ s|&\#x00EE;|&icirc;|gio;
    $e =~ s|&\#x00A1;|&iexcl;|gio;
    $e =~ s|&\#x00EC;|&igrave;|gio;
    $e =~ s|&\#x0133;|&ijlig;|gio;
    $e =~ s|&\#x012B;|&imacr?;|gio;
    $e =~ s|&\#x0131;|&inodot;|gio;
    $e =~ s|&\#x012F;|&iogon;|gio;
    $e =~ s|&\#x03B9;|&iota;|gio;
    $e =~ s|&\#x00BF;|&iquest;|gio;
    $e =~ s|&\#x0129;|&itilde;|gio;
    $e =~ s|&\#x00EF;|&iuml;|gio;
    $e =~ s|&\#x0135;|&jcirc;|gio;
    $e =~ s|&\#x03BA;|&kappa;|gio;
    $e =~ s|&\#x0137;|&kcedil;|gio;
    $e =~ s|&star;|&key;|gio;
#    s| |&key_space;|go;        SIH 28Jun12
    $e =~ s|&\#x0138;|&kgreen;|gio;
    $e =~ s|&\#x013A;|&lacute;|gio;
    $e =~ s|&\#x03BB;|&lambda;|gio;
    $e =~ s|&\#x00AB;|&laquo;|gio;
    $e =~ s|&\#x013E;|&lbreve;|gio;
    $e =~ s|&\#x013E;|&lcaron;|gio;
    $e =~ s|&\#x013C;|&lcedil;|gio;
    $e =~ s|&\#x0142;|&lcross;|gio;
    $e =~ s|&\#x007B;|&lcub;|gio;
    $e =~ s|&#x005F;|&line;|gio;
    $e =~ s|&\#x0140;|&lmidot;|gio;
    $e =~ s|&\#x005F;|&lowbar;|gio;
    $e =~ s|&\#x0028;|&lpar;|gio;
    $e =~ s|&\#x005B;|&lsqb;|gio;
    $e =~ s|&\#x0142;|&lstrok;|gio;
    $e =~ s|&\#x003C;|&lt;|gio;
    $e =~ s|&\#x00AF;|&macr?;|gio;
    $e =~ s|&\#x00B5;|&micro;|gio;
    $e =~ s|&\#x1D15E;|&minim;|gio;
    $e =~ s|&\#x0144;|&nacute;|gio;
    $e =~ s|&\#x0149;|&napos;|gio;
#    s|-|&nbhyph;|go;           SIH 28Jun12
#    s|-|&nbhyphen;|go;         SIH 28Jun12
    $e =~ s|&\#x0148;|&nbreve;|gio;
    $e =~ s|&\#x00A0;|&nbsp;|gio;
    $e =~ s|&thinsp;|&nbthinsp;|gio;
    $e =~ s|&\#x0148;|&ncaron;|gio;
    $e =~ s|&\#x0146;|&ncedil;|gio;
    $e =~ s|&\#x00F1;|&ntilde;|gio;
    $e =~ s|&\#x03BD;|&nu;|gio;
    $e =~ s|&\#x00F3;|&oacute;|gio;
#    s|/|&ob;|goi;              SIH 28Jun12
    $e =~ s|&\#x00F4;|&ocirc;|gio;
    $e =~ s|&\#x0153;|&oe;|gio;
    $e =~ s|&\#x0153;|&oelig;|gio;
    $e =~ s|&\#x00F2;|&ograve;|gio;
    $e =~ s|&\#x014D;|&omacr?;|gio;
    $e =~ s|&\#x01EB;|&oogon;|gio; # close but ...
    $e =~ s|&\#x00F8;|&oslash;|gio;
    $e =~ s|&\#x00F5;|&otilde;|gio;
    $e =~ s|&\#x00F6;|&ouml;|gio;
    $e =~ s|&\#x02C8;|&p;|gio; 
    $e =~ s|&\#x0025;|&percnt;|gio;
    $e =~ s|&\#x002E;|&period;|gio;
    $e =~ s|&phi;|&phis;|gio;
    $e =~ s|&#x007C;|&pipe;|gio;
    $e =~ s|&\#x00A3;|&pound;|gio;
    $e =~ s|&\#x00A3;|&pound_currency;|gio;
    $e =~ s|&\#x00A3;|&poundce;|gio;
    $e =~ s|&\#x02C8;|&pstress;|gio; 
    $e =~ s|&\#x003F;|&quest;|gio;
    $e =~ s|&\#x0022;|&quot;|gio;
    $e =~ s|&\#x0155;|&racute;|gio;
    $e =~ s|&\#x00BB;|&raquo;|gio;
    $e =~ s|&\#x0159;|&rbreve;|gio;
    $e =~ s|&\#x0159;|&rcaron;|gio;
    $e =~ s|&\#x0157;|&rcedil;|gio;
    $e =~ s|&\#x007D;|&rcub;|gio;
    $e =~ s|&\#x0029;|&rpar;|gio;
    $e =~ s|&\#x005D;|&rsqb;|gio;
    $e =~ s|&#x02CC;|&s;|gio;
    $e =~ s|&\#x015B;|&sacute;|gio;
    $e =~ s|&\#x0161;|&sbreve;|gio;
    $e =~ s|&\#x0161;|&scaron;|gio;
    $e =~ s|&\#x015F;|&sced;|gio;
    $e =~ s|&\#x015F;|&scedil;|gio;
    $e =~ s|&\#x015D;|&scirc;|gio;
    $e =~ s|&\#x00A7;|&sect;|gio;
    $e =~ s|&\#x003B;|&semi;|gio;
    $e =~ s|&\#x00AD;|&shy;|gio;
#    s|/|&sol;|go;             SIH 28Jun12
#    s|/|&sol;|goi;            SIH 28Jun12
    $e =~ s|&#x02CC;|&sstress;|gio;
    $e =~ s|<z_sub>([0-9]+)</z_sub>|&sub\1;|gio;
    $e =~ s|<z_sup>([0-9]+)</z_sup>|&sup\1;|gio;
    $e =~ s|&\#x00B9;|&sup1;|gio;
    $e =~ s|&\#x00B2;|&sup2;|gio;
    $e =~ s|&\#x00B3;|&sup3;|gio;
    $e =~ s|<z_sup>-([0-9]+)</z_sup>|&supminus\1;|gio;
    $e =~ s|&\#x00DF;|&szlig;|gio;
    $e =~ s|&\#x0165;|&tbreve;|gio;
    $e =~ s|&\#x0165;|&tcaron;|gio;
    $e =~ s|&\#x0163;|&tcedil;|gio;
    $e =~ s|&\#x03B8;|&theta;|gio; # BC 15Sep04
    $e =~ s|&theta;|&thetas;|gio;
    $e =~ s|&\#x00FE;|&thorn;|gio;
    $e =~ s|&\#x02DC;|&tilde;|gio;
#    s|~|&tilde;|go;           SIH 28Jun12
    $e =~ s|&\#x00D7;|&times;|gio;
    $e =~ s|&\#x0167;|&tstrok;|gio;
    $e =~ s|&\#x00FA;|&uacute;|gio;
    $e =~ s|&\#x016F;|&uang;|gio;
    $e =~ s|&\#x016D;|&ubreve;|gio;
    $e =~ s|&\#x016D;|&ucaron;|gio;
    $e =~ s|&\#x00FB;|&ucirc;|gio;
    $e =~ s|&\#x0171;|&udblac;|gio;
    $e =~ s|&\#x00F9;|&ugrave;|gio;
    $e =~ s|&\#x016B;|&umacr?;|gio;
    $e =~ s|&\#x0173;|&uogon;|gio;
    $e =~ s|&\#x03C5;|&upsi;|gio;
    $e =~ s|&\#x016F;|&uring;|gio;
    $e =~ s|&\#x0169;|&utilde;|gio;
    $e =~ s|&\#x00FC;|&uuml;|gio;
    $e =~ s|&\#x00FC;|&uumlaut;|gio;
    $e =~ s|&\#x007C;|&verbar;|gio;
    $e =~ s|&thinsp;|&vthinsp;|gio;
    # $e =~ s|&\#x00B7;|&w;|gio;      SIH 10Jan19
    $e =~ s|&\#x0175;|&wcirc;|gio;
    $e =~ s|&\#x00FD;|&yacute;|gio;
    $e =~ s|&\#x0177;|&ycirc;|gio;
    $e =~ s|&\#x00A5;|&yen;|gio;
    $e =~ s|&\#x04EF;|&ymacr?;|gio;
    $e =~ s|&\#x00FF;|&yuml;|gio;
    $e =~ s|&\#x017A;|&zacute;|gio;
    $e =~ s|&\#x017E;|&zbreve;|gio;
    $e =~ s|&\#x017E;|&zcaron;|gio;
    $e =~ s|&\#x017C;|&zdot;|gio;
    $e =~ s|&\#x03B6;|&zeta;|gio;
    $e =~ s|&\#x0140;|l&llmiddot;|gio;


    $e =~ s|([a-z])&\#x0331;|&$1bbelow;|gio;    
    $e =~ s|([a-z])&\#x0345;|&$1dbelow;|gio;    
    $e =~ s|([a-z])&\#x0342;|&$1tilde;|gio; 
    $e =~ s|([a-z])&\#x0304;|&$1macr?;|gio;       
    $e =~ s|([a-z])&\#x0307;|&$1dot;|gio;    

#   Greek characters ...

    $e =~ s|&\#x0391;|&Agr;|gio;	# Alpha
    $e =~ s|&\#x0392;|&Bgr;|gio;	# Beta
    $e =~ s|&\#x0394;|&Dgr;|gio;	# Delta
    $e =~ s|&\#x0397;|&EEgr;|gio;	# Eta
    $e =~ s|&\#x0395;|&Egr;|gio;	# Epsilon
    $e =~ s|&\#x0393;|&Ggr;|gio;	# Gamma
    $e =~ s|&\#x0399;|&Igr;|gio;	# Iota
    $e =~ s|&\#x03A7;|&KHgr;|gio;	# Chi
    $e =~ s|&\#x039A;|&Kgr;|gio;	# Kappa
    $e =~ s|&\#x039B;|&Lgr;|gio;	# Lambda
    $e =~ s|&\#x039C;|&Mgr;|gio;	# Mu
    $e =~ s|&\#x039D;|&Ngr;|gio;	# Nu
    $e =~ s|&\#x03A9;|&OHgr;|gio;	# Omega
    $e =~ s|&\#x039F;|&Ogr;|gio;	# Omicron
    $e =~ s|&\#x03A6;|&PHgr;|gio;	# Phi
    $e =~ s|&\#x0308;|&PSgr;|gio;	# Psi
    $e =~ s|&\#x03A0;|&Pgr;|gio;	# Pi
    $e =~ s|&\#x03A1;|&Rgr;|gio;	# Rho
    $e =~ s|&\#x03A3;|&Sgr;|gio;	# Sigma
    $e =~ s|&\#x0398;|&THgr;|gio;	# Theta
    $e =~ s|&\#x03A4;|&Tgr;|gio;	# Tau
    $e =~ s|&\#x03A5;|&Ugr;|gio;	# Upsilon
    $e =~ s|&\#x039E;|&Xgr;|gio;	# Xi
    $e =~ s|&\#x0396;|&Zgr;|gio;	# Zeta

    $e =~ s|&\#x03B1;|&agr;|gio;	# alpha
    $e =~ s|&\#x03B2;|&bgr;|gio;	# beta
    $e =~ s|&\#x03B4;|&dgr;|gio;	# delta
    $e =~ s|&\#x03B7;|&eegr;|gio;	# eta
    $e =~ s|&\#x03B5;|&egr;|gio;	# epsilon
    $e =~ s|&\#x03B3;|&ggr;|gio;	# gamma
    $e =~ s|&\#x03B9;|&igr;|gio;	# iota
    $e =~ s|&\#x03BA;|&kgr;|gio;	# kappa
    $e =~ s|&\#x03C7;|&khgr;|gio;	# chi
    $e =~ s|&\#x03BB;|&lgr;|gio;	# lambda
    $e =~ s|&\#x03BC;|&mgr;|gio;	# mu
    $e =~ s|&\#x03BD;|&ngr;|gio;	# nu
    $e =~ s|&\#x03BF;|&ogr;|gio;	# omicron
    $e =~ s|&\#x03C9;|&ohgr;|gio;	# omega
    $e =~ s|&\#x03C0;|&pgr;|gio;	# pi
    $e =~ s|&\#x03C6;|&phgr;|gio;	# phi
    $e =~ s|&\#x03C8;|&psgr;|gio;	# psi
    $e =~ s|&\#x03C1;|&rgr;|gio;	# rho
    $e =~ s|&\#x03C3;|&sgr;|gio;	# sigma
    $e =~ s|&\#x03C4;|&tgr;|gio;	# tau
    $e =~ s|&\#x03B8;|&thgr;|gio;	# theta
    $e =~ s|&\#x03C5;|&ugr;|gio;	# upsilon
    $e =~ s|&\#x03BE;|&xgr;|gio;	# xi
    $e =~ s|&\#x03B6;|&zgr;|gio;	# zeta
    return $e;    
}

1;
