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
      <statement>+ %% ','
    <period>
    }

  rule array
    {
    '['
    <argument>+ %% ','
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
    | <function-name> '(' <argument>+ %% ',' ')'
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
    | <comment>
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
   <statement> ','
   'foreach(I in 1..N)' 'Doors[I] := 0' 'end' ','
   'foreach(I in 1..N)'
     'foreach(J in I..I..N)'
        'Doors[J] := 1^Doors[J]'
     'end' ','
     'if N <= 10 then'
        <statement>
     'end'
   'end' ','
   <statement> ','
   <statement> ','
   <statement>
<period>

<function-call> '=>'
   'writeln([I : I in 1..Doors.length, Doors[I] == 1])'
<period>
  
<comment>
<function-call> '=>'
  'foreach(I in 1..N)'
     <statement> ','
     'writeln([I, cond(' <variable-name> '== 1.0*' <function-call> ', open, closed)])'
  'end' ','
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
   <statement> ','
   <statement> ','
   <statement> ','
   <statement> ','
   'write(' <statement> ')' ','
   <statement>
<period>

<function-name> '=>'
   'foreach(Len in 1..15)'
      <statement> ','
      'write(' <statement> ')' ','
      <statement> ','
      <statement> ','
      'time(' <variable-name> '=' 'findall(L, $plan(L)))' ','
      <statement>
      'writeln(' <variable-name> '=' 'All.length'')'
   'end'
<period>

<function-name> '=>'
  <statement> ','
  <variable-name> '=' 'findall(L,$plan(L))' ','
  <statement> ','
  'writeln(' <variable-name> '=' 'All.length' ')' ','
  <statement>
<period>

<function-name> '=>'
   <statement> ','
   'time(' <function-call> ')' ','
   <statement> ','
   <statement> ','
   'writeln(' <variable-name> '=' 'L.length' ')' ','
   'writeln(' <statement> ')' ','
   <statement>
<period>

<function-name> '=>'
   <statement> ','
   'time(plan3(Init,L,Cost,[]))' ','
   <statement> ','
   <statement> ','
   'writeln(' <variable-name> '=' 'L.length' ')' ','
   'writeln(' <statement> ')' ','
   <statement>
<period>

<statement>+

'index(-)'
<statement>
'initial_state(' <array> ')' <period>
<statement>+

'table'
'legal_move(' <array> ',M,To)' '?=>'
   <statement> ','
   <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <statement> ','
   <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
  <statement> ','
  <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <statement> ','
   <variable-name> '=' <array>
<period>
<comment>
<function-name> '(' <array> ',M,To)' '=>'
  <statement> ','
  <variable-name> '=' <array>
<period>
<comment>

<function-call> '=>'
  <variable-name> '=' <array>
<period>

<comment>+
'table'
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
<period>
<comment>
<function-name> '(' <array> ',M,To,Cost)' '=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
<period>
<comment>+

      ]
    }
  }
