package MooseX::GlobRef::ObjectTestSuite;

use Test::Unit::Lite;
use parent 'Test::Unit::TestSuite';

sub suite {
    my $class = shift;
    my $suite = Test::Unit::TestSuite->empty_new('ExtendsObject');
    $suite->add_test('MooseX::GlobRef::ObjectTest');
    $suite->add_test('MooseX::GlobRef::ObjectImmutableTest');
    return $suite;
};

1;
