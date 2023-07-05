% Facts representing individual road segments
road(00, 20).
road(20, 30).
road(30, 40).
road(40, 50).
road(50, 60).
road(20, 40).
road(30, 50).

% Rule representing a direct route
direct_route(X, Y) :-
  road(X, Y).

% Rule representing an indirect route
indirect_route(X, Y) :-
  direct_route(X, Z),
  direct_route(Z, Y).

% Forward chaining predicate to find all routes
find_route(X, Y, Route) :-
  find_route(X, Y, [], Route).

% Base case: direct route between X and Y
find_route(X, Y, Visited, [X, Y]) :-
  direct_route(X, Y),
  \+ member(Y, Visited).

% Recursive case: find intermediate location Z
find_route(X, Y, Visited, [X|Rest]) :-
  direct_route(X, Z),
  \+ member(Z, Visited),
  find_route(Z, Y, [X|Visited], Rest).