use v6;

use lib 'lib';
use Test;
use Language::Picat::Grammar;

my $g = Language::Picat::Grammar.new;

sub parse( Str $str )
  {
  $g.parse( $str, :rule( 'new-expression' ) );
  }

# Don't consider 'Doors = new_array(...)' an expression for the moment.
#
ok parse( '0' );
ok parse( 'doors(10)' );
ok parse( '1^Doors[J]' );
ok parse( 'N <= 10' );
ok parse( 'Doors[I] == 1' );
ok parse( '1.0*round(Root)' );
ok parse( 'I**2 <= N' );
ok parse( 'Cost' );
ok parse( 'L.length' );
ok parse( '[2,4,2,7,5,3,8,6]' );
ok parse( '[M2,M4,M2,M7,M5,M3,M8,M6]' );
