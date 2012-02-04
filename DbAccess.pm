use strict;
use warnings;
use DBI;
use Modern::Perl;

my $dsn = 'dbi:mysql:audiolicious_test:localhost:3306'; 
my $user = 'root';
my $pass = '';

package DbAccess;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}

sub connect {
    say "Connecting to the database.";
}

1;
