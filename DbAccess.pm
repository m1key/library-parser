use strict;
use warnings;

package DbAccess;

sub new {
    my $class = shift;
    my $self = {};
    bless $self, $class;
    return $self;
}
1;
