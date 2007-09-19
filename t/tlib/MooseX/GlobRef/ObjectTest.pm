package MooseX::GlobRef::ObjectTest;

use base 'Test::Unit::TestCase';

use Scalar::Util;


package MooseX::GlobRef::ObjectTest::Test1;

use Moose;

extends 'MooseX::GlobRef::Object';

has field => ( is => 'rw' );


package MooseX::GlobRef::ObjectTest;

sub test_MooseX_GlobRef_Object___isa {
    my $self = shift;
    my $obj = MooseX::GlobRef::ObjectTest::Test1->new;
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::ObjectTest::Test1'));
    $self->assert_equals('GLOB', Scalar::Util::reftype($obj));
    $self->assert_equals('HASH', Scalar::Util::reftype(${*$obj}));
}

sub test_MooseX_GlobRef_Object_accessor {
    my $self = shift;
    my $obj = MooseX::GlobRef::ObjectTest::Test1->new(field => $$);
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::ObjectTest::Test1'));
    $self->assert_equals($$, $obj->field);
    $self->assert_equals(1, $obj->field(1));
    $self->assert_equals(1, $obj->field);
}

1;
