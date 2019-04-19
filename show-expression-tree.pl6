use v6;

use lib 'lib';
use Language::Picat::Grammar;
my $expression = 'I**2 <= N';

my $g = Language::Picat::Grammar.new;

my $parsed = $g.parse( $expression, :rule( 'expression' ) );
say $parsed;
