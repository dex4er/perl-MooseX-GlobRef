#!/usr/bin/perl -c

package MooseX::GlobRef::Meta::Class;

=head1 NAME 

MooseX::GlobRef::Meta::Class - Metaclass for globref objects

=head1 DESCRIPTION

This metaclass is used by L<MooseX::GlobRef::Object> base class and it has no
other purposes and funcionality.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = 0.03;


use parent 'Moose::Meta::Class';


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

Copyright (C) 2007, 2008 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
