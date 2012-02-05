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

sub disconnect {
    say "Disconnecting from the database.";
    $dbh->disconnect();
}

1;
