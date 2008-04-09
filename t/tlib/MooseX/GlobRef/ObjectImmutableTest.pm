package MooseX::GlobRef::ObjectImmutableTest;

use base 'Test::Unit::TestCase';

use Scalar::Util;


package MooseX::GlobRef::ObjectImmutableTest::Test1;

use Moose;

extends 'MooseX::GlobRef::Object';

has field =>
    is      => 'rw',
    clearer => 'clear_field',
    default => 'default',
    lazy    => 1;

has weak_field =>
    is      => 'rw';

__PACKAGE__->meta->make_immutable;


package MooseX::GlobRef::ObjectImmutableTest;

sub test_MooseX_GlobRef_Object___isa {
    my $self = shift;
    my $obj = MooseX::GlobRef::ObjectImmutableTest::Test1->new;
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::ObjectImmutableTest::Test1'));
    $self->assert_equals('GLOB', Scalar::Util::reftype($obj));
    $self->assert_equals('HASH', Scalar::Util::reftype(${*$obj}));
}

sub test_MooseX_GlobRef_Object__moose {
    my $self = shift;
    my $obj = MooseX::GlobRef::ObjectImmutableTest::Test1->new;
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::ObjectImmutableTest::Test1'));
    $self->assert_equals('default', $obj->field);
    $self->assert_equals(1, $obj->field(1));
    $self->assert_equals(1, $obj->field);
    $self->assert($obj->clear_field);
    $self->assert_equals('default', $obj->field);
}

sub test_MooseX_GlobRef_Object__moc {
    my $self = shift;
    my $mi = MooseX::GlobRef::ObjectImmutableTest::Test1->meta->get_meta_instance;
    $self->assert_not_null($mi);

    my $obj = $mi->create_instance;
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::ObjectImmutableTest::Test1'));
    $self->assert_null($mi->get_slot_value($obj, 'field'));
    $self->assert(! $mi->is_slot_initialized($obj, 'field'));
    $self->assert_equals(1, $mi->set_slot_value($obj, 'field', 1));
    $self->assert_equals(1, $mi->get_slot_value($obj, 'field'));
    $self->assert($mi->is_slot_initialized($obj, 'field'));
    $self->assert($mi->deinitialize_slot($obj, 'field'));
    $self->assert_null($mi->get_slot_value($obj, 'field'));
    $self->assert(! $mi->is_slot_initialized($obj, 'field'));
}

sub test_MooseX_GlobRef_Object__moc_inline {
    my $self = shift;
    my $mi = MooseX::GlobRef::ObjectImmutableTest::Test1->meta->get_meta_instance;
    $self->assert_not_null($mi);

    my $code_create_instance = $mi->inline_create_instance('$class');
    $self->assert_not_equals('', $code_create_instance);
    my $code_get_slot_value = $mi->inline_get_slot_value('$obj', 'field');
    $self->assert_not_equals('', $code_get_slot_value);
    my $code_is_slot_initialized = $mi->inline_is_slot_initialized('$obj', 'field');
    $self->assert_not_equals('', $code_is_slot_initialized);
    my $code_set_slot_value = $mi->inline_set_slot_value('$obj', 'field', '$value');
    $self->assert_not_equals('', $code_set_slot_value);
    my $code_deinitialize_slot = $mi->inline_deinitialize_slot('$obj', 'field');
    $self->assert_not_equals('', $code_deinitialize_slot);

    my $obj = eval "my \$class = 'MooseX::GlobRef::ObjectImmutableTest::Test1'; $code_create_instance;";
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::ObjectImmutableTest::Test1'));
    $self->assert_null(eval $code_get_slot_value);
    $self->assert(! eval $code_is_slot_initialized);
    $self->assert_equals(1, eval "my \$value = 1; $code_set_slot_value;");
    $self->assert_equals(1, eval $code_get_slot_value);
    $self->assert(eval $code_is_slot_initialized);
    $self->assert(eval $code_deinitialize_slot);
    $self->assert_null(eval $code_get_slot_value);
    $self->assert(! eval $code_is_slot_initialized);
}

sub test_MooseX_GlobRef_Object__weak {
    my $self = shift;
    my $mi = MooseX::GlobRef::ObjectImmutableTest::Test1->meta->get_meta_instance;
    $self->assert_not_null($mi);
    my $obj = MooseX::GlobRef::ObjectImmutableTest::Test1->new;
    $self->assert_not_null($obj);
    $self->assert($obj->isa('MooseX::GlobRef::ObjectImmutableTest::Test1'));
    $self->assert_null($obj->weak_field);
    {
	my $scalar = 'SCALAR';
	$self->assert_not_null($obj->weak_field(\$scalar));
	$self->assert_not_null($obj->weak_field);
	$self->assert_equals('SCALAR', ${$obj->weak_field});
	$mi->weaken_slot_value($obj, 'weak_field');
    }
    $self->assert_null($obj->weak_field);
}

1;
