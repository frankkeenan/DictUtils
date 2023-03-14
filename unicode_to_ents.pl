#!/usr/local/bin/perl

sub unicode_to_ents
{
    unless ($NO_SYM_CHANGE)
    {
	s|&\#x2021;|&Dagger;|go;
	s|&\#x2033;|&Prime;|go;
	s|&\#x279E;|&arrow;|go;
	s|&\#x2423;|&blank;|go;
	s|&\#x279E;|&blarrow;|go;
	s|&\#x2592;|&blk12;|go;
	s|&\#x2591;|&blk14;|go;
	s|&\#x2593;|&blk34;|go;
	s|&\#x2588;|&block;|go;
	s|&\#x2022;|&bull;|go;
	s|&\#x2105;|&careof;|go;
	s|&\#x2041;|&caret;|go;
	s|&\#x2713;|&check;|go;
	s|&\#x25CB;|&cir;|go;
	s|&\#x2663;|&clubs;|go;
	s|CO<z_sub>2</z_sub>|&co2;|gio;
	s|&\#x00A9;|&copy;|go;
	s|&\#x2117;|&copysr;|go;
	s|&\#x2605;|&coresym;|gio;
	s|&\#x2717;|&cross;|go;
	s|&\#x271D;|&crossl;|go;
	s|&\#x1D15F;|&crotchet;|go;
	s|&\#x221B;|&cuberoot;|go;
	s|&\#x00A4;|&curren;|go;
	s|&\#x2020;|&dagger;|go;
	s|&\#x2193;|&darr;|go;
	s|&\#x2010;|&dash;|go;
	s|&\#x00B0;|&deg;|go;
	s|&\#x03B4;|&delta;|go;
	s|&\#x2666;|&diams;|go;
	s|&\#x3003;|&ditto;|go;
	s|&\#x230D;|&dlcrop;|go;
	s|\.|&dp;|go;              # SIH 26Mar12 - was s|.|&dp;|go; ...
	s|&\#x230C;|&drcrop;|go;
	s|&\#x25BF;|&dtri;|go;
	s|&\#x25BE;|&dtrif;|go;
	s|&\#x2004;|&emsp13;|go;
	s|&\#x2005;|&emsp14;|go;
	s|&\#x2003;|&emsp;|go;
	s|&\#x2002;|&ensp;|go;
	s|&\#x20AC;|&euro;|go;
	s|&\#x2640;|&female;|go;
	s|&\#x266D;|&flat;|go;
	s|&\#x00BD;|&frac12;|go;
	s|&\#x2153;|&frac13;|go;
	s|&\#x00BC;|&frac14;|go;
	s|&\#x2155;|&frac15;|go;
	s|&\#x2159;|&frac16;|go;
	s|&\#x215B;|&frac18;|go;
	s|&\#x2154;|&frac23;|go;
	s|&\#x2156;|&frac25;|go;
	s|&\#x00BE;|&frac34;|go;
	s|&\#x2157;|&frac35;|go;
	s|&\#x215C;|&frac38;|go;
	s|&\#x2158;|&frac45;|go;
	s|&\#x215A;|&frac56;|go;
	s|&\#x215D;|&frac58;|go;
	s|&\#x215E;|&frac78;|go;
	s|&\#x2322;|&frown;|go;
	s|&\#x201E;|&gql;|go;
	s|&\#x201C;|&gqr;|go;
	s|H<z_sub>2</z_sub>O|&h2o;|gio;
	s|&\#x200A;|&hairsp;|go;
	s|&\#x2665;|&hearts;|go;
	s|&\#x2026;|&hellip;|go;
	s|&\#x2015;|&horbar;|go;
	s|&\#x2043;|&hybull;|go;
	s|&\#x2010;|&hyphen;|go;
	s|&\#x2105;|&incare;|go;
	s|&\#x221E;|&infin;|go;
	s|&\#x2190;|&larr;|go;
	s|&\#x201C;|&ldquo;|go;
	s|&\#x201E;|&ldquor;|go;
	s|&\#x2584;|&lhblk;|go;
	s|&\#x25CA;|&loz;|go;
	s|&\#x2726;|&lozf;|go;
	s|&\#x2018;|&lsquo;|go;
	s|&\#x201A;|&lsquor;|go;
	s|&\#x25C3;|&ltri;|go;
	s|&\#x25C2;|&ltrif;|go;
	s|&\#x2642;|&male;|go;
	s|&\#x2720;|&malt;|go;
	s|&\#x25AE;|&marker;|go;
	s|&\#x2014;|&mdash;|go;
	s|&\#x2212;|&minus;|go;
	s|&\#x2026;|&mldr;|go;
	s|&\#x03BC;|&mu;|go;
	s|&\#x266E;|&natur;|go;
	s|&\#x2009;|&nbthinsp;|go;
	s|&\#x2013;|&ndash;|go;
	s|&\#x2260;|&ne;|go; 
	s|&\#x2025;|&nldr;|go;
	s|&\#x00AC;|&not;|go;
	s|&\#x0023;|&num;|go;
	s|&\#x2007;|&numsp;|go;
	s|&\#x0151;|&odblac;|go;
	s|&\#x2126;|&ohm;|go;
	s|&\#x03C9;|&omega;|go;
#	s|o|&omicron;|go;        # SIH 28Jun12
	s|&\#x00AA;|&ordf;|go;
	s|&\#x00BA;|&ordm;|go;
	s|&\#x00B6;|&para;|go;
#	s||&pause;|go;
	s|&\#x03D5;|&phi;|go; # BC 15Sep04
	s|&\#x260E;|&phone;|go;
	s|&\#x03C0;|&pi;|go;
	s|&\#x03C0;r&\#x00B2;|&pir2;|go; 
	s|&\#x002B;|&plus;|go;
	s|&\#x00B1;|&plusmn;|go;
	s|&\#x2032;|&prime;|go;
	s|&\#x03C8;|&psi;|go;
	s|&\#x2008;|&puncsp;|go;
	s|&\#x266A;|&quaver;|go;
	s|&\#x221A;|&radic;|go;
	s|&\#x2192;|&rarr;|go;
	s|&\#x201D;|&rdquo;|go;
	s|&\#x201C;|&rdquor;|go;
	s|&\#x25AD;|&rect;|go;
	s|&\#x00AE;|&reg;|go;
	s|&\#x03C1;|&rho;|go;
	s|&\#x2019;|&rsquo;|go;
	s|&\#x2018;|&rsquor;|go;
	s|&\#x25B9;|&rtri;|go;
	s|&\#x25B8;|&rtrif;|go;
	s|&\#x211E;|&rx;|go;
	s|&\#x1D15D;|&semibrev;|go;
	s|&\#x1D161;|&semiquav;|go;
	s|&\#x2736;|&sext;|go;
	s|&\#x266F;|&sharp;|go;
	s|&\#x03C3;|&sigma;|go;
	s|&\#x2323;|&smile;|go;
	s|&\#x2660;|&spades;|go;
#	s| |&spc_sl2;|go;          SIH 28Jun12
#	s| |&spc_ssym;|go;         SIH 28Jun12
#	s| |&spc_xhm;|go;          SIH 28Jun12
	s|&\#x25A1;|&squ;|go;
	s|&\#x25AA;|&squf;|go;
	s|&\#x22C6;|&star;|go;
	s|&\#x2605;|&starf;|go;
	s|&\#x2669;|&sung;|go;
	s|&#x2027;|&synsep;|go;
	s|&\#x2316;|&target;|go;
	s|&\#x03C4;|&tau;|go;
	s|&\#x1D120;|&tclef;|go;
	s|&\#x2315;|&telrec;|go;
	s|&\#x2009;|&thinsp;|go;
	s|&\#x2009;|&thinsp[^;]*;|go;
	s|&\#x2713;|&tick;|go;
	s|&\#x2122;|&trade;|go;
	s|&\#x2191;|&uarr;|go;
	s|&\#x2580;|&uhblk;|go;
	s|&\#x230F;|&ulcrop;|go;
	s|&\#x230E;|&urcrop;|go;
	s|&\#x25B5;|&utri;|go;
	s|&\#x25B4;|&utrif;|go;
	s|&\#x22EE;|&vellip;|go;
	s|&#x2022;|&w;|go;
	s|&\#x03BE;|&xi;|go;
	s|&#x27B1;|&xrefarrow;|go;
	s|&#x27B1;|&xrsym;|gio;

    }
#    s||&shy;|go;
#    s|&ensp;|&en;|go;       SIH 28Jun12
#    s|&rsquo;|&cq;|go;       "     "
#    s|&lsquo;|&oq;|go;       "     "
#    s|&lsquo;|&asp;|gio;     "     "
#    s|&hellip;|&ddd;|gio;    "     "
#    s|&thorn;|&th;|gio;      "     "

    s|(&[^; ]*)caron;|$1hacek;|gio;
    s|(&[^; ]*)caron;|$1breve;|gio;
    s|(&[^; ]*)macr;|$1bar;|gio;
    s|(&[^; ]*)cedil;|$1ced;|gio;
    s|(&[^; ]*)dot;|$1dabove;|gio;    
    s|(&[^; ]*)ogon;|$1hook;|gio;    

    s|&\#x013C;|&ldbelow;|go;
    s|&\#x0146;|&ndbelow;|go;
    s|&\#x0157;|&rdbelow;|go;
    s|&\#x015F;|&sdbelow;|go;
    s|&\#x0163;|&tdbelow;|go;
    s|&\#x0137;|&kdbelow;|go;

    
    s|&\#x00C6;|&AElig;|go;
    s|&\#x00C1;|&Aacute;|go;
    s|&\#x00C5;|&Aang;|go;
    s|&\#x0102;|&Abreve;|go;
    s|&\#x00C2;|&Acirc;|go;
    s|&\#x00C0;|&Agrave;|go;
    s|&\#x0102;|&Ahacek;|go;
    s|&\#x0100;|&Amac;|go;
    s|&\#x0100;|&Amacr?;|go;
    s|&\#x0104;|&Aogon;|go;
    s|&\#x00C5;|&Aring;|go;
    s|&\#x00C3;|&Atilde;|go;
    s|&\#x00C4;|&Auml;|go;
    s|&\#x0106;|&Cacute;|go;
    s|&\#x010C;|&Cbreve;|go;
    s|&\#x010C;|&Ccaron;|go;
    s|&\#x00C7;|&Ccedil;|go;
    s|&\#x0108;|&Ccirc;|go;
    s|&\#x010A;|&Cdot;|go;
    s|&\#x010C;|&Chacek;|go;
    s|&\#x010E;|&Dbreve;|go;
    s|&\#x010E;|&Dcaron;|go;
    s|&\#x0394;|&Delta;|go;
    s|&\#x00B7;|&Dot;|go;
    s|&\#x0110;|&Dstrok;|go;
    s|&\#x014A;|&ENG;|go;
    s|&\#x00D0;|&ETH;|go;
    s|&\#x00C9;|&Eacute;|go;
    s|&\#x011A;|&Ebreve;|go;
    s|&\#x011A;|&Ecaron;|go;
    s|&\#x00CA;|&Ecirc;|go;
    s|&\#x0116;|&Edot;|go;
    s|&\#x00C8;|&Egrave;|go;
    s|&\#x0112;|&Emac;|go;
    s|&\#x0112;|&Emacr?;|go;
    s|&\#x0118;|&Eogon;|go;
    s|&\#x00CB;|&Euml;|go;
    s|&\#x0393;|&Gamma;|go;
    s|&\#x011E;|&Gbreve;|go;
    s|&\#x0122;|&Gcedil;|go;
    s|&\#x011C;|&Gcirc;|go;
    s|&\#x0120;|&Gdot;|go;
    s|&\#x0124;|&Hcirc;|go;
    s|&\#x0126;|&Hstrok;|go;
    s|&\#x0132;|&IJlig;|go;
    s|&\#x00CD;|&Iacute;|go;
    s|&\#x00CE;|&Icirc;|go;
    s|&\#x0130;|&Idot;|go;
    s|&\#x00CC;|&Igrave;|go;
    s|&\#x012A;|&Imacr?;|go;
    s|&\#x012E;|&Iogon;|go;
    s|&\#x0128;|&Itilde;|go;
    s|&\#x00CF;|&Iuml;|go;
    s|&\#x0134;|&Jcirc;|go;
    s|&\#x0136;|&Kcedil;|go;
    s|&\#x0139;|&Lacute;|go;
    s|&\#x039B;|&Lambda;|go;
    s|&\#x013D;|&Lbreve;|go;
    s|&\#x013D;|&Lcaron;|go;
    s|&\#x013B;|&Lcedil;|go;
    s|&\#x0141;|&Lcross;|go;
    s|&\#x013F;|&Llmiddot;|go;
    s|&\#x013F;|&Lmidot;|go;
    s|&\#x0141;|&Lstrok;|go;
    s|&ndash;|&NDASH;|go;
    s|&\#x0143;|&Nacute;|go;
    s|&\#x0147;|&Nbreve;|go;
    s|&\#x0147;|&Ncaron;|go;
    s|&\#x0145;|&Ncedil;|go;
    s|&\#x00D1;|&Ntilde;|go;
    s|&\#x0152;|&OElig;|go;
    s|&\#x00D3;|&Oacute;|go;
    s|&\#x00D4;|&Ocirc;|go;
    s|&\#x0150;|&Odblac;|go;
    s|&\#x00D2;|&Ograve;|go;
    s|&\#x014C;|&Omacr?;|go;
    s|&\#x03A9;|&Omega;|go;
    s|&\#x00D8;|&Oslash;|go;
    s|&\#x00D5;|&Otilde;|go;
    s|&\#x00D6;|&Ouml;|go;
    s|&\#x03A6;|&Phi;|go;
    s|&\#x03A0;|&Pi;|go;
    s|&\#x03A8;|&Psi;|go;
    s|&\#x0154;|&Racute;|go;
    s|&\#x0158;|&Rbreve;|go;
    s|&\#x0158;|&Rcaron;|go;
    s|&\#x0156;|&Rcedil;|go;
    s|&\#x015A;|&Sacute;|go;
    s|&\#x0160;|&Sbreve;|go;
    s|&\#x0160;|&Scaron;|go;
    s|&\#x015E;|&Scedil;|go;
    s|&\#x015C;|&Scirc;|go;
    s|&\#x03A3;|&Sigma;|go;
    s|&\#x00DE;|&THORN;|go;
    s|&\#x0164;|&Tbreve;|go;
    s|&\#x0164;|&Tcaron;|go;
    s|&\#x0162;|&Tcedil;|go;
    s|&\#x0398;|&Theta;|go;
    s|&\#x0166;|&Tstrok;|go;
    s|&\#x00DA;|&Uacute;|go;
    s|&\#x016C;|&Ubreve;|go;
    s|&\#x00DB;|&Ucirc;|go;
    s|&\#x0170;|&Udblac;|go;
    s|&\#x00D9;|&Ugrave;|go;
    s|&\#x016A;|&Umacr?;|go;
    s|&\#x0172;|&Uogon;|go;
    s|&\#x03D2;|&Upsi;|go;
    s|&\#x016E;|&Uring;|go;
    s|&\#x0168;|&Utilde;|go;
    s|&\#x00DC;|&Uuml;|go;
    s|&\#x0174;|&Wcirc;|go;
    s|&\#x039E;|&Xi;|go;
    s|&\#x00DD;|&Yacute;|go;
    s|&\#x0176;|&Ycirc;|go;
    s|&\#x0178;|&Yuml;|go;
    s|&\#x0179;|&Zacute;|go;
    s|&\#x017D;|&Zbreve;|go;
    s|&\#x017D;|&Zcaron;|go;
    s|&\#x017B;|&Zdot;|go;
    s|&\#x00E1;|&aacute;|go;
    s|&\#x00E5;|&aang;|go;
    s|&\#x0105;|&abcedil;|go;
    s|&\#x0103;|&acaron;|go;
    s|&\#x00E2;|&acirc;|go;
    s|&\#x01FD;|&aeacute;|go;
    s|&\#x00E6;|&aelig;|go;
    s|&\#x01E3;|&aemac;|go;
    s|&\#x00E0;|&agrave;|go;
    s|&\#x0103;|&ahacek;|go;
    s|&\#x03B1;|&alpha;|go;
    s|&\#x0101;|&amacr?;|go;
    s|&\#x0026;|&amp;|go;
    s|&\#x0105;|&aogon;|go;
    s|&apos;|&ap;|go;
    s|&\#x0027;|&apos;|go;
    s|&\#x00E5;|&aring;|go;
    s|&\#x002A;|&ast;|go;
    s|&\#x00E3;|&atilde;|go;
    s|&\#x00E4;|&auml;|go;
    s|&\#x1D122;|&bclef;|go;
    s|&\#x03B2;|&beta;|go;
    s|&\#x00A6;|&brvbar;|go;
    s|&\#x005C;|&bsol;|go;
    s|&\#x0107;|&cacute;|go;
    s|&\#x010D;|&cbreve;|go;
    s|&\#x010D;|&ccaron;|go;
    s|&\#x00E7;|&ccedil;|go;
    s|&\#x0109;|&ccirc;|go;
    s|&\#x010B;|&cdot;|go;
    s|&\#x00B8;|&cedil;|go;
    s|&\#x00A2;|&cent;|go;
    s|&\#x010D;|&chacek;|go;
    s|&\#x03C7;|&chi;|go;
    s|&\#x005E;|&circ;|go;
    s|&\#x003A;|&colon;|go;
    s|&\#x002C;|&comma;|go;
    s|&\#x0040;|&commat;|go;
    s|&\#x010F;|&dbreve;|go;
    s|&\#x010F;|&dcaron;|go;
    s|&\#x00F7;|&divide;|go;
    s|&\#x0131;|&dlessi;|go;
    s|&\#x0024;|&dollar;|go;
    s|&\#x0111;|&dstrok;|go;
    s|&\#x00E9;|&eacute;|go;
    s|&\#x0119;|&ebcedil;|go;
    s|&\#x011B;|&ebreve;|go;
    s|&\#x011B;|&ecaron;|go;
    s|&\#x00EA;|&ecirc;|go;
    s|&\#x0117;|&edot;|go;
    s|&\#x00E8;|&egrave;|go;
    s|&\#x0113;|&emacr?;|go;
    s|&\#x014B;|&eng;|go;
    s|&\#x0119;|&eogon;|go;
    s|&\#x03F5;|&epsi;|go;
    s|&\#x003D;|&equals;|go;
    s|&\#x03B7;|&eta;|go;
    s|&\#x00F0;|&eth;|go;
    s|&\#x00EB;|&euml;|go;
    s|&\#x0021;|&excl;|go;
    s|1/1000|&f1d1000;|go;
    s|1/100|&f1d100;|go;
    s|1/10|&f1d10;|go;
    s|1/15|&f1d15;|go;
    s|1/16|&f1d16;|go;
    s|&\#xFB03;|&ffilig;|go;
    s|&\#xFB00;|&fflig;|go;
    s|&\#xFB04;|&ffllig;|go;
    s|&\#xFB01;|&filig;|go;
    s|&\#xFB02;|&fllig;|go;
    s|1/7|&frac17;|go;
    s|1/9|&frac19;|go;
    s|7/6|&frac76;|go;
    s|&\#x01F5;|&gacute;|go;
    s|&\#x03B3;|&gamma;|go;
    s|&\#x011F;|&gcaron;|go;
    s|&\#x011D;|&gcirc;|go;
    s|&\#x0121;|&gdot;|go;
#    s|,|&gdp;|go;              SIH 28Jun12
    s|&\#x0060;|&grave;|go;
#    s|/|&grslash;|go;          SIH 28Jun12
    s|&\#x003E;|&gt;|go;
    s|&\#x00BD;|&half;|go;
    s|&frac12;|&half;|go;
    s|&\#x0125;|&hcirc;|go;
    s|&\#x0127;|&hstrok;|go;
    s|&\#x00ED;|&iacute;|go;
    s|&\#x012D;|&icaron;|go;
    s|&\#x00EE;|&icirc;|go;
    s|&\#x00A1;|&iexcl;|go;
    s|&\#x00EC;|&igrave;|go;
    s|&\#x0133;|&ijlig;|go;
    s|&\#x012B;|&imacr?;|go;
    s|&\#x0131;|&inodot;|go;
    s|&\#x012F;|&iogon;|go;
    s|&\#x03B9;|&iota;|go;
    s|&\#x00BF;|&iquest;|go;
    s|&\#x0129;|&itilde;|go;
    s|&\#x00EF;|&iuml;|go;
    s|&\#x0135;|&jcirc;|go;
    s|&\#x03BA;|&kappa;|go;
    s|&\#x0137;|&kcedil;|go;
    s|&star;|&key;|go;
#    s| |&key_space;|go;        SIH 28Jun12
    s|&\#x0138;|&kgreen;|go;
    s|&\#x013A;|&lacute;|go;
    s|&\#x03BB;|&lambda;|go;
    s|&\#x00AB;|&laquo;|go;
    s|&\#x013E;|&lbreve;|go;
    s|&\#x013E;|&lcaron;|go;
    s|&\#x013C;|&lcedil;|go;
    s|&\#x0142;|&lcross;|go;
    s|&\#x007B;|&lcub;|go;
    s|&#x005F;|&line;|go;
    s|&\#x0140;|&lmidot;|go;
    s|&\#x005F;|&lowbar;|go;
    s|&\#x0028;|&lpar;|go;
    s|&\#x005B;|&lsqb;|go;
    s|&\#x0142;|&lstrok;|go;
    s|&\#x003C;|&lt;|go;
    s|&\#x00AF;|&macr?;|go;
    s|&\#x00B5;|&micro;|go;
    s|&\#x00B7;|&middot;|go;
    s|&\#x1D15E;|&minim;|go;
    s|&\#x0144;|&nacute;|go;
    s|&\#x0149;|&napos;|go;
#    s|-|&nbhyph;|go;           SIH 28Jun12
#    s|-|&nbhyphen;|go;         SIH 28Jun12
    s|&\#x0148;|&nbreve;|go;
    s|&\#x00A0;|&nbsp;|go;
    s|&thinsp;|&nbthinsp;|go;
    s|&\#x0148;|&ncaron;|go;
    s|&\#x0146;|&ncedil;|go;
    s|&\#x00F1;|&ntilde;|go;
    s|&\#x03BD;|&nu;|go;
    s|&\#x00F3;|&oacute;|go;
#    s|/|&ob;|goi;              SIH 28Jun12
    s|&\#x00F4;|&ocirc;|go;
    s|&\#x0153;|&oe;|go;
    s|&\#x0153;|&oelig;|go;
    s|&\#x00F2;|&ograve;|go;
    s|&\#x014D;|&omacr?;|go;
    s|&\#x01EB;|&oogon;|go; # close but ...
    s|&\#x00F8;|&oslash;|go;
    s|&\#x00F5;|&otilde;|go;
    s|&\#x00F6;|&ouml;|go;
    s|&\#x02C8;|&p;|go; 
    s|&\#x0025;|&percnt;|go;
    s|&\#x002E;|&period;|go;
    s|&phi;|&phis;|go;
    s|&#x007C;|&pipe;|go;
    s|&\#x00A3;|&pound;|go;
    s|&\#x00A3;|&pound_currency;|go;
    s|&\#x00A3;|&poundce;|go;
    s|&\#x02C8;|&pstress;|go; 
    s|&\#x003F;|&quest;|go;
    s|&\#x0022;|&quot;|go;
    s|&\#x0155;|&racute;|go;
    s|&\#x00BB;|&raquo;|go;
    s|&\#x0159;|&rbreve;|go;
    s|&\#x0159;|&rcaron;|go;
    s|&\#x0157;|&rcedil;|go;
    s|&\#x007D;|&rcub;|go;
    s|&\#x0029;|&rpar;|go;
    s|&\#x005D;|&rsqb;|go;
    s|&#x02CC;|&s;|go;
    s|&\#x015B;|&sacute;|go;
    s|&\#x0161;|&sbreve;|go;
    s|&\#x0161;|&scaron;|go;
    s|&\#x015F;|&sced;|go;
    s|&\#x015F;|&scedil;|go;
    s|&\#x015D;|&scirc;|go;
    s|&\#x00A7;|&sect;|go;
    s|&\#x003B;|&semi;|go;
    s|&\#x00AD;|&shy;|go;
#    s|/|&sol;|go;             SIH 28Jun12
#    s|/|&sol;|goi;            SIH 28Jun12
    s|&#x02CC;|&sstress;|go;
    s|<z_sub>([0-9]+)</z_sub>|&sub\1;|go;
    s|<z_sup>([0-9]+)</z_sup>|&sup\1;|go;
    s|&\#x00B9;|&sup1;|go;
    s|&\#x00B2;|&sup2;|go;
    s|&\#x00B3;|&sup3;|go;
    s|<z_sup>-([0-9]+)</z_sup>|&supminus\1;|go;
    s|&\#x00DF;|&szlig;|go;
    s|&\#x0165;|&tbreve;|go;
    s|&\#x0165;|&tcaron;|go;
    s|&\#x0163;|&tcedil;|go;
    s|&\#x03B8;|&theta;|go; # BC 15Sep04
    s|&theta;|&thetas;|go;
    s|&\#x00FE;|&thorn;|go;
    s|&\#x02DC;|&tilde;|go;
#    s|~|&tilde;|go;           SIH 28Jun12
    s|&\#x00D7;|&times;|go;
    s|&\#x0167;|&tstrok;|go;
    s|&\#x00FA;|&uacute;|go;
    s|&\#x016F;|&uang;|go;
    s|&\#x016D;|&ubreve;|go;
    s|&\#x016D;|&ucaron;|go;
    s|&\#x00FB;|&ucirc;|go;
    s|&\#x0171;|&udblac;|go;
    s|&\#x00F9;|&ugrave;|go;
    s|&\#x016B;|&umacr?;|go;
    s|&\#x0173;|&uogon;|go;
    s|&\#x03C5;|&upsi;|go;
    s|&\#x016F;|&uring;|go;
    s|&\#x0169;|&utilde;|go;
    s|&\#x00FC;|&uuml;|go;
    s|&\#x00FC;|&uumlaut;|go;
    s|&\#x007C;|&verbar;|go;
    s|&thinsp;|&vthinsp;|go;
    s|&\#x0175;|&wcirc;|go;
    s|&\#x00FD;|&yacute;|go;
    s|&\#x0177;|&ycirc;|go;
    s|&\#x00A5;|&yen;|go;
    s|&\#x04EF;|&ymacr?;|go;
    s|&\#x00FF;|&yuml;|go;
    s|&\#x017A;|&zacute;|go;
    s|&\#x017E;|&zbreve;|go;
    s|&\#x017E;|&zcaron;|go;
    s|&\#x017C;|&zdot;|go;
    s|&\#x03B6;|&zeta;|go;
    s|&\#x0140;|l&llmiddot;|go;


    s|([a-z])&\#x0331;|&$1bbelow;|gio;    
    s|([a-z])&\#x0345;|&$1dbelow;|gio;    
    s|([a-z])&\#x0342;|&$1tilde;|gio; 
    s|([a-z])&\#x0304;|&$1macr?;|gio;       
    s|([a-z])&\#x0307;|&$1dot;|gio;    

#   Greek characters ...

    s|&\#x0391;|&Agr;|go;	# Alpha
    s|&\#x0392;|&Bgr;|go;	# Beta
    s|&\#x0394;|&Dgr;|go;	# Delta
    s|&\#x0397;|&EEgr;|go;	# Eta
    s|&\#x0395;|&Egr;|go;	# Epsilon
    s|&\#x0393;|&Ggr;|go;	# Gamma
    s|&\#x0399;|&Igr;|go;	# Iota
    s|&\#x03A7;|&KHgr;|go;	# Chi
    s|&\#x039A;|&Kgr;|go;	# Kappa
    s|&\#x039B;|&Lgr;|go;	# Lambda
    s|&\#x039C;|&Mgr;|go;	# Mu
    s|&\#x039D;|&Ngr;|go;	# Nu
    s|&\#x03A9;|&OHgr;|go;	# Omega
    s|&\#x039F;|&Ogr;|go;	# Omicron
    s|&\#x03A6;|&PHgr;|go;	# Phi
    s|&\#x0308;|&PSgr;|go;	# Psi
    s|&\#x03A0;|&Pgr;|go;	# Pi
    s|&\#x03A1;|&Rgr;|go;	# Rho
    s|&\#x03A3;|&Sgr;|go;	# Sigma
    s|&\#x0398;|&THgr;|go;	# Theta
    s|&\#x03A4;|&Tgr;|go;	# Tau
    s|&\#x03A5;|&Ugr;|go;	# Upsilon
    s|&\#x039E;|&Xgr;|go;	# Xi
    s|&\#x0396;|&Zgr;|go;	# Zeta

    s|&\#x03B1;|&agr;|go;	# alpha
    s|&\#x03B2;|&bgr;|go;	# beta
    s|&\#x03B4;|&dgr;|go;	# delta
    s|&\#x03B7;|&eegr;|go;	# eta
    s|&\#x03B5;|&egr;|go;	# epsilon
    s|&\#x03B3;|&ggr;|go;	# gamma
    s|&\#x03B9;|&igr;|go;	# iota
    s|&\#x03BA;|&kgr;|go;	# kappa
    s|&\#x03C7;|&khgr;|go;	# chi
    s|&\#x03BB;|&lgr;|go;	# lambda
    s|&\#x03BC;|&mgr;|go;	# mu
    s|&\#x03BD;|&ngr;|go;	# nu
    s|&\#x03BF;|&ogr;|go;	# omicron
    s|&\#x03C9;|&ohgr;|go;	# omega
    s|&\#x03C0;|&pgr;|go;	# pi
    s|&\#x03C6;|&phgr;|go;	# phi
    s|&\#x03C8;|&psgr;|go;	# psi
    s|&\#x03C1;|&rgr;|go;	# rho
    s|&\#x03C3;|&sgr;|go;	# sigma
    s|&\#x03C4;|&tgr;|go;	# tau
    s|&\#x03B8;|&thgr;|go;	# theta
    s|&\#x03C5;|&ugr;|go;	# upsilon
    s|&\#x03BE;|&xgr;|go;	# xi
    s|&\#x03B6;|&zgr;|go;	# zeta
    
    
}

1;
