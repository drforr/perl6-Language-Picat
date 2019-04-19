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
    <function-call> '=>'
      <thingie>+
    <period>
    }

  rule fact-definition
    {
    <function-call> '?=>'
      <thingie>+
    <period>
    }

#  rule array
#    {
#    '['
#    <argument>+ %% <comma>
#    ']'
#    }

  rule array
    {
    '['
    <expression>+ %% <comma>
    ']'
    }

  rule function-call
    {
    | <function-name> '(' <expression>+ %% <comma> ')'
    | <function-name>
    }

  rule term
    {
    | <variable-name>
    | \d+
    }

  rule math-expression
    {
    | <variable-name> '**' <term> '<=' <expression>
    | <comparison-expression>
    }

  rule comparison-expression
    {
    <variable-name> '<=' <expression>
    }

  rule expression
    {
    | <math-expression>
    | <variable-name> '=' <expression>
    | <function-call>
    | <array>
    | <variable-name>
    | \d+
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
     'if' <expression> 'then'
       <thingie>
     'end'
   'end' <comma>
   <thingie>
   <thingie>
   <thingie>
<period>

<function-call> '=>'
   'writeln([I : I in 1..Doors.length,' <variable-name> '==' '1' '])'
<period>
  
<comment>
<function-call> '=>'
  'foreach(I in 1..N)'
     <thingie>
     'writeln([I, cond(' <variable-name> '==' '1.0' '*' <function-call> ', open, closed)])'
  'end' <comma>
  <thingie>
<period>

<comment>
<function-call> '=>'
  #'writeln([I**2 : I in 1..N, I**2 <= N])'
  'writeln([I**2 : I in 1..N,' <expression> '])'
<period>

    ||

<function-definition>

<function-definition>

<function-name> '=>'
   'foreach(Len in 1..15)'
      <thingie>
      <thingie>
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
   <thingie>
   #'time(' <function-call> ')' <comma>
   <thingie>
   <thingie>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   <thingie>
   <thingie>
<period>

<function-name> '=>'
   <thingie>
   'time(plan3(Init,L,Cost,[]))' <comma>
   <thingie>
   <thingie>
   'writeln(' <variable-name> '=' 'L.length' ')' <comma>
   <thingie>
   <thingie>
<period>

<comment>+

'index(-)'
<comment>
<function-call> <period>
<comment>+

'table'
<fact-definition>
<comment>
<fact-definition>
<comment>
<fact-definition>
<comment>
<fact-definition>
<comment>
<function-definition>
<comment>

<function-definition>

<comment>+
'table'
<fact-definition>
<comment>
<fact-definition>
<comment>
<fact-definition>
<comment>
<fact-definition>
<comment>
<function-definition>
<comment>+

      ]
    }
  }
