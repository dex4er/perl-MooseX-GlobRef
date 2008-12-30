package MooseX::GlobRef::Meta::InstanceTestSuite;

use parent 'Test::Unit::TestSuite';

use Test::Unit::Lite;
    
sub suite {
    my $class = shift;
    my $suite = Test::Unit::TestSuite->empty_new('MetaclassInstance');
    $suite->add_test('MooseX::GlobRef::Meta::InstanceTest');
    $suite->add_test('MooseX::GlobRef::Meta::InstanceImmutableTest');
    return $suite;
};

1;
