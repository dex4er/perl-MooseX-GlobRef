#!/usr/bin/perl -I../lib

package My::IO;

use Moose;

extends 'MooseX::GlobRef::Object';

has 'filename' => ( is => 'ro', isa => 'Str', required => 1 );

sub open {
  my $fh = shift;
  open $fh, $fh->filename or confess "cannot open";
  return $fh;
}

sub getlines {
  my $fh = shift;
  return readline $fh;
}

my $io = new My::IO filename=>'/etc/passwd';

print "::::::::::::::\n";
print $io->filename, "\n";
print "::::::::::::::\n";
$io->open;
print $io->getlines;
