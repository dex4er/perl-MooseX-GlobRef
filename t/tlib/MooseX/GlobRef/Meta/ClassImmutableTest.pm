package MooseX::GlobRef::Meta::ClassImmutableTest;

use parent 'MooseX::GlobRef::ObjectBaseTest';

use constant test_class => (__PACKAGE__ . '::TestClass');

{
    package MooseX::GlobRef::Meta::ClassImmutableTest::TestClass;

    use metaclass 'MooseX::GlobRef::Meta::Class';

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

    __PACKAGE__->meta->make_immutable;
};

1;
