package MooseX::GlobRef::Meta::InstanceTest;

use parent 'MooseX::GlobRef::ObjectBaseTest';

use constant test_class => (__PACKAGE__ . '::TestClass');

{
    package MooseX::GlobRef::Meta::InstanceTest::TestClass;

    use metaclass 'Moose::Meta::Class' => (
        instance_metaclass => 'MooseX::GlobRef::Meta::Instance'
    );

    use Moose;

    has field => (
        is      => 'rw',
        clearer => 'clear_field',
        default => 'default',
        lazy    => 1,
    );

    has weak_field => (
        is      => 'rw',
    );

    sub BUILD {
        my $self = shift;

        # fill some other slots in globref
        my $scalarref = ${*$self};
        $$scalarref = 'SCALAR';
        my $arrayref = \@{*$self};
        @$arrayref = ('ARRAY');

        return $self;
    };
};

1;
