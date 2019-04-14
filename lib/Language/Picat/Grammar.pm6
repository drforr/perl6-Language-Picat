# use Grammar::Tracer;
# no precompilation;
grammar Language::Picat::Grammar
  {
  token comment
    {
    | '/*' .*? '*/' \s*
    | '%' .*? $$ \s*
    }
  rule TOP
    {
      [
      <comment>+

'main => go.'

'go => 
   doors(10),
   doors(100),
   doors_opt(100),
   doors_opt2(100),
   nl.'

<comment>
'doors(N) => 
   Doors = new_array(N),
   foreach(I in 1..N) Doors[I] := 0 end,
   foreach(I in 1..N)
     foreach(J in I..I..N)
        Doors[J] := 1^Doors[J]
     end,
     if N <= 10 then
        print_open(Doors)
     end
   end,
   writeln(Doors),
   print_open(Doors),
   nl.'

'print_open(Doors) => writeln([I : I in 1..Doors.length, Doors[I] == 1]).'
  
<comment>
'doors_opt(N) =>
  foreach(I in 1..N)
     Root = sqrt(I),
     writeln([I, cond(Root == 1.0*round(Root), open, closed)])
  end,
  nl.'

<comment>
'doors_opt2(N) => 
  writeln([I**2 : I in 1..N, I**2 <= N]).'

    ||

<comment>+
'import bplan.'

'main => go.'

'go =>'
   <comment>
   'time(bplan(L)),
   write(L), nl,
   Len=length(L),
   write(len=Len),nl.'

'go2 =>
   foreach(Len in 1..15)
      nl,
      write(len=Len), nl,
      L = new_list(Len),
      time(All=findall(L, $plan(L))),'
      <comment>
      'writeln(all_len=All.length)
   end.'

'go3 => 
  L = new_list(10),
  All=findall(L,$plan(L)),
  writeln(All),
  writeln(len=All.length),
  nl.'

'go4 =>
   initial_state(Init),
   time(plan2(Init,L,Cost)),
   write(L), nl,
   writeln(len=L.length),
   writeln(cost=Cost),
   nl.'

'go5 =>
   initial_state(Init),
   time(plan3(Init,L,Cost,[])),
   write(L), nl,
   writeln(len=L.length),
   writeln(cost=Cost),
   nl.'


<comment>+

'index(-)'
<comment>
'initial_state([2,4,1,7,5,3,8,6]).' <comment>+

'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To) ?=> M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8].' <comment>
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To) ?=> M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8].' <comment>
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To) ?=> M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8].' <comment>
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To) ?=> M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8].' <comment>
'legal_move([M1,M2,M3,M4,M8,M7,M6,M5],M,To)  => M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8].' <comment>

'goal_state(Goal) => Goal = [1,2,3,4,5,6,7,8].'


<comment>+
'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To,Cost) ?=> M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' <comment>
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To,Cost) ?=> M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' <comment>
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To,Cost) ?=> M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' <comment>
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To,Cost) ?=> M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' <comment>
'legal_move([M1,M2,M3,M4,M8,M7,M6,M5],M,To,Cost)  => M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' <comment>


<comment>+

      ] $
    }
  }
