# use Grammar::Tracer;
# no precompilation;
grammar Language::Picat::Grammar
  {
  token comment
    {
    '/*' .*? '*/'
    }
  rule TOP
    {
      [
      <comment>

'% import util.'
'% import cp.'


'main => go.'

'go => 
   doors(10),
   doors(100),
   doors_opt(100),
   doors_opt2(100),
   nl.'

'% non-optimized'
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
  
'% optimized version 1'
'doors_opt(N) =>
  foreach(I in 1..N)
     Root = sqrt(I),
     writeln([I, cond(Root == 1.0*round(Root), open, closed)])
  end,
  nl.'

'% optimized version 2'
'doors_opt2(N) => 
  writeln([I**2 : I in 1..N, I**2 <= N]).'

    ||

<comment>

'% import cp.'

'% See http://www.hakank.org/picat/bplan.pi'
'import bplan.'

'main => go.'

'go =>
   % time(once(bplan(L))),
   time(bplan(L)),
   write(L), nl,
   Len=length(L),
   write(len=Len),nl.'

'go2 =>
   foreach(Len in 1..15)
      nl,
      write(len=Len), nl,
      L = new_list(Len),
      time(All=findall(L, $plan(L))),'
      '% writeln(All),'
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


'%'
'% Length 6 (original problem)'
'%'
'% index(-)'
'% % initial_state([1,3,2,6,5,4]). % Moves: 2,3,2'
'% % initial_state([5,6,2,1,4,3]). % Moves: 1,3'
'% % initial_state([6,5,4,1,2,3]). % Moves: 1,2,3'
'% % initial_state([2,1,5,4,3,6]). % Moves: 1,2,1'
'% % initial_state([5,1,2,3,4,6]). % Moves: 1,2,1,2'
'% % initial_state([5,4,3,2,1,6]). % Moves: 1,2,1,2,1'
'% %% These two takes 11 steps (no problem at all).'
'% initial_state([6,3,5,2,4,1]).   % GAP: x3*x1*x2*x1*x3*x2*x1*x2*x1*x3*x1'
'% % initial_state([6,4,2,5,3,1]).   % GAP: x1*x3*x2*x3*x2*x1*x3*x2*x3*x2*x1'
'% %% initial_state([_,_,_,_,_,_]). % don\'t work'
'% % initial_state([6,5,4,3,1,2]). % moves 1,3,2,1,3,1,2,1'
'% % initial_state([6,3,4,5,2,1]). % 1,3,2,1,3'

'% goal_state(Goal) => Goal = [1,2,3,4,5,6].'

'% table'
'% % legal_move(From, Move, To).'
'% legal_move([M4,M3,M2,M1,M5,M6],M,To) ?=> M=1, To=[M1,M2,M3,M4,M5,M6]. % move 1'
'% legal_move([M1,M5,M4,M3,M2,M6],M,To) ?=> M=2, To=[M1,M2,M3,M4,M5,M6]. % move 2'
'% legal_move([M1,M2,M6,M5,M4,M3],M,To)  => M=3, To=[M1,M2,M3,M4,M5,M6]. % move 3'

'%'
'% Length 8'
'%'

'index(-)'
'%% finds all 27 solutions in 0.15s'
'initial_state([2,4,1,7,5,3,8,6]). % GAP: x2*x3*x2*x4*x3*x5*x4*x1*x2*x1'
'%% finds all 44 solutions in 0.168s'
'% initial_state([8,7,6,3,2,5,4,1]).  % x3*x1*x2*x3*x1*x4*x5*x1*x3*x1'

'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To) ?=> M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8].' '% move 1'
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To) ?=> M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8].' '% move 2'
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To) ?=> M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8].' '% move 3'
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To) ?=> M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8].' '% move 4'
'legal_move([M1,M2,M3,M4,M8,M7,M6,M5],M,To)  => M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8].' '% move 5'

'goal_state(Goal) => Goal = [1,2,3,4,5,6,7,8].'


'%'
'% for bplan.plan2/3'
'%'
'table'
'legal_move([M4,M3,M2,M1,M5,M6,M7,M8],M,To,Cost) ?=> M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' '% move 1'
'legal_move([M1,M5,M4,M3,M2,M6,M7,M8],M,To,Cost) ?=> M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' '% move 2'
'legal_move([M1,M2,M6,M5,M4,M3,M7,M8],M,To,Cost) ?=> M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' '% move 3'
'legal_move([M1,M2,M3,M7,M6,M5,M4,M8],M,To,Cost) ?=> M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' '% move 4'
'legal_move([M1,M2,M3,M4,M8,M7,M6,M5],M,To,Cost)  => M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8],Cost=1.' '% move 5'


'%'
'% Length 12'
'%'
'%% This takes too long and too much memory...'

'% table'
'% legal_move([M4,M3,M2,M1,M5,M6,M7,M8,M9,M10,M11,M12],M,To) ?=> M=1,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 1'
'% legal_move([M1,M5,M4,M3,M2,M6,M7,M8,M9,M10,M11,M12],M,To) ?=> M=2,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 2'
'% legal_move([M1,M2,M6,M5,M4,M3,M7,M8,M9,M10,M11,M12],M,To) ?=> M=3,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 3'
'% legal_move([M1,M2,M3,M7,M6,M5,M4,M8,M9,M10,M11,M12],M,To) ?=> M=4,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 4'
'% legal_move([M1,M2,M3,M4,M8,M7,M6,M5,M9,M10,M11,M12],M,To) ?=> M=5,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 5'
'% legal_move([M1,M2,M3,M4,M5,M9,M8,M7,M6,M10,M11,M12],M,To) ?=> M=6,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 6'
'% legal_move([M1,M2,M3,M4,M5,M6,M10,M9,M8,M7,M11,M12],M,To) ?=> M=7,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 7'
'% legal_move([M1,M2,M3,M4,M5,M6,M7,M11,M10,M9,M8,M12],M,To) ?=> M=8,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 8'
'% legal_move([M1,M2,M3,M4,M5,M6,M7,M8,M12,M11,M10,M9],M,To) ?=> M=9,To=[M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12].' '% move 9'

'% %% number of moves: 12'
'% index(-)'
'% initial_state([7,5,11,8,9,1,10,3,4,2,6,12]).'
'% %% number of moves: 12'
'% % initiial_state([12,2,7,3,4,11,1,10,8,9,6,5]).'

'% goal_state(Goal) => Goal = [1,2,3,4,5,6,7,8,9,10,11,12].'

      ] $
    }
  }
