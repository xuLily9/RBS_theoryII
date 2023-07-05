node(1,name(alex), initial_fact, []).
node(2,name(emma), initial_fact, []).
node(3,friend(alex,emma), initial_fact, []).
node(4,call(alex,emma), initial_fact, []).
node(5,give_advice(forcast), initial_fact, []).
node(6,app(forcast), initial_fact, []).
node(7,smile(forcast), initial_fact, []).

node(8,road(00,10), initial_fact, []).
node(9,road(10,20), initial_fact, []).
node(10,road(20,30), initial_fact, []).
node(12,school(00), initial_fact, []).
node(13,airport(30), initial_fact, []).
node(14,green(c), initial_fact, []).

rule(1,[friend(X,Z),call(X,Z),give_advice(W)],take_advice(X,W)).
rule(2,[app(W),take_advice(X,W)],download(X,W)).
rule(3,[smile(W)],predict_sunny(W)).
rule(4,[predict_sunny(W),download(X,W)],weather_sunny(X)).

rule(5,[green(X)],light_traffic(X)).

rule(6,[road(X,Y)],direct_route(X,Y)).
rule(7,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
rule(8,[direct_route(X,Y)],find_route(X, Y)).
rule(9,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).

rule(10,[light_traffic(C),weather_sunny(X),school(A),airport(B),find_route(A, B),name(X)],valid_route(C)).


%rule(12,[name(X),route_set(A,B,C),not(valid_route(A)),not(valid_route(B)),valid_route(C)],chosen_route(X,C)).

%rule(5,[route_name(C),find_route(X, Y),school(X),airport(Y)],route(C)).

%rule(16,[light_traffic(C),weather_sunny(X),route(C),name(X)],valid_route(C)).