package MooseX::GlobRef::Meta::Class::Trait::GlobRefTestSuite;

use parent 'Test::Unit::TestSuite';

use Test::Unit::Lite;
    
sub suite {
    my $class = shift;
    my $suite = Test::Unit::TestSuite->empty_new('ClassTrait');
    $suite->add_test('MooseX::GlobRef::Meta::Class::Trait::GlobRefTest');
    $suite->add_test('MooseX::GlobRef::Meta::Class::Trait::GlobRefImmutableTest');
    return $suite;
};

1;
