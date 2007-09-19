#!/usr/bin/perl -c

package MooseX::GlobRef::Meta::Class;
use 5.006;
our $VERSION = 0.01;

=head1 NAME 

MooseX::GlobRef::Meta::Class - Metaclass for globref objects

=head1 DESCRIPTION

This metaclass is used by L<MooseX::GlobRef::Object> base class and it has no
other purposes and funcionality.

=cut


use Moose;

extends 'Moose::Meta::Class';

1;


__END__

=head1 BASE CLASSES

=over 2

=item *

L<Moose::Meta::Class>

=back

=head1 SEE ALSO

L<MooseX::GlobRef::Object>, L<Moose::Meta::Object>, L<Moose>, L<metaclass>.

=head1 AUTHOR

Piotr Roszatycki E<lt>dexter@debian.orgE<gt>

=head1 LICENSE

Copyright 2006-2007 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
