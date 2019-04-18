# use Grammar::Tracer;
# no precompilation;
grammar Language::Picat::Grammar
  {
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
    'import' <module-name> '.'
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
    '.'
    }

  rule array
    {
    '['
    <argument>+ %% ','
    ']'
    }

  rule argument
    {
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

<statement>
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
'.'

<function-call> '=>'
   'writeln([I : I in 1..Doors.length, Doors[I] == 1])'
'.'
  
<statement>
<function-call> '=>'
  'foreach(I in 1..N)'
     <statement> ','
     'writeln([I, cond(' <variable-name> '== 1.0*' <function-call> ', open, closed)])'
  'end' ','
  <statement>
'.'

<statement>
<function-call> '=>'
  'writeln([I**2 : I in 1..N, I**2 <= N])'
'.'

    ||

<function-definition>

<function-name> '=>'
   <statement>
   'time(' <function-call> ')' ','
   <statement> ','
   <statement> ','
   <statement> ','
   'write(' <statement> ')' ','
   <statement>
'.'

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
'.'

<function-name> '=>'
  <statement> ','
  <variable-name> '=' 'findall(L,$plan(L))' ','
  <statement> ','
  'writeln(' <variable-name> '=' 'All.length' ')' ','
  <statement>
'.'

<function-name> '=>'
   <statement> ','
   'time(' <function-call> ')' ','
   <statement> ','
   <statement> ','
   'writeln(' <variable-name> '=' 'L.length' ')' ','
   'writeln(' <statement> ')' ','
   <statement>
'.'

<function-name> '=>'
   <statement> ','
   'time(plan3(Init,L,Cost,[]))' ','
   <statement> ','
   <statement> ','
   'writeln(' <variable-name> '=' 'L.length' ')' ','
   'writeln(' <statement> ')' ','
   <statement>
'.'

<statement>+

'index(-)'
<statement>
'initial_state(' <array> ')' '.'
 <statement>+

'table'
'legal_move(' <array> ',M,To)' '?=>'
   <statement> ','
   <variable-name> '=' <array>
'.'
 <statement>
'legal_move(' <array> ',M,To)' '?=>'
   <statement> ','
   <variable-name> '=' <array>
'.'
<statement>
'legal_move(' <array> ',M,To)' '?=>'
  <statement> ','
  <variable-name> '=' <array>
'.'
<statement>
'legal_move(' <array> ',M,To)' '?=>'
   <statement> ','
   <variable-name> '=' <array>
'.'
<statement>
<function-name> '(' <array> ',M,To)' '=>'
  <statement> ','
  <variable-name> '=' <array>
'.'
<statement>

<function-call> '=>'
  <variable-name> '=' <array>
'.'

<statement>+
'table'
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
'.'
 <statement>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
'.'
 <statement>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
'.'
 <statement>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
'.'
 <statement>
<function-name> '(' <array> ',M,To,Cost)' '=>'
  <statement> ','
  <variable-name> '=' <array> ','
  <statement>
'.'
<statement>+

      ]
    }
  }
