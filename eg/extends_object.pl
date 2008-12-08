#!/usr/bin/perl -I../lib

package My::IO;

use Moose;

extends 'MooseX::GlobRef::Object';

has 'filename' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

sub open {
    my $fh      = shift;
    my $hashref = ${*$fh};
    open $fh, $hashref->{filename} or confess "cannot open";
    return $fh;
}

sub getlines {
    my $fh = shift;
    return readline $fh;
}

my $io = My::IO->new( filename => '/etc/passwd' );

print "::::::::::::::\n";
print $io->filename, "\n";
print "::::::::::::::\n";
$io->open;
print $io->getlines;
