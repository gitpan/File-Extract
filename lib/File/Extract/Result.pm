# $Id: Result.pm 2 2005-10-26 01:53:50Z daisuke $
#
# Copyright (c) 2005 Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

package File::Extract::Result;
use strict;

sub new
{
    my $class = shift;
    my %args  = @_;
    my $self  = bless {%args}, $class;
    return $self;
}

1;

__END__

=head1 NAME

File::Extract::Result - Extraction Result Object

=head1 DESCRIPTION

=head1 METHODS

=head2 new

=cut
