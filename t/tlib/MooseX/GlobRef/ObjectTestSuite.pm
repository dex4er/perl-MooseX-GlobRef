package MooseX::GlobRef::ObjectTestSuite;

use parent 'Test::Unit::TestSuite';

use Test::Unit::Lite;
    
sub suite {
    my $class = shift;
    my $suite = Test::Unit::TestSuite->empty_new('ExtendsObject');
    $suite->add_test('MooseX::GlobRef::ObjectTest');
    $suite->add_test('MooseX::GlobRef::ObjectImmutableTest');
    return $suite;
};

1;
