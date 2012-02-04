use strict;
use warnings;
use Modern::Perl;
use DBI;
use DbAccess;

require "messages.pl";
&printIntro;

require "arguments.pl";
my $libraryPath = &getLibraryPath;
printf "Using library file: [%s].\n", $libraryPath;

open(my $in,  "<",  $libraryPath)  or die "Can't open library file: $!";
say "Opened library file.";

open(my $out, ">", "output.xml") or die "Can't open output.xml: $!";

my $dbAccess = new DbAccess();
$dbAccess->connect();

my $trackName = "";
my $albumName = "";
my $albumArtistName = "";
my $artistName = "";
while (<$in>) {
    if (/<key>Name<\/key><string>(.+)<\/string>/) {
	$trackName = $1;
    } elsif (/<key>Album<\/key><string>(.+)<\/string>/) {
	$albumName = $1;
    } elsif (/<key>Album Artist<\/key><string>(.+)<\/string>/) {
	$albumArtistName = $1;
    } elsif (/<key>Artist<\/key><string>(.+)<\/string>/) {
	$artistName = $1;
    } elsif (/<key>Play Count<\/key><integer>(\d+)/) {
	my $artist = $albumArtistName ? $albumArtistName : $artistName;
	#printf "%s - %s - %s: %d\n", $artist, $albumName, $trackName, $1;
	$trackName = "";
	$albumName = "";
	$albumArtistName = "";
	$artistName = "";	
    }
    
    print $out $_;
}

$dbAccess->disconnect();
close $in or die "$in: $!";
close $out or die "$out: $!";

say "Bye";
