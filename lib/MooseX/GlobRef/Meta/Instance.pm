#!/usr/bin/perl -c

package MooseX::GlobRef::Meta::Instance;

=head1 NAME

MooseX::GlobRef::Meta::Instance - Instance metaclass for globref objects

=head1 SYNOPSIS

  package My::IO;

  use metaclass 'Moose::Meta::Class' => (
      instance_metaclass => 'MooseX::GlobRef::Meta::Instance'
  );

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

This instance metaclass allows to store Moose object in glob reference of
file handle.  It can be used directly with C<metaclass> pragma or with
L<MooseX::GlobRef::Object> base class.

Notice, that C<use metaclass> have to be before C<use Moose>.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = '0.05';


use parent 'Moose::Meta::Instance';


sub create_instance {
    my ($self) = @_;

    # create anonymous file handle
    select select my $instance;

    # initialize hash slot of file handle
    %{*$instance} = ();

    return bless $instance => $self->associated_metaclass->name;
};


sub get_slot_value {
    my ($self, $instance, $slot_name) = @_;
    return do { \%{*$instance} }->{$slot_name};
};


sub set_slot_value {
    my ($self, $instance, $slot_name, $value) = @_;
    return do { \%{*$instance} }->{$slot_name} = $value;
};


sub deinitialize_slot {
    my ( $self, $instance, $slot_name ) = @_;
    return delete do { \%{*$instance} }->{$slot_name};
};


sub is_slot_initialized {
    my ($self, $instance, $slot_name) = @_;
    return exists do { \%{*$instance} }->{$slot_name};
};


sub weaken_slot_value {
    my ($self, $instance, $slot_name) = @_;
    return Scalar::Util::weaken do { \%{*$instance} }->{$slot_name};
};


sub inline_create_instance {
    my ($self, $class_variable) = @_;
    return 'select select my $fh; %{*$fh} = (); bless $fh => ' . $class_variable;
};


sub inline_slot_access {
    my ($self, $instance, $slot_name) = @_;
    return 'do { \%{*{' . $instance . '}} }->{' . $slot_name . '}';
};


1;


__END__

=head1 INHERITANCE

=over 2

=item *

extends L<Moose::Meta::Instance>

=over 2

=item   *

extends L<Class::MOP::Instance>

=over 2

=item     *

extends L<Class::MOP::Object>

=back

=back

=back

=head1 METHODS

=over

=item create_instance

=item get_slot_value

=item set_slot_value

=item deinitialize_slot

=item is_slot_initialized

=item weaken_slot_value

=item inline_create_instance

=item inline_slot_access

The methods overridden by this class.

=back

=head1 SEE ALSO

L<MooseX::GlobRef::Object>, L<Moose::Meta::Instance>, L<Moose>, L<metaclass>.

=head1 AUTHOR

Piotr Roszatycki <dexter@cpan.org>

=head1 LICENSE

Copyright (C) 2007, 2008, 2009 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
