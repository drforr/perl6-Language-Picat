use v6;

use Test;
use Language::Picat::Grammar;

#my @files = dir( './corpus', test => /^<![ . ]> .+ \.pi/ );
my @files = dir( './corpus-passed', test => /^<![ . ]> .+ \.pi/ );

plan @files.elems;

my $g = Language::Picat::Grammar.new;

for @files.sort -> $filename {
  my $parsed = $g.parse( $filename.slurp );
  ok $parsed, "Can parse '$filename'";
}

done-testing;
