#!/usr/bin/perl -c

package MooseX::GlobRef::Object;

=head1 NAME

MooseX::GlobRef::Object - Store a Moose object in glob reference

=head1 SYNOPSIS

  package My::IO;

  use Moose;

  extends 'MooseX::GlobRef::Object';

  has 'file' => ( is => 'ro', isa => 'Str', required => 1 );

  sub open {
    my $fh = shift;
    open $fh, $fh->file or confess "cannot open";
    return $fh;
  }

  sub getlines {
    my $fh = shift;
    return readline $fh;
  }

  my $io = My::IO->new( file => '/etc/passwd' );
  print "::::::::::::::\n";
  print $io->file, "\n";
  print "::::::::::::::\n";
  $io->open;
  print $io->getlines;

=head1 DESCRIPTION

This class extends L<Moose::Object> and is provided only for backward
compatibility. You should use L<MooseX::GlobRef> instead.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = '0.07';

use Moose;

use MooseX::GlobRef;


=head1 INHERITANCE

=over 2

=item *

extends L<Moose::Object>

=cut

extends 'Moose::Object';

=item *

with L<MooseX::GlobRef::Role::Object>

=back

=cut

with 'MooseX::GlobRef::Role::Object';


1;


=for readme stop

=head1 SEE ALSO

L<MooseX::GlobRef>, L<Moose::Object>.

=for readme continue

=head1 AUTHOR

Piotr Roszatycki <dexter@cpan.org>

=head1 LICENSE

Copyright (C) 2007, 2008, 2009 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
