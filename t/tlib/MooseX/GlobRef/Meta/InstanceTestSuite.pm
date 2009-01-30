package MooseX::GlobRef::Meta::InstanceTestSuite;

use Test::Unit::Lite;
use parent 'Test::Unit::TestSuite';
    
sub suite {
    my $class = shift;
    my $suite = Test::Unit::TestSuite->empty_new('MetaclassInstance');
    $suite->add_test('MooseX::GlobRef::Meta::InstanceTest');
    $suite->add_test('MooseX::GlobRef::Meta::InstanceImmutableTest');
    return $suite;
};

1;
