#!perl
# $Id: Build.PL 2 2005-10-26 01:53:50Z daisuke $
#
# Copyright (c) 2005 Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

use strict;
use Module::Build;

my $build = Module::Build->new(
    dist_name          => 'File-Extract',
    dist_version_from  => 'lib/File/Extract.pm',
    license            => 'perl',
    create_makefile_pl => 'traditional',
    create_readme      => 1,
    requires           => {
        'Encode'            => 0,
        'File::MMagic::XS'  => 0,
        'HTML::TreeBuilder' => 0,
        'MP3::Info'         => 0,
        'RTF::Lexer'        => 0,
    },
);

$build->create_build_script;