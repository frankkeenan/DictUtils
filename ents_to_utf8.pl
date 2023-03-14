#!/usr/local/bin/perl

while (<>)

{   
    s|&Aacute;|Á|g;
    s|&Delta;|Δ|g;
    s|&Eacute;|É|g;
    s|&Gamma;|Γ|g;
    s|&Iacute;|Í|g;
    s|&Lambda;|Λ|g;
    s|&Omega;|Ω|g;
    s|&Phi;|Φ|g;
    s|&Pi;|Π|g;
    s|&Prime;|″|g;
    s|&Psi;|Ψ|g;
    s|&Sigma;|Σ|g;
    s|&Theta;|Θ|g;
    s|&Uacute;|Ú|g;
    s|&Upsi;|Υ|g;
    s|&Xi;|Ξ|g;
    s|&aacute;|á|g;
    s|&acirc;|â|g;
    s|&aelig;|æ|g;
    s|&agrave;|à|g;
    s|&alpha;|α|g;
    s|&amacr;|ā|g;
#    s|&amp;|&|g; # keep as entity for IDM system ...
    s|&ap;|’|g; # right single quote style apostrophe ... 
    s|&ast;|*|g;
    s|&atilde;|ã|g;
    s|&auml;|ä|g;
    s|&beta;|β|g;
    s|&blarrow;|→|g;
    s|&caret;|^|g; # superscript like circumflex ... 
    s|&ccedil;|ç|g;
    s|&check;|✓|g;
    s|&chi;|χ|g;
    s|&clubs;|♣|g;
    s|&copy;|©|g;
    s|&crossl;|✝|g;
    s|&cuberoot;|∛|g;
    s|&dash;|&mdash;|g;
    s|&deg;|°|g;
    s|&delta;|δ|g;
    s|&diams;|♦|g;
    s|&ditto;|〃|g;
    s|&divide;|÷|g;
    s|&dollar;|\$|g;
    s|&dp;|.|g;
    s|&eacute;|é|g;
    s|&ecirc;|ê|g;
    s|&egrave;|è|g;
    s|&emsp;| |g;
    s|&ensp;| |g;
    s|&epsi;|ε|g;
    s|&equals;|=|g;
    s|&eta;|η|g;
    s|&eth;|ð|g;
    s|&euro;|€|g;
#    s|&f1d16;|1/16|g; # left as an entity for now ...
    s|&flat;|♭|g;
    s|&frac12;|½|g;
    s|&frac13;|⅓|g;
    s|&frac14;|¼|g;
    s|&frac15;|⅕|g;
    s|&frac16;|⅙|g;
    s|&frac18;|⅛|g;
    s|&frac34;|¾|g;
    s|&frac58;|⅝|g;
#    s|&frac76;|7/6|g;
    s|&frac78;|⅞|g;
    s|&gamma;|γ|g;
#    s|&gt;|>|g; # keep as entity for IDM system ...
    s|&half;|½|g;
    s|&hearts;|♥|g;
    s|&hellip;|…|g;
    s|&hyphen;|-|g;
    s|&iacute;|í|g;
    s|&icirc;|î|g;
    s|&iexcl;|¡|g;
    s|&infin;|∞|g;
    s|&iota;|ι|g;
    s|&iquest;|¿|g;
    s|&iuml;|ï|g;
    s|&kappa;|κ|g;
    s|&lambda;|λ|g;
    s|&ldquo;|“|g;
    s|&lsquo;|‘|g;
#    s|&lt;|<|g; # keep as entity for IDM system ...
    s|&macr;|¯|g;
    s|&mdash;|—|g;
    s|&middot;|·|g;
    s|&minus;|−|g;
    s|&mu;|µ|g;
    s|&natur;|♮|g;
    s|&ndash;|–|g;
#    s|&notesym;|&notesym;|g;
    s|&ntilde;|ñ|g;
    s|&nu;|ν|g;
    s|&oacute;|ó|g;
    s|&ob;|/|g;
    s|&ocirc;|ô|g;
    s|&oelig;|œ|g;
    s|&ograve;|ò|g;
    s|&omega;|ω|g;
    s|&ordf;|ª|g;
    s|&ouml;|ö|g;
    s|&p;|ˈ|g;
    s|&pause;|͒|g;
    s|&percnt;|%|g;
    s|&phis;|φ|g;
    s|&pi;|π|g;
    s|&plus;|+|g;
    s|&pound;|£|g;
    s|&prime;|′|g;
    s|&psi;|ψ|g;
    s|&pvarr;|↔|g;
    s|&radic;|√|g;
    s|&rdquo;|”|g;
    s|&reg;|®|g;
    s|&rho;|ρ|g;
    s|&rsquo;|’|g;
    s|&s;|ˌ|g;
    s|&sharp;|♯|g;
    s|&sigma;|σ|g;
    s|&spades;|♠|g;
    s|&sub2;|₂|g;
    s|&sub3;|₃|g;
    s|&sub4;|₄|g;
    s|&sub5;|₅|g;
    s|&sub6;|₆|g;
    s|&sup100;|¹⁰⁰|g;
    s|&sup12;|¹²|g;
    s|&sup15;|¹⁵|g;
    s|&sup18;|¹⁸|g;
    s|&sup2;|²|g;
    s|&sup20;|²⁰|g;
    s|&sup24;|²⁴|g;
    s|&sup3;|³|g;
    s|&sup30;|³⁰|g;
    s|&sup4;|⁴|g;
    s|&sup9;|⁹|g;
    s|&supminus10;|⁻¹⁰|g;
    s|&supminus12;|⁻¹²|g;
    s|&supminus15|⁻¹⁵|g;
    s|&supminus18;|⁻¹⁸|g;
    s|&supminus24;|⁻²⁴|g;
#    s|&synsep;|&synsep;|g;
    s|&tau;|τ|g;
    s|&thetas;|θ|g;
    s|&thinsp;| |g;
    s|&tilde;|~|g;
    s|&times;|×|g;
    s|&trade;|™|g;
   s|&uacute;|ú|g;
    s|&ucirc;|û|g;
    s|&uuml;|ü|g;
    s|&upsi;|υ|g;
#    s|&w;|&w;|g;
    s|&xi;|ξ|g;
    s|&xrefarrow;|⇨|g;
    s|&xsep;|◇|g;
    s|&zeta;|ζ|g;

    print;
  
  }
  



