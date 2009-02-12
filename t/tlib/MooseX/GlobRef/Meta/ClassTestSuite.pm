package MooseX::GlobRef::Meta::ClassTestSuite;

use Test::Unit::Lite;
use parent 'Test::Unit::TestSuite';

sub suite {
    my $class = shift;

    my $suite_name = __PACKAGE__;
    $suite_name =~ s/.*://;

    my $simple_test_name = __PACKAGE__;
    $simple_test_name =~ s/Suite$//;

    my $immutable_test_name = __PACKAGE__;
    $immutable_test_name =~ s/TestSuite$/ImmutableTest/;

    my $suite = Test::Unit::TestSuite->empty_new($suite_name);
    $suite->add_test($simple_test_name);
    $suite->add_test($immutable_test_name);
    return $suite;
};

1;
