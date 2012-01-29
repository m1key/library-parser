use strict;
use warnings;
use Modern::Perl;

require "messages.pl";
&printIntro;

require "arguments.pl";
my $libraryPath = &getLibraryPath;
printf "Using library file: [%s].\n", $libraryPath;

open(my $in,  "<",  $libraryPath)  or die "Can't open library file.";
say "Opened library file."
