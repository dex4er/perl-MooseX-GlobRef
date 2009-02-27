#!/usr/bin/perl -c

package MooseX::GlobRef;

=head1 NAME

MooseX::GlobRef - Store a Moose object in glob reference

=head1 SYNOPSIS

  package My::IO;

  use Moose;
  use MooseX::GlobRef;

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

This module allows to store Moose object in glob reference of file handle.
The class attributes will be stored in hash slot associated with glob
reference.  It allows to create a Moose version of L<IO::Handle>.

The attributes can be accessed directly with following expression:

  my $hashref = \%{*$self};
  print $hashref->{key};

or shorter:

  print *$self->{key};

but the standard accessors should be used instead:

  print $self->key;

=for readme stop

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = '0.07';


use Moose 0.56 ();
use Moose::Exporter;
use Moose::Util::MetaRole;
use MooseX::GlobRef::Role::Object;
use MooseX::GlobRef::Role::Meta::Instance;


Moose::Exporter->setup_import_methods();


=head1 METHODS

=over

=item B<init_meta>( I<args> : Hash ) : Moose::Meta::Class

See L<Moose::Exporter>.

=back

=cut

sub init_meta {
    my (undef, %args) = @_;

    Moose->init_meta(%args);

    my $caller = $args{for_class};

    Moose::Util::MetaRole::apply_metaclass_roles(
        for_class => $caller,
        instance_metaclass_roles =>
            [ 'MooseX::GlobRef::Role::Meta::Instance' ],
    );

    Moose::Util::MetaRole::apply_base_class_roles(
        for_class => $caller,
        roles => [ 'MooseX::GlobRef::Role::Object' ],
    );

    return $caller->meta();
};


1;


=head1 SEE ALSO

L<Moose>.

=for readme continue

=head1 AUTHOR

Piotr Roszatycki <dexter@cpan.org>

=head1 LICENSE

Copyright (C) 2007, 2008, 2009 by Piotr Roszatycki E<lt>dexter@cpan.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
