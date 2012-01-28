use strict;
use warnings;
use Modern::Perl;

say "library-parser (c) 2012 Michal Huniewicz";
say "www.m1key.me";

if (@ARGV != 1) {
    die "Error: You must specify exactly one parameter - path to library.";
}

my $libraryPath = $ARGV[0];
printf "Using library file: [%s].\n", $libraryPath;
