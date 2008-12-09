#!/usr/bin/perl -c

package Moose::Meta::Class::Custom::Trait::GlobRef;

=head1 NAME 

Moose::Meta::Class::Custom::Trait::GlobRef - Class trait for GlobRef

=head1 SYNOPSIS

  package My::IO;
  use Moose -traits => 'GlobRef';
  has 'filename' => ( is => 'ro', isa => 'Str', required => 1 );

=head1 DESCRIPTION

This custom class trait registers implementation of role which allows to store
Moose object in glob reference.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = 0.03;


use constant register_implementation => 'MooseX::GlobRef::Meta::Class::Trait::GlobRef';


1;


__END__

=head1 METHODS

=over

=item register_implementation

Return the real class name of the trait.

=back

=head1 SEE ALSO

L<Moose/METACLASS TRAITS>, L<MooseX::GlobRef::Object>.

=head1 AUTHOR

Piotr Roszatycki E<lt>dexter@debian.orgE<gt>

=head1 LICENSE

Copyright (C) 2007, 2008 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
