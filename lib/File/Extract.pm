# $Id: Extract.pm 4 2005-10-26 02:03:34Z daisuke $
#
# Copyright (c) 2005 Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

package File::Extract;
use strict;
use base qw(Class::Data::Inheritable);
use File::MMagic::XS;
our $VERSION = '0.02';

sub new
{
    my $class = shift;
    my %args  = @_;

    my $encoding  = $args{output_encoding} || 'utf8';
    my @encodings = $args{encodings} ?
        (ref($args{encodings}) eq 'ARRAY' ? @{$args{encodings}} : $args{encodings}) : ();
    my $self  = bless {
        magic => 
            $args{file_mmagic_args} ?
                File::MMagic::XS->new(%{$args{file_mmagic_args}}) :
                File::MMagic::XS->new(),
        encodings => \@encodings,
        output_encoding => $encoding
    }, $class;

    return $self;
}

sub register
{
    my $class = shift;
    my $pkg   = shift;

    eval "require $pkg" or die;
    my $mime  = $pkg->mime_type;
    $class->RegisteredProcessors->{$mime} ||= [];
    push @{$class->RegisteredProcessors->{$mime}}, $pkg;
}

sub extract
{
    my $self  = shift;
    my $file  = shift;

    my $magic = $self->{magic};
    my $mime  = $magic->get_mime($file);
    return unless $mime;

    my $procs = $self->RegisteredProcessors->{$mime};

    foreach my $pkg (@$procs) {
        my $p = $pkg->new(
            encodings       => $self->{encodings},
            output_encoding => $self->{output_encoding}
        );
        my $r = eval { $p->extract($file) };
        return $r if $r;
    }
}

BEGIN
{
    __PACKAGE__->mk_classdata('RegisteredProcessors');
    __PACKAGE__->RegisteredProcessors({});

    my @p = qw(
        File::Extract::HTML
        File::Extract::MP3
        File::Extract::Plain
        File::Extract::RTF
    );
    foreach my $p (@p) {
        __PACKAGE__->register($p);
    }
}

1;

__END__

=head1 NAME

File::Extract - Extract Text From Arbitrary File Types

=head1 SYNOPSIS

  use File::Extract;
  my $e = File::Extract->new();
  my $r = $e->extract($filename);

  my $e = File::Extract->new(encodings => [...]);

  my $class = "MyExtractor";
  File::Extract->register($class);

=head1 DESCRIPTION

File::Extract is a framework to extract text data out of arbitrary file types,
useful to collect data for indexing.

=head1 CLASS METHODS

=head2 register($class)

Registers a new text-extractor. The specified class needs to implement
two functions:

=over 4

=item mime_type(void)

Returns the MIME type that $class can extract files from. 

=item extract($file)

Extracts the text from $file. Returns a File::Extract::Result object.

=back

=head1 METHODS

=item encodings

List of encodings that you expect your files to be in. This is used to
re-encode and normalize the contents of the file via Encode::Guess.

=item output_encoding

The final encoding that you the extracted test to be in. The default
encoding is UTF8.

=head2 new(%args)

=head2 extract($file)

=head1 SEE ALSO

L<File::MMagic::XS|File::MMagic::XS>

=head1 AUTHOR

Copyright 2005 Daisuke Maki E<lt>dmaki@cpan.orgE<gt>. All rights reserved.
Development funded by Brazil, Ltd. E<lt>http://b.razil.jpE<gt>

=cut
