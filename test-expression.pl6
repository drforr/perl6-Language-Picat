use v6;

use lib 'lib';
use Test;

grammar Language::Picat::Grammar
  {
  token unsigned-number
    {
    | \d+ [ '.' \d+ [ <[ e E ]> \d+ ]? ]?
    }

  token variable-name { \w+ }
  token method-name { \w+ }

  token term
    {
    | '[' <expression>* %% ',' ']'
    | <variable-name> '.' <method-name>
    | <variable-name>
    | <unsigned-number>
    }

  rule parentheses-expression
    {
    | '(' <expression> ')'
    | <term>
    }

  rule expression
    {
    | <parentheses-expression>
    | <term>
    }

  rule everything
    {
    ^ <expression> $
    }
  }

my $g = Language::Picat::Grammar.new;

sub parse( Str $str )
  {
  $g.parse( $str, :rule( 'everything' ) );
  }

# Don't consider 'Doors = new_array(...)' an expression for the moment.
#
subtest 'single term', {
  subtest 'failing', {
    ok !parse( 'L.' );
    ok !parse( '[' );
    ok !parse( ']' );
    ok !parse( '[foo' );
    ok !parse( 'foo]' );
  };

  ok parse( '0' );
  ok parse( 'Cost' );
  ok parse( 'L.length' );
  ok parse( '[2,4,2,7,5,3,8,6]' );
  ok parse( '[M2,M4,M2,M7,M5,M3,M8,M6]' );
};

subtest 'parentheses', {
  subtest 'failing', {
    ok !parse( '(10' );
    ok !parse( '10)' );
    ok !parse( '((10)' );
    ok !parse( '(10))' );
  };

  ok parse( '(10)' );
  ok parse( '((10))' );
  ok parse( '([(10)])' );
  ok parse( '[10,(10),((10))]' );
};

ok parse( 'doors(10)' );
ok parse( '1^Doors[J]' );
ok parse( 'N <= 10' );
ok parse( 'Doors[I] == 1' );
ok parse( '1.0*round(Root)' );
ok parse( '1.0+round(Root)' );
ok parse( 'I**2 <= N' );
ok parse( '(L+1)*2' );
