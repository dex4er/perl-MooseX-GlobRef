#!/usr/bin/perl -c

package MooseX::GlobRef::Role::Object;

=head1 NAME

MooseX::GlobRef::Role::Object - A role for MooseX::GlobRef

=head1 SYNOPSIS

  Moose::Util::MetaRole::apply_base_class_roles
      ( for_class => $caller,
        roles =>
        [ 'MooseX::StrictConstructor::Role::Object' ],
      );

=head1 DESCRIPTION

This is a role for L<Moose::Object> which is applied by L<MooseX::GlobRef>.
It allows to store Moose object in glob reference of file handle.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = '0.07';

use Moose::Role;


=head1 METHODS

=over

=item dump

See L<Moose::Object>.

=back

=cut

override 'dump' => sub {
    my ($self) = @_;
    require Data::Dumper;
    local $Data::Dumper::Maxdepth = shift || 1;
    return super, Data::Dumper::Dumper( \%{*$self} );
};


no Moose::Role;

1;


=for readme stop

=head1 SEE ALSO

L<MooseX::GlobRef>, L<Moose::Object>, L<Moose::Role>.

=for readme continue

=head1 AUTHOR

Piotr Roszatycki <dexter@cpan.org>

=head1 LICENSE

Copyright (C) 2007, 2008, 2009 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
