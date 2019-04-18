# use Grammar::Tracer;
# no precompilation;
grammar Language::Picat::Grammar
  {
  token period { '.' }
  token comma { ',' }

  token module-name
    {
    \w+
    }
  token function-name
    {
    \w+
    }
  token variable-name
    {
    \w+
    }

  rule import-declaration
    {
    'import' <module-name> <period>
    }
  token comment
    {
    | '/*' .*? '*/' \s*
    | '%' .*? $$ \s*
    }

  rule function-definition
    {
    <function-name> '=>'
      <statement>+ %% <comma>
    <period>
    }

  rule array
    {
    '['
    <argument>+ %% <comma>
    ']'
    }

  rule argument
    {
    | <function-call>
    | \w+
    | \d+
    }

  rule function-call
    {
    | <function-name> '(' <argument>+ %% <comma> ')'
    | <function-name>
    }

  rule assignment-expression
    {
    <variable-name> '=' <function-call>
    }

  rule statement
    {
    | <assignment-expression>
    | <function-call>
#    | <comment>
    }

  rule TOP
    {
    ^ <comment>* <import-declaration>? <program-body> $
    }

  rule program-body
    {
      [
      <statement>+

<function-definition>

<function-definition>

<comment>
<function-call> '=>'
   <statement> <comma>
   'foreach(I in 1..N)' 'Doors[I] := 0' 'end' <comma>
   'foreach(I in 1..N)'
     'foreach(J in I..I..N)'
        'Doors[J] := 1^Doors[J]'
     'end' <comma>
     'if N <= 10 then'
        <statement>
     'end'
   'end' <comma>
   <statement> <comma>
   <statement> <comma>
   <statement>
<period>

<function-call> '=>'
   'writeln([I : I in 1..Doors.length, Doors[I] == 1])'
<period>
  
<comment>
<function-call> '=>'
  'foreach(I in 1..N)'
     <statement> <comma>
     'writeln([I, cond(' <variable-name> '== 1.0*' <function-call> ', open, closed)])'
  'end' <comma>
  <statement>
<period>

<comment>
<function-call> '=>'
  'writeln([I**2 : I in 1..N, I**2 <= N])'
<period>

    ||

<function-definition>

<function-name> '=>'
   <comment>
   <statement> <comma>
   <statement> <comma>
   <statement> <comma>
   <statement> <comma>
   'write(' <statement> ')' <comma>
   <statement>
<period>

<function-name> '=>'
   'foreach(Len in 1..15)'
      <statement> <comma>
      'write(' <statement> ')' <comma>
      <statement> <comma>
      <statement> <comma>
      'time(' <variable-name> '=' 'findall(L, $plan(L)))' <comma>
      <comment>
      'writeln(' <variable-name> '=' 'All.length'')'
   'end'
<period>

<function-name> '=>'
  <statement> <comma>
  <variable-name> '=' 'findall(L,$plan(L))' <comma>
  <statement> <comma>
  'writeln(' <variable-name> '=' 'All.length' ')' <comma>
  <statement>
<period>

<function-name> '=>'
   <statement> <comma>
   'time(' <function-call> ')' <comma>
   <statement> <comma>
   <statement> <comma>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   'writeln(' <statement> ')' <comma>
   <statement>
<period>

<function-name> '=>'
   <statement> <comma>
   'time(plan3(Init,L,Cost,[]))' <comma>
   <statement> <comma>
   <statement> <comma>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   'writeln(' <statement> ')' <comma>
   <statement>
<period>

<statement>+

'index(-)'
<statement>
'initial_state(' <array> ')' <period>
<statement>+

'table'
'legal_move(' <array> ',M,To)' '?=>'
   <statement> <comma>
   <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <statement> <comma>
   <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
  <statement> <comma>
  <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <statement> <comma>
   <variable-name> '=' <array>
<period>
<comment>
<function-name> '(' <array> ',M,To)' '=>'
  <statement> <comma>
  <variable-name> '=' <array>
<period>
<comment>

<function-call> '=>'
  <variable-name> '=' <array>
<period>

<comment>+
'table'
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> <comma>
  <variable-name> '=' <array> <comma>
  <statement>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> <comma>
  <variable-name> '=' <array> <comma>
  <statement>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> <comma>
  <variable-name> '=' <array> <comma>
  <statement>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> <comma>
  <variable-name> '=' <array> <comma>
  <statement>
<period>
<comment>
<function-name> '(' <array> ',M,To,Cost)' '=>'
  <statement> <comma>
  <variable-name> '=' <array> <comma>
  <statement>
<period>
<comment>+

      ]
    }
  }
