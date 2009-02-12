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

This meta-policy allows to store Moose object in glob reference of file
handle.  The class attributes will be stored in hash slot associated with glob
reference.  It allows to create a Moose version of L<IO::Handle>.

The attributes can be accessed directly with following expression:

  my $hashref = \%{*$self};
  print $hashref->{key};

or shorter:

  print *$self->{key};

but the standard accessors should be used instead:

  print $self->key;

You can use L<MooseX::GlobRef::Meta::Instance> metaclass directly if you need
more customised configuration.

=cut

use 5.006;
use strict;
use warnings;

our $VERSION = '0.06';


use metaclass 'MooseX::GlobRef::Meta::Class';


=head1 INHERITANCE

=over 2

=item *

extends L<Moose::Object>

=back

=cut

use parent 'Moose::Object';


1;


=for readme stop

=head1 SEE ALSO

L<MooseX::GlobRef::Meta::Instance>, L<MooseX::GlobRef::Meta::Class>,
L<Moose>, L<metaclass>.

=for readme continue

=head1 AUTHOR

Piotr Roszatycki <dexter@cpan.org>

=head1 LICENSE

Copyright (C) 2007, 2008, 2009 by Piotr Roszatycki E<lt>dexter@debian.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>
