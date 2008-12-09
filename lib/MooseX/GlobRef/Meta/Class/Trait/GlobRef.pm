#!/usr/bin/perl -c

package MooseX::GlobRef::Meta::Class::Trait::GlobRef;

=head1 NAME 

MooseX::GlobRef::Meta::Class::Trait::GlobRef - Class trait for GlobRef

=head1 SYNOPSIS

  package My::IO;
  use Moose -traits => 'GlobRef';
  has 'filename' => ( is => 'ro', isa => 'Str', required => 1 );

=head1 DESCRIPTION

This custom class trait registers instance metaclass which allows to store
Moose object in glob reference.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = 0.03;

use Moose::Role;


use constant instance_metaclass => 'MooseX::GlobRef::Meta::Instance';


1;


__END__

=head1 METHODS

=over

=item instance_metaclass

=back

Returns the class name of the instance metaclass.

=head1 SEE ALSO

L<Class::MOP::Class/instance_metaclass>, L<MooseX::GlobRef::Object>.

=head1 AUTHOR

Piotr Roszatycki E<lt>dexter@debian.orgE<gt>

=head1 LICENSE

Copyright (C) 2007, 2008 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
