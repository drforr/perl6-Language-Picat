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
      <comment>*
      <expression>+ %% [ <comment>* <comma> ]
      <comment>*
    <period>
    }

  rule fact-definition
    {
    <function-call> '?=>'
      <comment>*
      <expression>+ %% [ <comment>* <comma> ]
      <comment>*
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

  rule parentheses-expression
    {
    '(' <expression>? ')'
    }

  rule term
    {
    | <function-call>
    | <variable-name>
    | <array>
    | <unsigned-number>
    | <parentheses-expression>
    }

  rule binding
    {
    | <variable-name> ':=' <expression>
    }

  rule expression
    {
    | <assignment-expression>
    | <term>
    }

  rule assignment-expression
    {
    | <variable-name> '=' <expression>
    | <exponent-expression>
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
    | <logic-expression> [ [ '^' | '/\\' | '\\/' ] <logic-expression> ]*
    }

  rule logic-expression
    {
    | <term> [ [ '==' | '<=' | '>=' | '<' | '>' ] <expression> ]*
    }

  rule foreach
    {
    'foreach'
      '('
      <variable-name> 'in' <expression> [ '..' <expression> ]+
      ')'
      [ <statement> <comma> <comment>* ]*
      <statement> <comment>*
    'end'
    }

  rule statement
    {
    | <foreach>
    | <binding>
    | <expression>
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
   <statement> <comma> <comment>*
   <statement> <comma> <comment>*
   'foreach(I in 1..N)'
     <statement> <comma> <comment>*
     'if' <expression> 'then'
       <statement> <comment>*
     'end'
   'end' <comma>
   <statement> <comma> <comment>*
   <statement> <comma> <comment>*
   <statement> <comment>* # See, here we don't *need* the <comma>
<period>

<function-call> '=>'
   'writeln([I : I in 1..' <variable-name> ',' <expression> '])'
<period>
  
<comment>
<function-call> '=>'
  <statement> <comma> <comment>*
  <statement> <comment>*
<period>

<comment>
<function-call> '=>'
  'writeln([I**2 : I in 1..N,' <expression> '])'
<period>

    ||

<function-definition>

<function-definition>

<function-name> '=>'
   <statement> <comment>*
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
