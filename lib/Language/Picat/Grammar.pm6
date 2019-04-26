# use Grammar::Debugger;
# no precompilation;

my role Terminals
  {
  token period { '.' }
  token comma { ',' }

  token module-name { \w+ }

  token function-name { '$'? \w+ }

  token comment
    {
    | '/*' .*? '*/' \s*
    | '%' .*? $$ \s*
    }

  token table-mode { '+' | '-' | 'min' | 'max' | 'nt' }
  token index-mode { '+' | '-' }

  token unsigned-number { \d+ [ '.' \d+ [ <[ e E ]> \d+ ]? ]? }

  token concat { '++' }
  token power { '**' }
  token shift { '<<' | '>>' }
  token add-sub { '+' | '-' }
  token mul-div { '*' | '/' | '//' | '/>' | '/<' | 'div' | 'mod' | 'rem' }
  token bitwise { '^' | '/\\' | '\\/' }
  token comparison { '==' | '<=' | '>=' | '<' | '>' }
  }

grammar Language::Picat::Grammar
  {
  also does Terminals;

  token variable-name
    {
    | \w+ [ '[' \w+ ']' | [ '.' \w+ ]+ ]?
    | '"' [ <-[ " ]> | '\\\"' ]* '"'
    }

  rule module-declaration
    {
    'module' <comment>* <module-name> <period> <comment>*
    }

  rule import-declaration
    {
    'import' <comment>* <module-name>+ %% <comma> <period>
    }

  rule table-modes { '(' <table-mode>+ %% <comma> ')' }
  rule index-modes { '(' <index-mode>+ %% <comma> ')' }

  rule predicate-directive
    {
    | 'private'
    | 'table' <table-modes>?
    | 'index' <index-modes>?
    }

  rule function-definition
    {
    <predicate-directive>? <comment>* <atom-or-call>
      [
        [ '?=>' | '=>' ] <comment>*
      <statement>+ %% <comma>
      ]?
    <period>
    }

  rule variable-list { '[' <expression>* %% <comma> ']' }

  rule list-expression
    {
    '[' <expression> ':' <expression> 'in' <range> ',' <expression> ']'
    }

  rule argument-list { '(' <expression>+ %% <comma> ')' }

  rule atom-or-call { <function-name> <argument-list>? }

  rule parentheses-expression { '(' <expression>? ')' }

  rule terminal
    {
    | <atom-or-call>
    | <variable-name>
    | <variable-list>
    | <list-expression>
    | <unsigned-number>
    }

  rule primary-expression
    {
    | <atom-or-call>
    | <variable-name>
    | <variable-list>
    | <list-expression>
    | <unsigned-number>
    | <terminal>
    }

  rule binding { <variable-name> ':=' <expression> }

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
    <exponent-expression> [ <concat> <exponent-expression> ]*
    }

  rule exponent-expression
    {
    <shift-expression>+ %% <power>
    }

  rule shift-expression
    {
    <add-expression>+ %% <shift>
    }

  rule add-expression
    {
    <multiply-expression>+ %% <add-sub>
    }

  rule multiply-expression
    {
    <bitwise-expression>
    [ <mul-div> <bitwise-expression> ]*
    }

  rule bitwise-expression
    {
    <logic-expression>+ %% <bitwise>
    }

  rule logic-expression
    {
    <primary-expression>+ %% <comparison>
    }

  rule range { <expression> [ '..' <expression> ] ** {0..2} }

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

  rule program-body { <function-definition>+ %% <comment>* }

  rule TOP
    {
    ^ <comment>*
      <module-declaration>?
      <import-declaration>*
      <program-body>
    $
    }
  }
