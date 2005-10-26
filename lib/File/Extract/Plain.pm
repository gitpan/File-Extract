# $Id: Plain.pm 2 2005-10-26 01:53:50Z daisuke $
#
# Copyright (c) 2005 Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

package File::Extract::Plain;
use strict;
use base qw(File::Extract::Base);

sub mime_type { 'text/plain' }
sub extract
{
    my $class = shift;
    my $file  = shift;

    open(F, $file) or Carp::croak("Failed to open file $file: $!");
    local $/ = undef;
    return scalar(<F>);
}

1;

__END__

=head1 NAME

File::Extract::Plain - Extract Text From Plain Text Files

=head1 SEE ALSO

L<File::Extract|File::Extract>
L<File::Extract::Base|File::Extract::Base>

=cut
