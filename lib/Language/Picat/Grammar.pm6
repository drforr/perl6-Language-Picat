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

  rule assignment-statement
    {
    <variable-name> '=' <function-call>
    }

  rule statement
    {
    | <assignment-statement>
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
   <statement> '.'

<function-call> '=>' 'writeln([I : I in 1..Doors.length, Doors[I] == 1])' '.'
  
<statement>
<function-call> '=>'
  'foreach(I in 1..N)'
     <statement> ','
     'writeln([I, cond(' <variable-name> '== 1.0*' <function-call> ', open, closed)])'
  'end' ','
  <statement> '.'

<statement>
<function-call> '=>'
  'writeln([I**2 : I in 1..N, I**2 <= N])' '.'

    ||

<function-definition>

<function-name> '=>'
   <statement>
   'time(' <function-call> ')' ','
   <statement> ','
   <statement> ','
   <statement> ','
   'write(' <variable-name> '=' 'Len)' ',' <statement> '.'

<function-name> '=>'
   'foreach(Len in 1..15)'
      <statement> ','
      'write(' <variable-name> '=' 'Len),' <statement> ','
      <statement> ','
      'time(' <variable-name> '=' 'findall(L, $plan(L)))' ','
      <statement>
      'writeln(' <variable-name> '=' 'All.length)'
   'end' '.'

<function-name> '=>'
  <statement> ','
  <variable-name> '=' 'findall(L,$plan(L))' ','
  <statement> ','
  'writeln(' <variable-name> '=' 'All.length)' ','
  <statement> '.'

<function-name> '=>'
   <statement> ','
   'time(' <function-call> ')' ','
   <statement> ',' <statement> ','
   'writeln(' <variable-name> '=' 'L.length)' ','
   'writeln(' <variable-name> '=' 'Cost)' ','
   <statement> '.'

<function-name> '=>'
   <statement> ','
   'time(plan3(Init,L,Cost,[]))' ','
   <statement> ',' <statement> ','
   'writeln(' <variable-name> '=' 'L.length)' ','
   'writeln(' <variable-name> '=' 'Cost)' ','
   <statement> '.'

<statement>+

'index(-)'
<statement>
'initial_state([2,4,1,7,5,3,8,6])' '.' <statement>+

'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To)' '?=>' <variable-name> '=' '1,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To)' '?=>' <variable-name> '=' '2,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To)' '?=>' <variable-name> '=' '3,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To)' '?=>' <variable-name> '=' '4,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
<function-name> '([M1,M2,M3,M4,M8,M7,M6,M5],M,To)' '=>' <variable-name> '=' '5,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>

<function-call> '=>' <variable-name> '= [1,2,3,4,5,6,7,8]' '.'

<statement>+
'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To,Cost)' '?=>' <variable-name> '=' '1,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8],' <variable-name> '=' '1' '.' <statement>
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To,Cost)' '?=>' <variable-name> '=' '2,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8],' <variable-name> '=' '1' '.' <statement>
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To,Cost)' '?=>' <variable-name> '=' '3,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8],' <variable-name> '=' '1' '.' <statement>
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To,Cost)' '?=>' <variable-name> '=' '4,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8],' <variable-name> '=' '1' '.' <statement>
<function-name> '([M1,M2,M3,M4,M8,M7,M6,M5],M,To,Cost)' '=>' <variable-name> '=' '5,' <variable-name> '=' '[M1,M2,M3,M4,M5,M6,M7,M8],' <variable-name> '=' '1' '.' <statement>

<statement>+

      ]
    }
  }
