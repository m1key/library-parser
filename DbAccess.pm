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

    my $selectSong = $dbh->prepare("select s.NAME from SONGS s
join ALBUMS al ON s.ALBUM_ID = al.ALBUM_ID
join ARTISTS ar ON al.ARTIST_ID = ar.ARTIST_ID
where s.NAME = ? and al.NAME = ? and ar.NAME = ? AND s.SONG_KEY = ?");
    $selectSong->execute($trackName, $albumName, $artist, &toKey($totalTime, $trackNumber, $discNumber)) or die $DBI::errstr;
    if(my @row = $selectSong->fetchrow_array()) {
	#say "Song found: $row[0]";
    } else {
	#say "Song not found: $trackName";
    }
    $selectSong->finish();
}

sub toKey {
    my ($totalTime, $trackNumber, $discNumber) = @_;
    return "$totalTime:$trackNumber:$discNumber";
}

sub disconnect {
    say "Disconnecting from the database.";
    $dbh->disconnect();
}

1;
