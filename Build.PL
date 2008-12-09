#!/usr/bin/perl

use 5.006;
use Module::Build;

use strict;
use warnings;

my $build = Module::Build->new(
    module_name => 'MooseX::GlobRef::Object',
    dist_author => 'Piotr Roszatycki <dexter@debian.org>',
    license => 'perl',
    requires => {
        'perl'               => 5.006,
        'Moose'              => 0.56,
        'parent'             => 0,
    },
    optional => {
    },
    build_requires => {
        'Test::Unit::Lite'   => 0.07,
        'Test::Assert'       => 0,
    },
    create_makefile_pl => 'traditional',
    create_readme => 1,
    recursive_test_files => 1,
    add_to_cleanup => [
        'META.yml', '*.bak', '*.gz', '*.tgz', '*.ppd', '*.deb', '*.bat',
        'Makefile.PL', 'Makefile', 'pm_to_blib', 'README', 'cover_db',
        'Debian_CPANTS.txt',
        'MooseX-GlobRef-Object-*',
    ],
);

$build->create_build_script;
