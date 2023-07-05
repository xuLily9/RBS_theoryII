


conclusion(chosen_route(alex,c)).


node(1,name(alex), initial_fact, []).
node(2,name(emma), initial_fact, []).
node(5,friend(alex,emma), initial_fact, []).

node(2,call(alex,emma), initial_fact, []).
node(8,give_advice(forcast), initial_fact, []).
node(16,app(forcast), initial_fact, []).
node(13,smile(forcast), initial_fact, []).

node(14,gas_station(00), initial_fact, []).
node(15,supermarket(10), initial_fact, []).
node(16,hospital(20), initial_fact, []).
node(17,park(30), initial_fact, []).
node(18,green(c), initial_fact, []).
node(19,off_peak(c), initial_fact, []).
node(20,airport(40), initial_fact, []).

node(21,route_name(c), initial_fact, []).
%node(14,road_set([road(00,20),road(20,30)]), initial_fact, []).
node(22,road(00,10), initial_fact, []).
node(23,road(10,20), initial_fact, []).
node(24,road(20,30), initial_fact, []).
node(25,highway(30,40), initial_fact, []).

node(26,route_set(a,b,c), initial_fact, []).

road_set(Roads) :-
    Roads = [Road | Rest],  % Extract the first road from the list
    process_road(Road),  % Use the road in your custom rule or predicate
    road_set(Rest).  % Recursively process the remaining roads

road_set([]).  % Base case: an empty road set
process_road(Road) :-
    % Custom rule or predicate using the road
    % ...
    assert(node(_ID, Road, _ID_r, [])),!,
    writeln(Road).  % Printing the road as an example




rule(1,[friend(X,Z),call(X,Z),give_advice(W)],take_advice(X,W)).
rule(2,[app(W),take_advice(X,W)],download(X,W)).

rule(3,[smile(W)],predict_sunny(W)).
rule(4,[predict_sunny(W),download(X,W)],weather_sunny(X)).


%rule(16,[gas_station(X),supermarket(Y)],connected(X,Y)).
%rule(16,[supermarket(X),hospital(Y)],connected(X,Y)).
%rule(16,[hospital(X),park(Y)],connected(X,Y)).
%rule(16,[park(X),airport(Y)],highway(X,Y)).

%rule(16,[road(X,Y)],connected(X,Y)).
%rule(16,[connected(X,Y),road(X,Y)],connected(X,Y)).
rule(5,[road(X,Z),road(Z,Y)],road(X,Y)).
rule(6,[road(X,Y),highway(Y,Z)],route(X,Z)).



rule(7,[green(X),off_peak(X)],light_traffic(X)).

%rule(16,[light_traffic(C),weather_sunny(X),route(C),name(X)],valid_route(C)).

rule(8,[name(X),route_set(A,B,C),not(valid_route(A)),not(valid_route(B)),valid_route(C)],chosen_route(X,C)).



%rule(16,[road(From, To),road(From, To)],route(C)).

% Predicate to convert individual roads into a road_set
%convert_roads(RoadSet) :-	
  %findall(road(From, To), road(From, To), RoadSet).

