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

  rule module-declaration
    {
    'module' <comment>* <module-name> <period> <comment>*
    }

  rule import-declaration
    {
    'import' <comment>* <module-name>+ %% <comma> <period> <comment>*
    }

  token comment
    {
    | '/*' .*? '*/' \s*
    | '%' .*? $$ \s*
    }

  rule function-definition
    {
    <atom-or-call> '=>'
      <comment>*
      [ <statement> <comma> <comment>* ]*
      <statement> <comment>*
    <period>
    }

  rule fact-definition
    {
    <atom-or-call> '?=>'
      <comment>*
      <expression>+ %% [ <comment>* <comma> ]
      <comment>*
    <period>
    <comment>*
    }

  rule variable-list
    {
    '[' <expression>* %% <comma> ']'
    }

  rule list-expression
    {
    '[' <expression> ':' <expression> 'in' <range> ',' <expression> ']'
    }

  rule atom-or-call
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

  rule primary-expression
    {
    | <atom-or-call>
    | <variable-name>
    | <variable-list>
    | <list-expression>
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
    | <primary-expression>
    }

  rule assignment-expression
    {
    | <variable-name> '=' <expression>
    | <concat-expression>
    }

  rule concat-expression
    {
    <exponent-expression> [ '++' <exponent-expression> ]*
    }

  rule exponent-expression
    {
    <shift-expression> [ '**' <shift-expression> ]*
    }

  rule shift-expression
    {
    <add-expression> [ [ '<<' | '>>' ] <add-expression> ]*
    }

  rule add-expression
    {
    <multiply-expression> [ [ '+' | '-' ] <multiply-expression> ]*
    }

  rule multiply-expression
    {
    <bitwise-expression>
    [ [ '*'
      | '/'
      | '//'
      | '/>'
      | '/<'
      | 'div'
      | 'mod'
      | 'rem'
      ] <bitwise-expression> ]*
    }

  rule bitwise-expression
    {
    <logic-expression> [ [ '^' | '/\\' | '\\/' ] <logic-expression> ]*
    }

  rule logic-expression
    {
    <primary-expression> [ [ '==' | '<=' | '>=' | '<' | '>' ] <expression> ]*
    }

  rule range
    {
    <expression> [ '..' <expression> [ '..' <expression> ]? ]?
    }

  rule foreach
    {
    'foreach' '(' <variable-name> 'in' <range> ')'
      [ <statement> <comma> <comment>* ]*
      <statement> <comment>*
    'end'
    }

  rule if
    {
    'if' <expression> 'then'
      [ <statement> <comma> <comment>* ]*
      <statement> <comment>*
    'end'
    }

  rule statement
    {
    | <foreach>
    | <if>
    | <binding>
    | <expression>
    }

  rule TOP
    {
    ^ <comment>*
      <module-declaration>?
      <import-declaration>*
      <program-body>
    $
    }

  rule program-body
    {
      [
<function-definition>+ %% <comment>*

'index(-)'
<comment>
<atom-or-call> <period>
<comment>+

'table'
<fact-definition>

<fact-definition>

<fact-definition>

<fact-definition>

<function-definition>
<comment>

<function-definition>

<comment>+
'table'
<fact-definition>

<fact-definition>

<fact-definition>

<fact-definition>

<function-definition>
<comment>+

||

<function-definition>+ %% <comment>*
      ]
    }
  }
