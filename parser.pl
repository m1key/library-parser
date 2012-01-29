use strict;
use warnings;
use Modern::Perl;

require "messages.pl";

&printIntro;

if (@ARGV != 1) {
    die "Error: You must specify exactly one parameter - path to library.";
}

my $libraryPath = $ARGV[0];
printf "Using library file: [%s].\n", $libraryPath;
