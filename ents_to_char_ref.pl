#!/usr/local/bin/perl

sub ents_to_unicode
{
    # These were after the unless ... block - God knows why!  SIH 27.6.14
    s|&shy;||go;
    s|&en;|&ensp;|go;
    s|&cq;|&rsquo;|go;
    s|&oq;|&lsquo;|go;
    s|&asp;|&lsquo;|gio;
    s|&ddd;|&hellip;|gio;
    s|&th;|&thorn;|gio;

    s|(&[^; ]*)hacek;|$1caron;|gio;
    s|(&[^; ]*)breve;|$1caron;|gio;
    s|(&[^; ]*)bar;|$1macr;|gio;
    s|(&[a-z]*)ced;|$1cedil;|gio;
    s|(&[^; ]*)dabove;|$1dot;|gio;    
    s|(&[^; ]*)hook;|$1ogon;|gio;    

    unless ($NO_SYM_CHANGE)
    {
	s|&Dagger;|&\#x2021;|go;
	s|&Prime;|&\#x2033;|go;
	s|&arrow;|&\#x279E;|go;
	s|&blank;|&\#x2423;|go;
	s|&blarrow;|&\#x279E;|go;
	s|&blk12;|&\#x2592;|go;
	s|&blk14;|&\#x2591;|go;
	s|&blk34;|&\#x2593;|go;
	s|&block;|&\#x2588;|go;
	s|&bull;|&\#x2022;|go;
	s|&careof;|&\#x2105;|go;
	s|&caret;|&\#x2038;|go;
	s|&check;|&\#x2713;|go;
	s|&cir;|&\#x25CB;|go;
	s|&clubs;|&\#x2663;|go;
	s|&co2;|CO<z_sub>2</z_sub>|gio;
	s|&copy;|&\#x00A9;|go;
	s|&copysr;|&\#x2117;|go;
#	s|&coresym;|&\#x2605;|gio;
	s|&cross;|&\#x2717;|go;
	s|&crossl;|&\#x271D;|go;
	s|&crotchet;|&\#x1D15F;|go;
	s|&cuberoot;|&\#x221B;|go;
	s|&curren;|&\#x00A4;|go;
	s|&dagger;|&\#x2020;|go;
	s|&darr;|&\#x2193;|go;
	s|&dash;|&\#x2010;|go;
	s|&deg;|&\#x00B0;|go;
	s|&delta;|&\#x03B4;|go;
	s|&diams;|&\#x2666;|go;
	s|&ditto;|&\#x3003;|go;
	s|&dlcrop;|&\#x230D;|go;
	s|&dp;|.|go;
	s|&drcrop;|&\#x230C;|go;
	s|&dtri;|&\#x25BF;|go;
	s|&dtrif;|&\#x25BE;|go;
	s|&emsp13;|&\#x2004;|go;
	s|&emsp14;|&\#x2005;|go;
	s|&emsp;|&\#x2003;|go;
	s|&ensp;|&\#x2002;|go;
	s|&euro;|&\#x20AC;|go;
	s|&female;|&\#x2640;|go;
	s|&flat;|&\#x266D;|go;
	s|&frac12;|&\#x00BD;|go;
	s|&frac13;|&\#x2153;|go;
	s|&frac14;|&\#x00BC;|go;
	s|&frac15;|&\#x2155;|go;
	s|&frac16;|&\#x2159;|go;
	s|&frac18;|&\#x215B;|go;
	s|&frac23;|&\#x2154;|go;
	s|&frac25;|&\#x2156;|go;
	s|&frac34;|&\#x00BE;|go;
	s|&frac35;|&\#x2157;|go;
	s|&frac38;|&\#x215C;|go;
	s|&frac45;|&\#x2158;|go;
	s|&frac56;|&\#x215A;|go;
	s|&frac58;|&\#x215D;|go;
	s|&frac78;|&\#x215E;|go;
	s|&frown;|&\#x2322;|go;
	s|&gql;|&\#x201E;|go;
	s|&gqr;|&\#x201C;|go;
	s|&h2o;|H<z_sub>2</z_sub>O|gio;
	s|&hairsp;|&\#x200A;|go;
	s|&hearts;|&\#x2665;|go;
	s|&hellip;|&\#x2026;|go;
	s|&horbar;|&\#x2015;|go;
	s|&hybull;|&\#x2043;|go;
	s|&hyphen;|&\#x2010;|go;
	s|&incare;|&\#x2105;|go;
	s|&infin;|&\#x221E;|go;
	s|&larr;|&\#x2190;|go;
	s|&ldquo;|&\#x201C;|go;
	s|&ldquor;|&\#x201E;|go;
	s|&lhblk;|&\#x2584;|go;
	s|&loz;|&\#x25CA;|go;
	s|&lozf;|&\#x2726;|go;
	s|&lsquo;|&\#x2018;|go;
	s|&lsquor;|&\#x201A;|go;
	s|&ltri;|&\#x25C3;|go;
	s|&ltrif;|&\#x25C2;|go;
	s|&male;|&\#x2642;|go;
	s|&malt;|&\#x2720;|go;
	s|&marker;|&\#x25AE;|go;
	s|&mdash;|&\#x2014;|go;
	s|&minus;|&\#x2212;|go;
	s|&mldr;|&\#x2026;|go;
	s|&mu;|&\#x03BC;|go;
	s|&natur;|&\#x266E;|go;
	s|&nbthinsp.*?;|&\#x2009;|go;
	s|&ndash;|&\#x2013;|go;
	s|&ne;|&\#x2260;|go; 
	s|&nldr;|&\#x2025;|go;
	s|&not;|&\#x00AC;|go;
	s|&num;|&\#x0023;|go;
	s|&numsp;|&\#x2007;|go;
	s|&odblac;|&\#x0151;|go;
	s|&ohm;|&\#x2126;|go;
	s|&omega;|&\#x03C9;|go;
	s|&omicron;|o|go;
	s|&ordf;|&\#x00AA;|go;
	s|&ordm;|&\#x00BA;|go;
	s|&para;|&\#x00B6;|go;
	s|&pause;||go;
    s|&phis;|&phi;|go;
	s|&phi;|&\#x0278;|go;
	s|&phone;|&\#x260E;|go;
	s|&pi;|&\#x03C0;|go;
	s|&pir2;|&\#x03C0;r&\#x00B2;|go; 
	s|&plus;|&\#x002B;|go;
	s|&plusmn;|&\#x00B1;|go;
	s|&prime;|&\#x2032;|go;
	s|&psi;|&\#x03C8;|go;
	s|&puncsp;|&\#x2008;|go;
	s|&pvarr;|&\#x2194;|go;
	s|&quaver;|&\#x266A;|go;
	s|&radic;|&\#x221A;|go;
	s|&rarr;|&\#x2192;|go;
	s|&rdquo;|&\#x201D;|go;
	s|&rdquor;|&\#x201C;|go;
	s|&rect;|&\#x25AD;|go;
	s|&reg;|&\#x00AE;|go;
	s|&rho;|&\#x03C1;|go;
	s|&rsquo;|&\#x2019;|go;
	s|&rsquor;|&\#x2018;|go;
	s|&rtri;|&\#x25B9;|go;
	s|&rtrif;|&\#x25B8;|go;
	s|&rx;|&\#x211E;|go;
	s|&semibrev;|&\#x1D15D;|go;
	s|&semiquav;|&\#x1D161;|go;
	s|&sext;|&\#x2736;|go;
	s|&sharp;|&\#x266F;|go;
	s|&sigma;|&\#x03C3;|go;
	s|&smile;|&\#x2323;|go;
	s|&spades;|&\#x2660;|go;
	s|&spc_sl2;| |go;
	s|&spc_ssym;| |go;
	s|&spc_xhm;| |go;
	s|&squ;|&\#x25A1;|go;
	s|&squf;|&\#x25AA;|go;
	s|&star;|&\#x22C6;|go;
	s|&starf;|&\#x2605;|go;
	s|&sung;|&\#x2669;|go;
	s|&synsep;|&#x2027;|go;
	s|&target;|&\#x2316;|go;
	s|&tau;|&\#x03C4;|go;
	s|&tclef;|&\#x1D120;|go;
	s|&telrec;|&\#x2315;|go;
	s|&thinsp;|&\#x2009;|go;
	s|&thinsp[^;]*;|&\#x2009;|go;
	s|&tick;|&\#x2713;|go;
	s|&trade;|&\#x2122;|go;
	s|&uarr;|&\#x2191;|go;
	s|&uhblk;|&\#x2580;|go;
	s|&ulcrop;|&\#x230F;|go;
	s|&urcrop;|&\#x230E;|go;
	s|&utri;|&\#x25B5;|go;
	s|&utrif;|&\#x25B4;|go;
	s|&vellip;|&\#x22EE;|go;
#	s|&w;|&#x2022;|go;
	s|&w;|&#x00B7;|go;
	s|&xi;|&\#x03BE;|go;
	s|&xrefarrow;|&#x27B1;|go;
	s|&xrsym;|&#x27B1;|gio;

    }

    s|&ldbelow;|&\#x013C;|go;
    s|&ndbelow;|&\#x0146;|go;
    s|&rdbelow;|&\#x0157;|go;
    s|&sdbelow;|&\#x015F;|go;
    s|&tdbelow;|&\#x0163;|go;
    s|&kdbelow;|&\#x0137;|go;

    
    s|&AElig;|&\#x00C6;|go;
    s|&Aacute;|&\#x00C1;|go;
    s|&Aang;|&\#x00C5;|go;
    s|&Abreve;|&\#x0102;|go;
    s|&Acirc;|&\#x00C2;|go;
    s|&Agrave;|&\#x00C0;|go;
    s|&Ahacek;|&\#x0102;|go;
    s|&Amac;|&\#x0100;|go;
    s|&Amacr?;|&\#x0100;|go;
    s|&Aogon;|&\#x0104;|go;
    s|&Aring;|&\#x00C5;|go;
    s|&Atilde;|&\#x00C3;|go;
    s|&Auml;|&\#x00C4;|go;
    s|&Cacute;|&\#x0106;|go;
    s|&Cbreve;|&\#x010C;|go;
    s|&Ccaron;|&\#x010C;|go;
    s|&Ccedil;|&\#x00C7;|go;
    s|&Ccirc;|&\#x0108;|go;
    s|&Cdot;|&\#x010A;|go;
    s|&Chacek;|&\#x010C;|go;
    s|&Dbreve;|&\#x010E;|go;
    s|&Dcaron;|&\#x010E;|go;
    s|&Delta;|&\#x0394;|go;
    s|&Dot;|&\#x00B7;|go;
    s|&Dstrok;|&\#x0110;|go;
    s|&ENG;|&\#x014A;|go;
    s|&ETH;|&\#x00D0;|go;
    s|&Eacute;|&\#x00C9;|go;
    s|&Ebreve;|&\#x011A;|go;
    s|&Ecaron;|&\#x011A;|go;
    s|&Ecirc;|&\#x00CA;|go;
    s|&Edot;|&\#x0116;|go;
    s|&Egrave;|&\#x00C8;|go;
    s|&Emac;|&\#x0112;|go;
    s|&Emacr?;|&\#x0112;|go;
    s|&Eogon;|&\#x0118;|go;
    s|&Euml;|&\#x00CB;|go;
    s|&Gamma;|&\#x0393;|go;
    s|&Gbreve;|&\#x011E;|go;
    s|&Gcedil;|&\#x0122;|go;
    s|&Gcirc;|&\#x011C;|go;
    s|&Gdot;|&\#x0120;|go;
    s|&Hcirc;|&\#x0124;|go;
    s|&Hstrok;|&\#x0126;|go;
    s|&IJlig;|&\#x0132;|go;
    s|&Iacute;|&\#x00CD;|go;
    s|&Icirc;|&\#x00CE;|go;
    s|&Idot;|&\#x0130;|go;
    s|&Igrave;|&\#x00CC;|go;
    s|&Imacr?;|&\#x012A;|go;
    s|&Iogon;|&\#x012E;|go;
    s|&Itilde;|&\#x0128;|go;
    s|&Iuml;|&\#x00CF;|go;
    s|&Jcirc;|&\#x0134;|go;
    s|&Kcedil;|&\#x0136;|go;
    s|&Lacute;|&\#x0139;|go;
    s|&Lambda;|&\#x039B;|go;
    s|&Lbreve;|&\#x013D;|go;
    s|&Lcaron;|&\#x013D;|go;
    s|&Lcedil;|&\#x013B;|go;
    s|&Lcross;|&\#x0141;|go;
    s|&Llmiddot;|&\#x013F;|go;
    s|&Lmidot;|&\#x013F;|go;
    s|&Lstrok;|&\#x0141;|go;
    s|&NDASH;|&ndash;|go;
    s|&Nacute;|&\#x0143;|go;
    s|&Nbreve;|&\#x0147;|go;
    s|&Ncaron;|&\#x0147;|go;
    s|&Ncedil;|&\#x0145;|go;
    s|&Ntilde;|&\#x00D1;|go;
    s|&OElig;|&\#x0152;|go;
    s|&Oacute;|&\#x00D3;|go;
    s|&Ocirc;|&\#x00D4;|go;
    s|&Odblac;|&\#x0150;|go;
    s|&Ograve;|&\#x00D2;|go;
    s|&Omacr?;|&\#x014C;|go;
    s|&Omega;|&\#x03A9;|go;
    s|&Oslash;|&\#x00D8;|go;
    s|&Otilde;|&\#x00D5;|go;
    s|&Ouml;|&\#x00D6;|go;
    s|&Phi;|&\#x03A6;|go;
    s|&Pi;|&\#x03A0;|go;
    s|&Psi;|&\#x03A8;|go;
    s|&Racute;|&\#x0154;|go;
    s|&Rbreve;|&\#x0158;|go;
    s|&Rcaron;|&\#x0158;|go;
    s|&Rcedil;|&\#x0156;|go;
    s|&Sacute;|&\#x015A;|go;
    s|&Sbreve;|&\#x0160;|go;
    s|&Scaron;|&\#x0160;|go;
    s|&Scedil;|&\#x015E;|go;
    s|&Scirc;|&\#x015C;|go;
    s|&Sigma;|&\#x03A3;|go;
    s|&THORN;|&\#x00DE;|go;
    s|&Tbreve;|&\#x0164;|go;
    s|&Tcaron;|&\#x0164;|go;
    s|&Tcedil;|&\#x0162;|go;
    s|&Theta;|&\#x0398;|go;
    s|&Tstrok;|&\#x0166;|go;
    s|&Uacute;|&\#x00DA;|go;
    s|&Ubreve;|&\#x016C;|go;
    s|&Ucirc;|&\#x00DB;|go;
    s|&Udblac;|&\#x0170;|go;
    s|&Ugrave;|&\#x00D9;|go;
    s|&Umacr?;|&\#x016A;|go;
    s|&Uogon;|&\#x0172;|go;
    s|&Upsi;|&\#x03D2;|go;
    s|&Uring;|&\#x016E;|go;
    s|&Utilde;|&\#x0168;|go;
    s|&Uuml;|&\#x00DC;|go;
    s|&Wcirc;|&\#x0174;|go;
    s|&Xi;|&\#x039E;|go;
    s|&Yacute;|&\#x00DD;|go;
    s|&Ycirc;|&\#x0176;|go;
    s|&Yuml;|&\#x0178;|go;
    s|&Zacute;|&\#x0179;|go;
    s|&Zbreve;|&\#x017D;|go;
    s|&Zcaron;|&\#x017D;|go;
    s|&Zdot;|&\#x017B;|go;
    s|&aacute;|&\#x00E1;|go;
    s|&aang;|&\#x00E5;|go;
    s|&abcedil;|&\#x0105;|go;
    s|&acaron;|&\#x0103;|go;
    s|&acirc;|&\#x00E2;|go;
    s|&aeacute;|&\#x01FD;|go;
    s|&aelig;|&\#x00E6;|go;
    s|&aemac;|&\#x01E3;|go;
    s|&agrave;|&\#x00E0;|go;
    s|&ahacek;|&\#x0103;|go;
    s|&alpha;|&\#x03B1;|go;
    s|&amacr?;|&\#x0101;|go;
    s|&amp;|&\#x0026;|go;
    s|&aogon;|&\#x0105;|go;
    s|&ap;|&apos;|go;
    s|&apos;|&\#x0027;|go;
    s|&aring;|&\#x00E5;|go;
    s|&ast;|&\#x002A;|go;
    s|&atilde;|&\#x00E3;|go;
    s|&auml;|&\#x00E4;|go;
    s|&bclef;|&\#x1D122;|go;
    s|&beta;|&\#x03B2;|go;
    s|&brvbar;|&\#x00A6;|go;
    s|&bsol;|&\#x005C;|go;
    s|&cacute;|&\#x0107;|go;
    s|&cbreve;|&\#x010D;|go;
    s|&ccaron;|&\#x010D;|go;
    s|&ccedil;|&\#x00E7;|go;
    s|&ccirc;|&\#x0109;|go;
    s|&cdot;|&\#x010B;|go;
    s|&cedil;|&\#x00B8;|go;
    s|&cent;|&\#x00A2;|go;
    s|&chacek;|&\#x010D;|go;
    s|&chi;|&\#x03C7;|go;
    s|&circ;|&\#x005E;|go;
    s|&colon;|&\#x003A;|go;
    s|&comma;|&\#x002C;|go;
    s|&commat;|&\#x0040;|go;
    s|&dbreve;|&\#x010F;|go;
    s|&dcaron;|&\#x010F;|go;
    s|&divide;|&\#x00F7;|go;
    s|&dlessi;|&\#x0131;|go;
    s|&dollar;|&\#x0024;|go;
    s|&dstrok;|&\#x0111;|go;
    s|&eacute;|&\#x00E9;|go;
    s|&ebcedil;|&\#x0119;|go;
    s|&ebreve;|&\#x011B;|go;
    s|&ecaron;|&\#x011B;|go;
    s|&ecirc;|&\#x00EA;|go;
    s|&edot;|&\#x0117;|go;
    s|&egrave;|&\#x00E8;|go;
    s|&emacr?;|&\#x0113;|go;
    s|&eng;|&\#x014B;|go;
    s|&eogon;|&\#x0119;|go;
    s|&epsi;|&\#x03F5;|go;
    s|&equals;|&\#x003D;|go;
    s|&eta;|&\#x03B7;|go;
    s|&eth;|&\#x00F0;|go;
    s|&euml;|&\#x00EB;|go;
    s|&excl;|&\#x0021;|go;
    s|&f1d1000;|1/1000|go;
    s|&f1d100;|1/100|go;
    s|&f1d10;|1/10|go;
    s|&f1d15;|1/15|go;
    s|&f1d16;|1/16|go;
    s|&ffilig;|&\#xFB03;|go;
    s|&fflig;|&\#xFB00;|go;
    s|&ffllig;|&\#xFB04;|go;
    s|&filig;|&\#xFB01;|go;
    s|&fllig;|&\#xFB02;|go;
    s|&frac17;|1/7|go;
    s|&frac19;|1/9|go;
    s|&frac76;|7/6|go;
    s|&gacute;|&\#x01F5;|go;
    s|&gamma;|&\#x03B3;|go;
    s|&gcaron;|&\#x011F;|go;
    s|&gcirc;|&\#x011D;|go;
    s|&gdot;|&\#x0121;|go;
    s|&gdp;|,|go;
    s|&grave;|&\#x0060;|go;
    s|&grslash;|/|go;
    s|&gt;|&\#x003E;|go;
    s|&half;|&\#x00BD;|go;
    s|&half;|&frac12;|go;
    s|&hcirc;|&\#x0125;|go;
    s|&hstrok;|&\#x0127;|go;
    s|&iacute;|&\#x00ED;|go;
    s|&icaron;|&\#x012D;|go;
    s|&icirc;|&\#x00EE;|go;
    s|&iexcl;|&\#x00A1;|go;
    s|&igrave;|&\#x00EC;|go;
    s|&ijlig;|&\#x0133;|go;
    s|&imacr?;|&\#x012B;|go;
    s|&inodot;|&\#x0131;|go;
    s|&iogon;|&\#x012F;|go;
    s|&iota;|&\#x03B9;|go;
    s|&iquest;|&\#x00BF;|go;
    s|&itilde;|&\#x0129;|go;
    s|&iuml;|&\#x00EF;|go;
    s|&jcirc;|&\#x0135;|go;
    s|&kappa;|&\#x03BA;|go;
    s|&kcedil;|&\#x0137;|go;
    s|&key;|&star;|go;
    s|&key_space;| |go;
    s|&kgreen;|&\#x0138;|go;
    s|&lacute;|&\#x013A;|go;
    s|&lambda;|&\#x03BB;|go;
    s|&laquo;|&\#x00AB;|go;
    s|&lbreve;|&\#x013E;|go;
    s|&lcaron;|&\#x013E;|go;
    s|&lcedil;|&\#x013C;|go;
    s|&lcross;|&\#x0142;|go;
    s|&lcub;|&\#x007B;|go;
    s|&line;|&#x005F;|go;
    s|&lmidot;|&\#x0140;|go;
    s|&lowbar;|&\#x005F;|go;
    s|&lpar;|&\#x0028;|go;
    s|&lsqb;|&\#x005B;|go;
    s|&lstrok;|&\#x0142;|go;
    s|&lt;|&\#x003C;|go;
    s|&macr?;|&\#x00AF;|go;
    s|&micro;|&\#x00B5;|go;
    s|&middot;|&\#x00B7;|go;
    s|&minim;|&\#x1D15E;|go;
    s|&nacute;|&\#x0144;|go;
    s|&napos;|&\#x0149;|go;
    s|&nbhyph;|-|go;
    s|&nbhyphen;|-|go;
    s|&nbreve;|&\#x0148;|go;
    s|&nbsp;|&\#x00A0;|go;
    s|&nbthinsp;|&thinsp;|go;
    s|&ncaron;|&\#x0148;|go;
    s|&ncedil;|&\#x0146;|go;
    s|&ntilde;|&\#x00F1;|go;
    s|&nu;|&\#x03BD;|go;
    s|&oacute;|&\#x00F3;|go;
    s|&ob;|/|goi;
    s|&ocirc;|&\#x00F4;|go;
    s|&oe;|&\#x0153;|go;
    s|&oelig;|&\#x0153;|go;
    s|&ograve;|&\#x00F2;|go;
    s|&omacr?;|&\#x014D;|go;
    s|&oogon;|&\#x01EB;|go; # close but ...
    s|&oslash;|&\#x00F8;|go;
    s|&otilde;|&\#x00F5;|go;
    s|&ouml;|&\#x00F6;|go;
    s|&p;|&\#x02C8;|go; 
    s|&percnt;|&\#x0025;|go;
    s|&period;|&\#x002E;|go;
    s|&pipe;|&#x007C;|go;
    s|&pound;|&\#x00A3;|go;
    s|&pound_currency;|&\#x00A3;|go;
    s|&poundce;|&\#x00A3;|go;
    s|&pstress;|&\#x02C8;|go; 
    s|&quest;|&\#x003F;|go;
    s|&quot;|&\#x0022;|go;
    s|&racute;|&\#x0155;|go;
    s|&raquo;|&\#x00BB;|go;
    s|&rbreve;|&\#x0159;|go;
    s|&rcaron;|&\#x0159;|go;
    s|&rcedil;|&\#x0157;|go;
    s|&rcub;|&\#x007D;|go;
    s|&rpar;|&\#x0029;|go;
    s|&rsqb;|&\#x005D;|go;
    s|&s;|&#x02CC;|go;
    s|&sacute;|&\#x015B;|go;
    s|&sbreve;|&\#x0161;|go;
    s|&scaron;|&\#x0161;|go;
    s|&sced;|&\#x015F;|go;
    s|&scedil;|&\#x015F;|go;
    s|&scirc;|&\#x015D;|go;
    s|&sect;|&\#x00A7;|go;
    s|&semi;|&\#x003B;|go;
    s|&shy;|&\#x00AD;|go;
    s|&sol;|/|go;
    s|&sol;|/|goi;
    s|&sstress;|&#x02CC;|go;
    s|&sup1;|&\#x00B9;|go;
    s|&sup2;|&\#x00B2;|go;
    s|&sup3;|&\#x00B3;|go;
    s|&sup([0-9]+);|<z_sup>\1</z_sup>|go;
    s|&sub([0-9]+);|<z_sub>\1</z_sub>|go;
    s|&supminus([0-9]+);|<z_sup>-\1</z_sup>|go;
    s|&szlig;|&\#x00DF;|go;
    s|&tbreve;|&\#x0165;|go;
    s|&tcaron;|&\#x0165;|go;
    s|&tcedil;|&\#x0163;|go;
    s|&thetas;|&theta;|go;
    s|&theta;|&\#x03B8;|go;
    s|&thorn;|&\#x00FE;|go;
    s|&tilde;|&\#x02DC;|go;
    s|&tilde;|~|go;
    s|&times;|&\#x00D7;|go;
    s|&tstrok;|&\#x0167;|go;
    s|&uacute;|&\#x00FA;|go;
    s|&uang;|&\#x016F;|go;
    s|&ubreve;|&\#x016D;|go;
    s|&ucaron;|&\#x016D;|go;
    s|&ucirc;|&\#x00FB;|go;
    s|&udblac;|&\#x0171;|go;
    s|&ugrave;|&\#x00F9;|go;
    s|&umacr?;|&\#x016B;|go;
    s|&uogon;|&\#x0173;|go;
    s|&upsi;|&\#x03C5;|go;
    s|&uring;|&\#x016F;|go;
    s|&utilde;|&\#x0169;|go;
    s|&uuml;|&\#x00FC;|go;
    s|&uumlaut;|&\#x00FC;|go;
    s|&verbar;|&\#x007C;|go;
    s|&vthinsp;|&thinsp;|go;
    s|&wcirc;|&\#x0175;|go;
    s|&yacute;|&\#x00FD;|go;
    s|&ycirc;|&\#x0177;|go;
    s|&yen;|&\#x00A5;|go;
    s|&ymacr?;|&\#x04EF;|go;
    s|&yuml;|&\#x00FF;|go;
    s|&zacute;|&\#x017A;|go;
    s|&zbreve;|&\#x017E;|go;
    s|&zcaron;|&\#x017E;|go;
    s|&zdot;|&\#x017C;|go;
    s|&zeta;|&\#x03B6;|go;
    s|l&llmiddot;|&\#x0140;|go;


    s|&([^; ]*)bbelow;|$1&\#x0331;|gio;    
    s|&([^; ]*)dbelow;|$1&\#x0345;|gio;    
    s|&([^; ]*)tilde;|$1&\#x0342;|gio; 
    s|&([^; ]*)macr?;|$1&\#x0304;|gio;       
    s|&([^; ]*)dot;|$1&\#x0307;|gio;    

#   Greek characters ...

    s|&Agr;|&\#x0391;|go;	# Alpha
    s|&Bgr;|&\#x0392;|go;	# Beta
    s|&Dgr;|&\#x0394;|go;	# Delta
    s|&EEgr;|&\#x0397;|go;	# Eta
    s|&Egr;|&\#x0395;|go;	# Epsilon
    s|&Ggr;|&\#x0393;|go;	# Gamma
    s|&Igr;|&\#x0399;|go;	# Iota
    s|&KHgr;|&\#x03A7;|go;	# Chi
    s|&Kgr;|&\#x039A;|go;	# Kappa
    s|&Lgr;|&\#x039B;|go;	# Lambda
    s|&Mgr;|&\#x039C;|go;	# Mu
    s|&Ngr;|&\#x039D;|go;	# Nu
    s|&OHgr;|&\#x03A9;|go;	# Omega
    s|&Ogr;|&\#x039F;|go;	# Omicron
    s|&PHgr;|&\#x03A6;|go;	# Phi
    s|&PSgr;|&\#x0308;|go;	# Psi
    s|&Pgr;|&\#x03A0;|go;	# Pi
    s|&Rgr;|&\#x03A1;|go;	# Rho
    s|&Sgr;|&\#x03A3;|go;	# Sigma
    s|&THgr;|&\#x0398;|go;	# Theta
    s|&Tgr;|&\#x03A4;|go;	# Tau
    s|&Ugr;|&\#x03A5;|go;	# Upsilon
    s|&Xgr;|&\#x039E;|go;	# Xi
    s|&Zgr;|&\#x0396;|go;	# Zeta

    s|&agr;|&\#x03B1;|go;	# alpha
    s|&bgr;|&\#x03B2;|go;	# beta
    s|&dgr;|&\#x03B4;|go;	# delta
    s|&eegr;|&\#x03B7;|go;	# eta
    s|&egr;|&\#x03B5;|go;	# epsilon
    s|&ggr;|&\#x03B3;|go;	# gamma
    s|&igr;|&\#x03B9;|go;	# iota
    s|&kgr;|&\#x03BA;|go;	# kappa
    s|&khgr;|&\#x03C7;|go;	# chi
    s|&lgr;|&\#x03BB;|go;	# lambda
    s|&mgr;|&\#x03BC;|go;	# mu
    s|&ngr;|&\#x03BD;|go;	# nu
    s|&ogr;|&\#x03BF;|go;	# omicron
    s|&ohgr;|&\#x03C9;|go;	# omega
    s|&pgr;|&\#x03C0;|go;	# pi
    s|&phgr;|&\#x03C6;|go;	# phi
    s|&psgr;|&\#x03C8;|go;	# psi
    s|&rgr;|&\#x03C1;|go;	# rho
    s|&sgr;|&\#x03C3;|go;	# sigma
    s|&tgr;|&\#x03C4;|go;	# tau
    s|&thgr;|&\#x03B8;|go;	# theta
    s|&ugr;|&\#x03C5;|go;	# upsilon
    s|&xgr;|&\#x03BE;|go;	# xi
    s|&zgr;|&\#x03B6;|go;	# zeta
    
    
}

1;
