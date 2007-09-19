#!/usr/bin/perl -c

package MooseX::GlobRef::Object;
use 5.006;
our $VERSION = 0.01;

=head1 NAME 

MooseX::GlobRef::Object - Store a Moose object in glob reference

=head1 SYNOPSIS

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
  
=head1 DESCRIPTION

This meta-policy allows to store Moose object in glob reference or file
handle.  It allows to create a Moose version of F<IO::Handle>.

You can use L<MooseX::GlobRef::Meta::Instance> metaclass directly if you need
more customised configuration.

=cut


use metaclass 'MooseX::GlobRef::Meta::Class' =>
    instance_metaclass => 'MooseX::GlobRef::Meta::Instance';

use Moose;
extends 'Moose::Object';

1;


__END__

=head1 BASE CLASSES

=over 2

=item *

L<Moose::Object>

=back

=head1 SEE ALSO

L<MooseX::GlobRef::Meta::Instance>, L<MooseX::GlobRef::Meta::Class>,
L<Moose>, L<metaclass>.

=head1 AUTHOR

Piotr Roszatycki E<lt>dexter@debian.orgE<gt>

=head1 LICENSE

Copyright 2006-2007 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
