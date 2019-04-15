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

  rule import-statement
    {
    'import' <module-name> '.'
    }
  token comment
    {
    | '/*' .*? '*/' \s*
    | '%' .*? $$ \s*
    }

  rule statement
    {
    | <import-statement>
    | <comment>
    }

  rule TOP
    {
      [
      <statement>+

<function-name> '=>' 'go' '.'

<function-name> '=>'
   'doors(10)' ','
   'doors(100)' ','
   'doors_opt(100)' ','
   'doors_opt2(100)' ','
   'nl' '.'

<statement>
<function-name> '(N)' '=>'
   'Doors = new_array(N)' ','
   'foreach(I in 1..N)' 'Doors[I] := 0' 'end' ','
   'foreach(I in 1..N)'
     'foreach(J in I..I..N)'
        'Doors[J] := 1^Doors[J]'
     'end' ','
     'if N <= 10 then'
        'print_open(Doors)'
     'end'
   'end' ','
   'writeln(Doors)' ','
   'print_open(Doors)' ','
   'nl' '.'

<function-name> '(Doors) => writeln([I : I in 1..Doors.length, Doors[I] == 1])' '.'
  
<statement>
<function-name> '(N)' '=>'
  'foreach(I in 1..N)'
     'Root = sqrt(I)' ','
     'writeln([I, cond(Root == 1.0*round(Root), open, closed)])'
  'end' ','
  'nl' '.'

<statement>
<function-name> '(N)' '=>'
  'writeln([I**2 : I in 1..N, I**2 <= N])' '.'

    ||

<statement>+

<function-name> '=>' 'go' '.'

<function-name> '=>'
   <statement>
   'time(bplan(L))' ','
   'write(L)' ',' 'nl' ','
   'Len=length(L)' ','
   'write(len=Len)' ',' 'nl' '.'

<function-name> '=>'
   'foreach(Len in 1..15)'
      'nl' ','
      'write(len=Len),' 'nl,'
      'L = new_list(Len)' ','
      'time(All=findall(L, $plan(L)))' ','
      <statement>
      'writeln(all_len=All.length)'
   'end' '.'

<function-name> '=>'
  'L = new_list(10)' ','
  'All=findall(L,$plan(L))' ','
  'writeln(All)' ','
  'writeln(len=All.length)' ','
  'nl' '.'

<function-name> '=>'
   'initial_state(Init)' ','
   'time(plan2(Init,L,Cost))' ','
   'write(L)' ',' 'nl' ','
   'writeln(len=L.length)' ','
   'writeln(cost=Cost)' ','
   'nl' '.'

<function-name> '=>'
   'initial_state(Init)' ','
   'time(plan3(Init,L,Cost,[]))' ','
   'write(L)' ',' 'nl' ','
   'writeln(len=L.length)' ','
   'writeln(cost=Cost)' ','
   'nl' '.'

<statement>+

'index(-)'
<statement>
'initial_state([2,4,1,7,5,3,8,6])' '.' <statement>+

'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To)' '?=>' 'M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To)' '?=>' 'M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To)' '?=>' 'M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To)' '?=>' 'M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>
<function-name> '([M1,M2,M3,M4,M8,M7,M6,M5],M,To)' '=>' 'M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8]' '.' <statement>

<function-name> '(Goal)' '=>' 'Goal = [1,2,3,4,5,6,7,8]' '.'

<statement>+
'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To,Cost)' '?=>' 'M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To,Cost)' '?=>' 'M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To,Cost)' '?=>' 'M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To,Cost)' '?=>' 'M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>
<function-name> '([M1,M2,M3,M4,M8,M7,M6,M5],M,To,Cost)' '=>' 'M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1' '.' <statement>

<statement>+

      ] $
    }
  }
