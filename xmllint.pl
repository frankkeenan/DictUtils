use Getopt::Std;

require "/disk1/home/keenanf/perl/utils.pl";


$, = "\t";
$\ = "\n";
## undef $/;			# read in the whole file at once


getopts('dhl8');

&print_usage(0) if ($opt_h);

if ($opt_8) {
    binmode(STDIN, ":utf8");
    binmode(STDOUT, ":utf8");
}


### `main' routine ###

&proc($ARGV[0], "", $opt_d);

### end `main' routine ###


sub proc {

    my($xml, $dat, $dbg) = @_;

    &lint($xml, $dat, $dbg) if $xml;
}


sub print_usage {

    my $status = shift();

    ($cmd = $0) =~ s|^.*/||o;

    print STDERR "\nUSAGE:   $cmd [-dhl8] ...";
    print STDERR <<DONE;

         -d:   run in debug mode.
         -h:   display usage (i.e. this info).
         -l:   record operations in log file.
         -8:   set I/O mode to UTF8.
DONE
    exit $status unless $status eq "-";
}
