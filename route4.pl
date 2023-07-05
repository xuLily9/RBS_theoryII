node(1,road(00,10), initial_fact, []).
node(2,road(10,20), initial_fact, []).
node(3,road(20,30), initial_fact, []).
node(4,highway(30,40), initial_fact, []).
node(5,school(00), initial_fact, []).
node(6,airport(30), initial_fact, []).
node(7,route_name(c), initial_fact, []).

rule(1,[road(X,Y)],direct_route(X,Y)).
rule(2,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
rule(3,[direct_route(X,Y)],find_route(X, Y)).
rule(4,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).

%rule(5,[route_name(C),find_route(X, Y),school(X),airport(Y)],route(C)).

%rule(16,[light_traffic(C),weather_sunny(X),route(C),name(X)],valid_route(C)).