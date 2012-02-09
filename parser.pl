use strict;
use warnings;
use Modern::Perl;
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
my $totalTime = "";
my $discNumber = "";
my $trackNumber = "";
my $playCount = "";
while (<$in>) {
    if (/<key>Name<\/key><string>(.+)<\/string>/) {
	$trackName = $1;
	print $out $_;
    } elsif (/<key>Album<\/key><string>(.+)<\/string>/) {
	$albumName = $1;
	print $out $_;
    } elsif (/<key>Album Artist<\/key><string>(.+)<\/string>/) {
	$albumArtistName = $1;
	print $out $_;
    } elsif (/<key>Artist<\/key><string>(.+)<\/string>/) {
	$artistName = $1;
	print $out $_;
    } elsif (/<key>Total Time<\/key><integer>(.+)<\/integer>/) {
	$totalTime = $1;
	print $out $_;
    } elsif (/<key>Disc Number<\/key><integer>(.+)<\/integer>/) {
	$discNumber = $1;
	print $out $_;
    } elsif (/<key>Track Number<\/key><integer>(.+)<\/integer>/) {
	$trackNumber = $1;
	print $out $_;
    } elsif (/<key>Play Count<\/key><integer>(\d+)/) {
	$playCount = $1;

	my $artist = $albumArtistName ? $albumArtistName : $artistName;
	my $playCountFromDb = $dbAccess->handleTrack($artist, $albumName, $trackName, $totalTime, $trackNumber, $discNumber);
	my $totalPlayCount = $playCountFromDb + $playCount;
	#say "Total play count for $trackName: $totalPlayCount";
	my $updatedRow = $_;
	$updatedRow =~ s/\d+/$totalPlayCount/;
	#print "$trackName: $updatedRow";

	$trackName = "";
	$albumName = "";
	$albumArtistName = "";
	$artistName = "";
	$totalTime = "";
	$discNumber = "";
	$trackNumber = "";
	$playCount = "";

	print $out $updatedRow;
    } else {
	print $out $_;
    }
}

$dbAccess->disconnect();
close $in or die "$in: $!";
close $out or die "$out: $!";

say "Bye";
