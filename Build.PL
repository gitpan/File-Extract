#!perl
# $Id: Build.PL 6 2005-10-27 01:43:47Z daisuke $
#
# Copyright (c) 2005 Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

use strict;
use Module::Build;

my %requires = (
    'CAM::PDF'                => 0,
    'Encode'                  => 0,
    'File::MMagic::XS'        => 0,
    'HTML::TreeBuilder'       => 0,
    'IO::Scalar'              => 0,
    'IPC::Open2'              => 0,
    'MP3::Info'               => 0,
# We actually want below, but some how CPAN doesn't seem to understand
# that it belongs to a different package.
#    'RTF::Lexer'        => 0,
    'RTF::HTMLConverter'      => 0,
    'Spreadsheet::ParseExcel' => 0,
    'UNIVERSAL::isa'          => 0,
);

print <<EOM;
  File::Extract experimentally uses CAM::PDF to extract text out of PDF
  files. We may or may not change this in the future, so we can remove
  this from the dependency list if you don't want to parse PDF right at
  this moment.

EOM

if (! Module::Build->y_n('  Keep CAM::PDF in the dependency list? ', 'n')) {
    delete $requires{'CAM::PDF'};
}

print <<EOM;
  File::Extract experimentally uses Spreadsheet::ParseExcel to extract text
  out of Excel files. We may or may not change this in the future, so we can
  remove this from the dependency list if you don't want to parse PDF right at
  this moment.

EOM

if (! Module::Build->y_n('  Keep Spreadsheet::ParseExcel in the dependency list? ', 'n')) {
    delete $requires{'Spreadsheet::ParseExcel'};
}

my $build = Module::Build->new(
    dist_name          => 'File-Extract',
    dist_version_from  => 'lib/File/Extract.pm',
    license            => 'perl',
    create_makefile_pl => 'traditional',
    create_readme      => 1,
    requires           => \%requires
);

$build->create_build_script;