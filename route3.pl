


conclusion(chosen_route(alex,c)).


node(1,name(alex), initial_fact, []).
node(2,name(emma), initial_fact, []).
node(5,friend(alex,emma), initial_fact, []).

node(2,call(alex,emma), initial_fact, []).
node(8,give_advice(forcast), initial_fact, []).
node(16,app(forcast), initial_fact, []).

node(13,green(forcast), initial_fact, []).
node(14,route(c), initial_fact, []).
node(14,light_traffic(c), initial_fact, []).
node(14,route_set(a,b,c), initial_fact, []).





rule(3,[friend(X,Z),call(X,Z),give_advice(W)],take_advice(X,W)).

rule(6,[app(W),take_advice(X,W)],download(X,W)).

rule(7,[green(W)],predict_sunny(W)).
rule(9,[predict_sunny(W),download(X,W)],weather_sunny(X)).


rule(16,[light_traffic(C),weather_sunny(X),route(C),name(X)],valid_route(C)).

rule(16,[name(X),route_set(A,B,C),not(valid_route(A)),not(valid_route(B)),valid_route(C)],chosen_route(X,C)).



