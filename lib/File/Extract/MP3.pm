# $Id: MP3.pm 2 2005-10-26 01:53:50Z daisuke $
#
# Copyright (c) 2005 Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

package File::Extract::MP3;
use strict;
use base qw(File::Extract::Base);
use MP3::Info qw(get_mp3tag);

sub mime_type { 'audio/mpeg' }
sub extract
{
    my $class = shift;
    my $file  = shift;

    my $hash   = get_mp3tag($file);
    my %p;

    while (my($field, $value) = each %$hash) {
        next unless $value;
        $p{lc $field} = $value;
    }

    $p{file} = $file;
    my $result = File::Extract::Result->new(%p);
    return $result;
}

1;

__END__

=head1 NAME

File::Extract::MP3 - Extract Text From MP3 Files

=head1 SEE ALSO

L<File::Extract|File::Extract>
L<File::Extract::Base|File::Extract::Base>
L<MP3::Info>

=cut

