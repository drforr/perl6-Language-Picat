# use Grammar::Debugger;
# no precompilation;
grammar Language::Picat::Grammar
  {
  token period { '.' }
  token comma { ',' }

  token module-name { \w+ }

  token function-name
    {
    '$'? \w+
    }

  token variable-name
    {
    | \w+ '[' \w+ ']'
    | \w+ [ '.' \w+ ]*
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

  rule array
    {
    '['
    <expression>* %% <comma>
    ']'
    }

  rule function-call
    {
    | <function-name> '(' <expression>+ %% <comma> ')'
    | <function-name>
    }

  token unsigned-number
    {
    | \d+ [ '.' \d+ [ <[ e E ]> \d+ ]? ]?
    }

  rule term
    {
    | <function-call>
    | <variable-name>
    | <array>
    | <unsigned-number>
    | <parentheses-expression>
    }

  rule expression
    {
    | <variable-name> ':=' <expression>
    | <variable-name> '=' <expression>
    | <exponent-expression>
    | <term>
    }

  rule parentheses-expression
    {
    '('
    <expression>?
    ')'
    }

  rule exponent-expression
    {
    | <multiply-expression> [ '**' <multiply-expression> ]*
    }

  rule multiply-expression
    {
    | <add-expression> [ [ '*' | '/' ] <add-expression> ]*
    }

  rule add-expression
    {
    | <bitwise-expression> [ [ '+' | '-' ] <bitwise-expression> ]*
    }

  rule bitwise-expression
    {
    | <logic-expression> [ [ '^' | '&' | '|' ] <logic-expression> ]*
    }

  rule logic-expression
    {
    | <term> [ [ '==' | '<=' | '>=' | '<' | '>' ] <expression> ]*
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
    ^ <comment>* <import-declaration>? <comment>* <program-body> $
    }

  rule program-body
    {
      [
<function-definition>

<function-definition>

<comment>
<function-call> '=>'
   <thingie>
   'foreach(I in 1..N)' <thingie> 'end' <comma>
   'foreach(I in 1..N)'
     'foreach(J in I..I..N)'
        <thingie>
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
   'writeln([I : I in 1..' <variable-name> ',' <expression> '])'
<period>
  
<comment>
<function-call> '=>'
  'foreach(I in 1..N)'
     <thingie>
     <thingie>
  'end' <comma>
  <thingie>
<period>

<comment>
<function-call> '=>'
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
      'time(' <variable-name> '=' <expression>  ')' <comma>
      <thingie>
      <thingie>
   'end'
<period>

<function-definition>

<function-definition>

<function-definition>

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
