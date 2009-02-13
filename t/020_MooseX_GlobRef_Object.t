#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use Cwd;

BEGIN {
    unshift @INC, map { /(.*)/; $1 } split(/:/, $ENV{PERL5LIB}) if defined $ENV{PERL5LIB} and ${^TAINT};

    my $cwd = ${^TAINT} ? do { local $_=getcwd; /(.*)/; $1 } : '.';
    unshift @INC, File::Spec->catdir($cwd, 't/tlib');
};

use Test::Unit::Lite;

local $SIG{__WARN__} = sub { require Carp; Carp::confess("Warning: ", @_) };

my $suite = __FILE__;
$suite =~ s/.*\d{3}_(.*)\.t/$1/ or die;
$suite =~ s/_/::/g;
$suite .= "TestSuite";

Test::Unit::HarnessUnit->new->start($suite);
