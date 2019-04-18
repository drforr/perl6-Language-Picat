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
    | \w+ '[' \w+ ']'
    | \w+
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
      <thingie>+
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
    | <array>
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
    <variable-name> '=' <argument>
    }

  rule expression
    {
    | <assignment-expression>
    | <function-call>
    }

  rule thingie
    {
      [
      | <expression> <comment>?
      |              <comment>
      ]
      <comma>?
      <comment>*
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
   <thingie>
   'foreach(I in 1..N)' <variable-name> ':= 0' 'end' <comma>
   'foreach(I in 1..N)'
     'foreach(J in I..I..N)'
        <variable-name> ':= 1^' <variable-name>
     'end' <comma>
     'if N <= 10 then'
       <thingie>
     'end'
   'end' <comma>
   <thingie>
   <thingie>
   <thingie>
<period>

<function-call> '=>'
   'writeln([I : I in 1..Doors.length,' <variable-name> '== 1])'
<period>
  
<comment>
<function-call> '=>'
  'foreach(I in 1..N)'
     <thingie>
     'writeln([I, cond(' <variable-name> '== 1.0*' <function-call> ', open, closed)])'
  'end' <comma>
  <thingie>
<period>

<comment>
<function-call> '=>'
  'writeln([I**2 : I in 1..N, I**2 <= N])'
<period>

    ||

<function-definition>

<function-name> '=>'
   <thingie>
   <thingie>
   <thingie>
   <thingie>
   <thingie>
   'write(' <expression> ')' <comma>
   <thingie>
<period>

<function-name> '=>'
   'foreach(Len in 1..15)'
      <thingie>
      'write(' <expression> ')' <comma>
      <thingie>
      <thingie>
      'time(' <variable-name> '=' 'findall(L, $plan(L)))' <comma>
      <thingie>
      'writeln(' <variable-name> '=' 'All.length'')'
   'end'
<period>

<function-name> '=>'
  <thingie>
  <variable-name> '=' 'findall(L,$plan(L))' <comma>
  <thingie>
  'writeln(' <variable-name> '=' 'All.length' ')' <comma>
  <thingie>
<period>

<function-name> '=>'
   <thingie>
   'time(' <function-call> ')' <comma>
   <thingie>
   <thingie>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   'writeln(' <expression> ')' <comma>
   <thingie>
<period>

<function-name> '=>'
   <thingie>
   'time(plan3(Init,L,Cost,[]))' <comma>
   <thingie>
   <thingie>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   'writeln(' <expression> ')' <comma>
   <thingie>
<period>

<comment>+

'index(-)'
<comment>
<function-call> <period>
<comment>+

'table'
<function-call> '?=>'
   <thingie>
   <thingie>
<period>
<comment>
<function-call> '?=>'
   <thingie>
   <thingie>
<period>
<comment>
<function-call> '?=>'
   <thingie>
   <thingie>
<period>
<comment>
<function-call> '?=>'
   <thingie>
   <thingie>
<period>
<comment>
<function-call> '=>'
   <thingie>
   <thingie>
<period>
<comment>

<function-call> '=>'
   <thingie>
<period>

<comment>+
'table'
<function-call> '?=>'
  <thingie>
  <thingie>
  <thingie>
<period>
<comment>
<function-call> '?=>'
  <thingie>
  <thingie>
  <thingie>
<period>
<comment>
<function-call> '?=>'
  <thingie>
  <thingie>
  <thingie>
<period>
<comment>
<function-call> '?=>'
  <thingie>
  <thingie>
  <thingie>
<period>
<comment>
<function-definition>
<comment>+

      ]
    }
  }
