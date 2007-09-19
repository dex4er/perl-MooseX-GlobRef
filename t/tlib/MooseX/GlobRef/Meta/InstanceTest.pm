package MooseX::GlobRef::Meta::InstanceTest;

use base 'Test::Unit::TestCase';

use Scalar::Util;


package MooseX::GlobRef::Meta::InstanceTest::Test1;

use metaclass 'Moose::Meta::Class' =>
    instance_metaclass => 'MooseX::GlobRef::Meta::Instance';

use Moose;

has field => ( is => 'rw' );


package MooseX::GlobRef::Meta::InstanceTest;

sub test_MooseX_GlobRef_Meta_Instance___isa {
    my $self = shift;
    my $obj = MooseX::GlobRef::Meta::InstanceTest::Test1->new;
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::Meta::InstanceTest::Test1'));
    $self->assert_equals('GLOB', Scalar::Util::reftype($obj));
    $self->assert_equals('HASH', Scalar::Util::reftype(${*$obj}));
}

sub test_MooseX_GlobRef_Meta_Instance_accessor {
    my $self = shift;
    my $obj = MooseX::GlobRef::Meta::InstanceTest::Test1->new(field => $$);
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::Meta::InstanceTest::Test1'));
    $self->assert_equals($$, $obj->field);
    $self->assert_equals(1, $obj->field(1));
    $self->assert_equals(1, $obj->field);
}

1;
