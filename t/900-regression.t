use v6;

use Test;
use Language::Picat::Grammar;

plan 1;

my $g = Language::Picat::Grammar.new;

ok $g.parse( '/**/' );
ok $g.parse( 'function (N) => foo.' );

done-testing;
