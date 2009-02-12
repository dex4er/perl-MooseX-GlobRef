package MooseX::GlobRef::Meta::ClassTest;

use parent 'MooseX::GlobRef::ObjectBaseTest';

use constant test_class => (__PACKAGE__ . '::TestClass');

{
    package MooseX::GlobRef::Meta::ClassTest::TestClass;

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
};

1;
