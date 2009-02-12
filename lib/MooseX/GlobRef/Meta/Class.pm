#!/usr/bin/perl -c

package MooseX::GlobRef::Meta::Class;

=head1 NAME

MooseX::GlobRef::Meta::Class - Metaclass for globref objects

=head1 SYNOPSIS

  package My::IO;

  use metaclass 'MooseX::GlobRef::Meta::Class';

  use Moose;

  has 'file' => ( is => 'ro', isa => 'Str', required => 1 );

  sub open {
    my $fh = shift;
    open $fh, $fh->file or confess "cannot open";
    return $fh;
  };

  sub getlines {
    my $fh = shift;
    return readline $fh;
  };

  my $io = My::IO->new( file => '/etc/passwd' );
  print "::::::::::::::\n";
  print $io->file, "\n";
  print "::::::::::::::\n";
  $io->open;
  print $io->getlines;

=head1 DESCRIPTION

This metaclass is used by L<MooseX::GlobRef::Object> base class and it uses
L<MooseX::GlobRef::Meta::Instance> as instance metaclass.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = '0.06';


use MooseX::GlobRef::Meta::Instance;


=head1 INHERITANCE

=over 2

=item *

extends L<Moose::Meta::Class>

=over 2

=item   *

extends L<Class::MOP::Class>

=over 2

=item     *

extends L<Class::MOP::Module>

=over 2

=item       *

extends L<Class::MOP::Package>

=over 2

=item         *

extends L<Class::MOP::Object>

=back

=back

=back

=back

=back

=cut

use parent 'Moose::Meta::Class';


## no critic (RequireArgUnpacking)

=head1 METHODS

=over

=item initialize

The methods overridden by this class.

=back

=cut

sub initialize {
    my $class = shift;
    my $pkg   = shift;
    return $class->SUPER::initialize(
        $pkg,
        instance_metaclass => 'MooseX::GlobRef::Meta::Instance',
        @_,
    );
};


1;


=head1 SEE ALSO

L<MooseX::GlobRef::Object>, L<Moose::Meta::Class>, L<Moose>, L<metaclass>.

=head1 AUTHOR

Piotr Roszatycki <dexter@cpan.org>

=head1 LICENSE

Copyright (C) 2007, 2008, 2009 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
