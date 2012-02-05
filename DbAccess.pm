use strict;
use warnings;
use DBI;
use Modern::Perl;

package DbAccess;

my $dsn = 'dbi:mysql:audiolicious_test:localhost:3306'; 
my $user = 'root';
my $pass = '';

my $dbh;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub connect {
    say "Connecting to the database.";
    $dbh = DBI->connect($dsn, $user, $pass)
	or die "Can't connect to the DB: $DBI::errstr";
}

sub handleTrack {
    my ($self, $artist, $albumName, $trackName, $playCount, $totalTime, $trackNumber, $discNumber) = @_;

    #printf "%s - %s - %s: x%s (%s)(%s:%s)\n", $artist, $albumName, $trackName, $playCount, $totalTime, $trackNumber, $discNumber;

    my $selectArtist = $dbh->prepare("select NAME from ARTISTS where NAME = ?");
    $selectArtist->execute($artist) or die $DBI::errstr;
    if(my @row = $selectArtist->fetchrow_array()) {
	#say "Artist found: $row[0]";
    } else {
	#say "Artist not found: $artist";
    }
    $selectArtist->finish();
}

sub disconnect {
    say "Disconnecting from the database.";
    $dbh->disconnect();
}

1;
