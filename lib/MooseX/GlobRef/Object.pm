#!/usr/bin/perl -c

package MooseX::GlobRef::Object;
use 5.006;
our $VERSION = 0.02_03;

=head1 NAME 

MooseX::GlobRef::Object - Store a Moose object in glob reference

=head1 SYNOPSIS

  package My::IO;

  use Moose;

  extends 'MooseX::GlobRef::Object';

  has 'filename' => ( is => 'ro', isa => 'Str', required => 1 );

  sub open {
    my $fh = shift;
    my $hashref = ${*$fh};
    open $fh, $hashref->{filename} or confess "cannot open";
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
  
=head1 DESCRIPTION

This meta-policy allows to store Moose object in glob reference or file
handle.  The class attributes will be stored in anonymous hash associated
with glob reference.  It allows to create a Moose version of F<IO::Handle>.

The elements of hash can be accessed with B<${*$self}-E<gt>{key}> expression.

You can use L<MooseX::GlobRef::Meta::Instance> metaclass directly if you need
more customised configuration.

=cut


use metaclass 'MooseX::GlobRef::Meta::Class' =>
    instance_metaclass => 'MooseX::GlobRef::Meta::Instance';

use base 'Moose::Object';


1;


__END__

=for readme stop

=head1 BASE CLASSES

=over 2

=item *

L<Moose::Object>

=back

=head1 SEE ALSO

L<MooseX::GlobRef::Meta::Instance>, L<MooseX::GlobRef::Meta::Class>,
L<Moose>, L<metaclass>.

=for readme continue

=head1 AUTHOR

Piotr Roszatycki E<lt>dexter@debian.orgE<gt>

=head1 LICENSE

Copyright (C) 2007 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
