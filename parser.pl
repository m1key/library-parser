use strict;
use warnings;
use Modern::Perl;

&printIntro;

if (@ARGV != 1) {
    die "Error: You must specify exactly one parameter - path to library.";
}

my $libraryPath = $ARGV[0];
printf "Using library file: [%s].\n", $libraryPath;


sub printIntro {
    say "library-parser (c) 2012 Michal Huniewicz";
    say "www.m1key.me";

    say "Usage: perl parser.pl <library file>";

    say "--------------------";
}
