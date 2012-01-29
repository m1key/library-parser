use strict;
use warnings;
use Modern::Perl;

require "messages.pl";
&printIntro;

my $libraryPath = &getLibraryPath;
printf "Using library file: [%s].\n", $libraryPath;

sub getLibraryPath {
    if (@ARGV == 0) {
	"data/iTunes Music Library.xml";
    } else {
	$ARGV[0];
    }
}
