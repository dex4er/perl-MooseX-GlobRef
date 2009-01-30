package MooseX::GlobRef::ObjectTest;

use Test::Unit::Lite;
use parent 'Test::Unit::TestCase';

use Test::Assert ':all';

use Scalar::Util 'reftype';


{
    package MooseX::GlobRef::ObjectTest::Test1;

    use Moose;

    extends 'MooseX::GlobRef::Object';

    has field => (
        is      => 'rw',
        clearer => 'clear_field',
        default => 'default',
        lazy    => 1,
    );

    has weak_field => (
        is      => 'rw',
    );

    sub new {
        my $class = shift;
        my $self = $class->SUPER::new(@_);
        my $scalarref = ${*$self};
        $$scalarref = 'SCALAR';
        my $arrayref = \@{*$self}; 
        @$arrayref = ('ARRAY'); 
        return $self;
    }; 
};


sub test___isa {
    my $self = shift;
    my $obj = MooseX::GlobRef::ObjectTest::Test1->new;
    assert_not_null($obj);
    assert_true($obj->isa('MooseX::GlobRef::ObjectTest::Test1'));
    assert_equals('GLOB', reftype($obj));
};

sub test_accessor {
    my $self = shift;
    my $obj = MooseX::GlobRef::ObjectTest::Test1->new;
    assert_not_null($obj);
    assert_true($obj->isa('MooseX::GlobRef::ObjectTest::Test1'));
    assert_equals('default', $obj->field);
    assert_equals(1, $obj->field(1));
    assert_equals(1, $obj->field);
    assert_true($obj->clear_field);
    assert_equals('default', $obj->field);
};

sub test_slot_moc {
    my $self = shift;
    my $mi = MooseX::GlobRef::ObjectTest::Test1->meta->get_meta_instance;
    assert_not_null($mi);

    my $obj = $mi->create_instance;
    assert_not_null($obj);
    assert_true($obj->isa('MooseX::GlobRef::ObjectTest::Test1'));
    assert_null($mi->get_slot_value($obj, 'field'));
    assert_true(! $mi->is_slot_initialized($obj, 'field'));
    assert_equals(1, $mi->set_slot_value($obj, 'field', 1));
    assert_equals(1, $mi->get_slot_value($obj, 'field'));
    assert_true($mi->is_slot_initialized($obj, 'field'));
    assert_true($mi->deinitialize_slot($obj, 'field'));
    assert_null($mi->get_slot_value($obj, 'field'));
    assert_true(! $mi->is_slot_initialized($obj, 'field'));
};

sub test_slot_moc_inline {
    my $self = shift;
    my $mi = MooseX::GlobRef::ObjectTest::Test1->meta->get_meta_instance;
    assert_not_null($mi);

    my $code_create_instance = $mi->inline_create_instance('$class');
    assert_not_equals('', $code_create_instance);
    my $code_get_slot_value = $mi->inline_get_slot_value('$obj', 'field');
    assert_not_equals('', $code_get_slot_value);
    my $code_is_slot_initialized = $mi->inline_is_slot_initialized('$obj', 'field');
    assert_not_equals('', $code_is_slot_initialized);
    my $code_set_slot_value = $mi->inline_set_slot_value('$obj', 'field', '$value');
    assert_not_equals('', $code_set_slot_value);
    my $code_deinitialize_slot = $mi->inline_deinitialize_slot('$obj', 'field');
    assert_not_equals('', $code_deinitialize_slot);

    my $obj = eval "my \$class = 'MooseX::GlobRef::ObjectTest::Test1'; $code_create_instance;";
    assert_not_null($obj);
    assert_true($obj->isa('MooseX::GlobRef::ObjectTest::Test1'));
    assert_null(eval $code_get_slot_value);
    assert_true(! eval $code_is_slot_initialized);
    assert_equals(1, eval "my \$value = 1; $code_set_slot_value;");
    assert_equals(1, eval $code_get_slot_value);
    assert_true(eval $code_is_slot_initialized);
    assert_true(eval $code_deinitialize_slot);
    assert_null(eval $code_get_slot_value);
    assert_true(! eval $code_is_slot_initialized);
};

sub test_weak_field {
    my $self = shift;
    my $mi = MooseX::GlobRef::ObjectTest::Test1->meta->get_meta_instance;
    assert_not_null($mi);
    my $obj = MooseX::GlobRef::ObjectTest::Test1->new;
    assert_not_null($obj);
    assert_true($obj->isa('MooseX::GlobRef::ObjectTest::Test1'));
    assert_null($obj->weak_field);
    {
	my $scalar = 'SCALAR';
	assert_not_null($obj->weak_field(\$scalar));
	assert_not_null($obj->weak_field);
	assert_equals('SCALAR', ${$obj->weak_field});
	$mi->weaken_slot_value($obj, 'weak_field');
    };
    assert_null($obj->weak_field);
};

1;
