#!/usr/bin/perl

use strict;
use Pod::Usage;
use Getopt::Long;
use Encode;

my ( $ityp, $otyp ) = ( qw/u8 pe/ );
$ityp = "u8";
$otyp = "he";
my $man = my $help = my $vctl = 0;
#my $okargs = GetOptions( 'help|?' => \$help, man => \$man, c => \$vctl,  'i=s' => \$ityp, 'o=s' => \$otyp );

#pod2usage(-exitstatus => 0, -verbose => 2) if $man;
#pod2usage(1) if ( $help or $ityp !~ /^u[8fbln]/ or $otyp !~ /^u[8cfbln]|[dhpy]e$/ );
#pod2usage(2) if ( ! $okargs or ( @ARGV == 0 and -t ));

my $native = (pack("S",1) eq pack("v",1)) ? 'UTF-16LE' : 'UTF-16BE';
my %mode = ( ub => 'UTF-16BE',
	    ul => 'UTF-16LE',
	    un => $native,
            );
my %format = ( de => '&#%d;',
	      he => '&#x%04X;',
	      pe => '\x{%04x}',
	      ye => '\u%04x',
	      uc => 'U+%04X',
	      );
my $replset = ( $vctl ) ? '[^\x09\x0a\x20-\x7e]' : '[^\x00-\x7f]';
my $replsub;
$replsub = sub { local($_) = shift; 
		 s/($replset)/sprintf($format{$otyp},ord($1))/ge; $_ }    if ( $otyp =~ /.[ec]/ );

my $imode = ( $ityp =~ /u[bln]/ ) ? $mode{$ityp} : 'utf8';
my $omode = ( $otyp =~ /u[bln]/ ) ? ":encoding($mode{$otyp})" : ':utf8';

binmode STDOUT, $omode;
my $buffer;
my %names;
if ( $otyp =~ /uf/ ) {
    for ( split /^/, do 'unicore/Name.pl' ) {
        my @f = split( /\t/ );
        if ( $f[1] eq '' ) {
            $names{$f[0]} = $f[2];
        }
        else {
            $names{range}{$f[2]} = [ $f[0], $f[1] ];
        }
    }
}

while (<>) {
    $_ = decode( $imode, $_ );
    if ( $ityp =~ /uf/ ) {
        next unless ( /^([\da-f]{1,5})\s/i );
        my $cp = chr(hex($1));
        $buffer .= $cp;
        next unless ( $cp =~ /\n/ );
    }
    elsif ( $imode eq 'utf8' ) {   # check for ascii-fied encodings:
        s/\&#(\d+);/chr($1)/ge;                 # decimal char. entity
        s/\&#x([\da-f]+);/chr(hex($1))/ige;     # hex char. entity
        s/\\u([\da-f]{4,5})/chr(hex($1))/ige;   # Python hex notation
        s/\\x\{([\da-f]+)\}/chr(hex($1))/ige;   # Perl hex notation
        s/U\+([\dA-Fa-f]{4,5})/chr(hex($1))/ge; # unicode.org notation
    }

    if ( length( $buffer )) {
        $_ = $buffer;
        $buffer = '';
    }
    elsif ( defined( $replsub)) {
        $_ = &$replsub( $_ ) ;
    }
    s|& |&\#x0026; |gi;
    if ( $otyp !~ /uf/ ) {
        print;
    }
    else {
        for my $c ( split // ) {
            my $h = sprintf( "%04X", ord( $c ));
            my $name = $names{$h} || get_range( $h ) || "undefined cod
+epoint\n";

            if ( $otyp eq 'uf' ) {
                $c =~ s/([\x00-\x1f\x7f])/sprintf("^%s",chr(ord($1)+64))/e;
                print "$h\t$c\t$name";
            } else {
                print "$h\t$name";
            }
        }
    }
}

sub get_range
{
    my $h = shift;
    for ( keys %{$names{range}} ) {
        if ( $h ge $names{range}{$_}[0] and
	    $h le $names{range}{$_}[1] ) {
            return $_;
        }
    }
    return;
}

