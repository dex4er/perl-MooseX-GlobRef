#!/usr/bin/perl -c

package MooseX::GlobRef::Role::Meta::Instance;

=head1 NAME

MooseX::GlobRef::Role::Meta::Instance - Instance metaclass for MooseX::GlobRef

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
file handle.  It can be used directly with L<metaclass> pragma or with
L<MooseX::GlobRef::Object> base class.

Notice, that C<use metaclass> have to be before C<use Moose>.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = '0.07';

use Moose::Role;


# Use weaken
use Scalar::Util ();


=head1 METHODS

=over

=item create_instance

=cut

override 'create_instance' => sub {
    my ($self) = @_;

    # create anonymous file handle
    select select my $fh;

    # initialize hash slot of file handle
    %{*$fh} = ();

    return bless $fh => $self->_class_name;
};


=item clone_instance

=cut

override 'clone_instance' => sub {
    my ($self, $instance) = @_;  

    # create anonymous file handle
    select select my $fh;

    # initialize hash slot of file handle
    %{*$fh} = ( %{*$fh} );

    return bless $fh => $self->_class_name;
};

=item get_slot_value

=cut

override 'get_slot_value' => sub {
    my ($self, $instance, $slot_name) = @_;
    return *$instance->{$slot_name};
};


=item set_slot_value

=cut

override 'set_slot_value' => sub {
    my ($self, $instance, $slot_name, $value) = @_;
    return *$instance->{$slot_name} = $value;
};


=item deinitialize_slot

=cut

override 'deinitialize_slot' => sub {
    my ($self, $instance, $slot_name) = @_;
    return delete *$instance->{$slot_name};
};


=item is_slot_initialized

=cut

override 'is_slot_initialized' => sub {
    my ($self, $instance, $slot_name) = @_;
    return exists *$instance->{$slot_name};
};


=item weaken_slot_value

=cut

override 'weaken_slot_value' => sub {
    my ($self, $instance, $slot_name) = @_;
    return Scalar::Util::weaken *$instance->{$slot_name};
};


=item inline_create_instance

=cut

override 'inline_create_instance' => sub {
    my ($self, $class_variable) = @_;
    return 'do { select select my $fh; %{*$fh} = (); bless $fh => ' . $class_variable . ' }';
};


=item inline_slot_access

The methods overridden by this class.

=back

=cut

override 'inline_slot_access' => sub {
    my ($self, $instance, $slot_name) = @_;
    return '*{' . $instance . '}->{' . $slot_name . '}';
};


no Moose::Role;

1;


=head1 SEE ALSO

L<MooseX::GlobRef>, L<Moose::Meta::Instance>, L<Moose>.

=head1 AUTHOR

Piotr Roszatycki <dexter@cpan.org>

=head1 LICENSE

Copyright (C) 2007, 2008, 2009 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
