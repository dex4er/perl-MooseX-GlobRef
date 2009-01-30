package MooseX::GlobRef::Meta::ClassTestSuite;

use Test::Unit::Lite;
use parent 'Test::Unit::TestSuite';
    
sub suite {
    my $class = shift;
    my $suite = Test::Unit::TestSuite->empty_new('Metaclass');
    $suite->add_test('MooseX::GlobRef::Meta::ClassTest');
    $suite->add_test('MooseX::GlobRef::Meta::ClassImmutableTest');
    return $suite;
};

1;
