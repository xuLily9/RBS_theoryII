node(1,weekday(a), initial_fact, []).
node(2,between_5pm6pm(a), initial_fact, []).

rule(1,[not(rush_hour(X))],road_clear(X)).
rule(2,[rush_hour(X)],congestion(X)).
rule(3,[weekday(X),between_5pm6pm(X)],rush_hour(X)).

% Define the forward chaining algorithm
forward_chain :-
    repeat,
    (   rule(_ID_r, _A, Q),
        \+ node(ID, Q, ID_r, NodeList),
        check_conditions(Q),
        assert(ID, Q, ID_r, NodeList),
        write(Q), write(' is true.'), nl,
        fail
    ;   !).

check_conditions(Q) :-
    rule(_ID_r, _A, Q),
    check_conditions_recursive(Q).

check_conditions_recursive([]).

check_conditions_recursive([H|T]) :-
    node(_ID, H, _ID_r, _NodeList),
    check_conditions_recursive(T).








