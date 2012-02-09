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
    my ($self, $artist, $albumName, $trackName, $totalTime, $trackNumber, $discNumber) = @_;

    #printf "%s - %s - %s: x%s (%s)(%s:%s)\n", $artist, $albumName, $trackName, $totalTime, $trackNumber, $discNumber;

    my $selectSong = $dbh->prepare("select st.PLAY_COUNT from SONGS s
join ALBUMS al ON s.ALBUM_ID = al.ALBUM_ID
join ARTISTS ar ON al.ARTIST_ID = ar.ARTIST_ID
join STATS st ON st.SONG_UUID = s.UUID
join LIBRARIES l on st.library_id = l.library_id
where s.NAME = ? and al.NAME = ? and ar.NAME = ? AND s.SONG_KEY = ?
order by l.DATE_ADDED LIMIT 1");
    my $playCount = 0;
    $selectSong->execute($trackName, $albumName, $artist, &toKey($totalTime, $trackNumber, $discNumber)) or die $DBI::errstr;
    if(my @row = $selectSong->fetchrow_array()) {
	#say "Song found: $row[0], $row[1]";
	$playCount = $row[0];
    }
    $selectSong->finish();
    return $playCount;
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
