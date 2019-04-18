# use Grammar::Debugger;
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
      <expression>+ %% <comma>
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

  rule expression
    {
    | <assignment-expression>
    | <function-call>
    }

  rule TOP
    {
    ^ <comment>* <import-declaration>? <program-body> $
    }

  rule program-body
    {
      [
      <comment>+

<function-definition>

<function-definition>

<comment>
<function-call> '=>'
   <expression> <comma>
   'foreach(I in 1..N)' 'Doors[I] := 0' 'end' <comma>
   'foreach(I in 1..N)'
     'foreach(J in I..I..N)'
        'Doors[J] := 1^Doors[J]'
     'end' <comma>
     'if N <= 10 then'
        <expression>
     'end'
   'end' <comma>
   <expression> <comma>
   <expression> <comma>
   <expression>
<period>

<function-call> '=>'
   'writeln([I : I in 1..Doors.length, Doors[I] == 1])'
<period>
  
<comment>
<function-call> '=>'
  'foreach(I in 1..N)'
     <expression> <comma>
     'writeln([I, cond(' <variable-name> '== 1.0*' <function-call> ', open, closed)])'
  'end' <comma>
  <expression>
<period>

<comment>
<function-call> '=>'
  'writeln([I**2 : I in 1..N, I**2 <= N])'
<period>

    ||

<function-definition>

<function-name> '=>'
   <comment>
   <expression> <comma>
   <expression> <comma>
   <expression> <comma>
   <expression> <comma>
   'write(' <expression> ')' <comma>
   <expression>
<period>

<function-name> '=>'
   'foreach(Len in 1..15)'
      <expression> <comma>
      'write(' <expression> ')' <comma>
      <expression> <comma>
      <expression> <comma>
      'time(' <variable-name> '=' 'findall(L, $plan(L)))' <comma>
      <comment>
      'writeln(' <variable-name> '=' 'All.length'')'
   'end'
<period>

<function-name> '=>'
  <expression> <comma>
  <variable-name> '=' 'findall(L,$plan(L))' <comma>
  <expression> <comma>
  'writeln(' <variable-name> '=' 'All.length' ')' <comma>
  <expression>
<period>

<function-name> '=>'
   <expression> <comma>
   'time(' <function-call> ')' <comma>
   <expression> <comma>
   <expression> <comma>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   'writeln(' <expression> ')' <comma>
   <expression>
<period>

<function-name> '=>'
   <expression> <comma>
   'time(plan3(Init,L,Cost,[]))' <comma>
   <expression> <comma>
   <expression> <comma>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   'writeln(' <expression> ')' <comma>
   <expression>
<period>

<comment>+

'index(-)'
<comment>
'initial_state(' <array> ')' <period>
<comment>+

'table'
'legal_move(' <array> ',M,To)' '?=>'
   <expression> <comma>
   <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <expression> <comma>
   <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
  <expression> <comma>
  <variable-name> '=' <array>
<period>
<comment>
'legal_move(' <array> ',M,To)' '?=>'
   <expression> <comma>
   <variable-name> '=' <array>
<period>
<comment>
<function-name> '(' <array> ',M,To)' '=>'
  <expression> <comma>
  <variable-name> '=' <array>
<period>
<comment>

<function-call> '=>'
  <variable-name> '=' <array>
<period>

<comment>+
'table'
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <expression> <comma>
  <variable-name> '=' <array> <comma>
  <expression>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <expression> <comma>
  <variable-name> '=' <array> <comma>
  <expression>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <expression> <comma>
  <variable-name> '=' <array> <comma>
  <expression>
<period>
<comment>
'legal_move(' <array> ',M,To,Cost)' '?=>'
  <expression> <comma>
  <variable-name> '=' <array> <comma>
  <expression>
<period>
<comment>
<function-name> '(' <array> ',M,To,Cost)' '=>'
  <expression> <comma>
  <variable-name> '=' <array> <comma>
  <expression>
<period>
<comment>+

      ]
    }
  }
