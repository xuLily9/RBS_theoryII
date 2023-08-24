% The user and computer agree with the different fact
% the valid route is travel plan, historical place or other places 
% From London to Paris: flight, bus, train
node(1,name(lisa), initial_fact, []).
node(2,name(adam), initial_fact, []).
node(3,friend(lisa,adam), initial_fact, []).
node(4,live(lisa,london), initial_fact, []).
node(5,live(adam,paris), initial_fact, []).
node(6,city(london), initial_fact, []).
node(7,city(paris), initial_fact, []).
node(8,hotel(00), initial_fact, []).
node(9,park(10), initial_fact, []).
node(10,school(20), initial_fact, []).
node(11,airport(30), initial_fact, []).
node(12,transport(flight), initial_fact, []).
node(13,direct_flight(flight), initial_fact, []).
node(14,light_traffic(c), initial_fact, []).
% fact for route a 
node(15,special_event(a), initial_fact, []).
node(16,route_name(a), initial_fact, []).
node(17,transport(bus), initial_fact, []).
node(18,slowest(bus), initial_fact, []).

%fact for route b
node(19,strike(train), initial_fact, []).
node(20,ticket(train), initial_fact, []).
node(21,transport(train), initial_fact, []).
node(22,route_name(b), initial_fact, []).

rule(1,[name(A),name(B)],friend(A,B)).
rule(2,[name(A),city(X)],live(A,X)).
rule(3,[friend(A,B),live(A,X),live(B,Y)],travel(X,Y)).
rule(4,[road(X,Y)],direct_route(X,Y)).
rule(5,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
rule(6,[direct_route(X,Y)],find_route(X, Y)).
rule(7,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).
rule(8,[hotel(X),park(Y),not(congestion(Y))],road(X,Y)).
rule(9,[park(X),school(Y)],road(X,Y)).
rule(10,[school(X),airport(Y)],road(X,Y)).
rule(11,[transport(Y),direct_flight(Y)],expensive(Y)).
rule(12,[light_traffic(C),hotel(A),airport(B),find_route(A, B),expensive(Y),transport(Y)],valid_route(C)).

% bus is for route a 

rule(13,[special_event(Y)],major_city_event(Y)).
rule(14,[major_city_event(Y)],many_people(Y)).

rule(15,[slowest(X),transport(X)],cheapest(X)).
rule(16,[many_people(Y),route_name(Y),cheapest(X),transport(X)],valid_route(Y)).

% train is for route b
%rule(23,[not(strike(X)),ticket(X)],quickest(X)).
rule(17,[ticket(X)],quickest(X)).
rule(18,[transport(X), quickest(X),route_name(Y)],valid_route(Y)).

rule(19,[valid_route(X),light_traffic(X)],good_route(X)).

conclusion(good_route(b)).

user_fact(1,name(lisa), initial_fact, []).
user_fact(2,name(adam), initial_fact, []).
user_fact(3,friend(lisa,adam), initial_fact, []).
user_fact(4,live(lisa,london), initial_fact, []).
user_fact(5,live(adam,paris), initial_fact, []).
user_fact(6,city(london), initial_fact, []).
user_fact(7,city(paris), initial_fact, []).
user_fact(8,hotel(00), initial_fact, []).
user_fact(9,park(10), initial_fact, []).
user_fact(10,school(20), initial_fact, []).
user_fact(11,airport(30), initial_fact, []).
user_fact(12,transport(flight), initial_fact, []).
user_fact(13,direct_flight(flight), initial_fact, []).
user_fact(14,light_traffic(c), initial_fact, []).
% fact for route a 
user_fact(15,special_event(a), initial_fact, []).
user_fact(16,route_name(a), initial_fact, []).
user_fact(17,transport(bus), initial_fact, []).
user_fact(18,slowest(bus), initial_fact, []).

user_fact(19,strike(train), initial_fact, []).
user_fact(20,ticket(train), initial_fact, []).
user_fact(21,transport(train), initial_fact, []).
user_fact(22,route_name(b), initial_fact, []).

user_rule(1,[name(A),name(B)],friend(A,B)).
user_rule(2,[name(A),city(X)],live(A,X)).
user_rule(3,[friend(A,B),live(A,X),live(B,Y)],travel(X,Y)).
user_rule(4,[road(X,Y)],direct_route(X,Y)).
user_rule(5,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
user_rule(6,[direct_route(X,Y)],find_route(X, Y)).
user_rule(7,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).
user_rule(8,[hotel(X),park(Y),not(congestion(Y))],road(X,Y)).
user_rule(9,[park(X),school(Y)],road(X,Y)).
user_rule(10,[school(X),airport(Y)],road(X,Y)).
user_rule(11,[transport(Y),direct_flight(Y)],expensive(Y)).
user_rule(12,[light_traffic(C),hotel(A),airport(B),find_route(A, B),expensive(Y),transport(Y)],valid_route(C)).

% bus is for route a 

user_rule(13,[special_event(Y)],major_city_event(Y)).
user_rule(14,[major_city_event(Y)],many_people(Y)).

user_rule(15,[slowest(X),transport(X)],cheapest(X)).
user_rule(16,[many_people(Y),route_name(Y),cheapest(X),transport(X)],valid_route(Y)).

% train is for route b
%rule(23,[not(strike(X)),ticket(X)],quickest(X)).
user_rule(17,[ticket(X)],quickest(X)).
user_rule(18,[transport(X), quickest(X),route_name(Y)],valid_route(Y)).

user_rule(19,[valid_route(X),light_traffic(X)],good_route(X)).

fact_description(name(X)):-
    write('his/her name is '), write(X).
fact_description(friend(X,Y)):-
    write(X), write(' and '),write(Y),write(' are friends').
fact_description(travel(X,Y)):-
    write('travel from city '), write(X),write(' to'), write(Y).
fact_description(live(X,Y)):-
    write(X), write(' lives in city '),write(Y).
fact_description(city(X)):-
    write(X), write(' is a city').
fact_description(road(X,Y)):-
    write('we choose this road from '), write(X), write(' to '),write(Y).
fact_description(direct_route(X,Y)):-
    write('it is a direct road from '), write(X), write(' to '),write(Y).
fact_description(indirect_route(X,Y)):-
    write('it is an indirect road from '), write(X), write(' to '),write(Y).
fact_description(find_route(X, Y)):-
    write('we find aroute from '), write(X), write(' to '),write(Y).
fact_description(hotel(X)):-
    write('hotel is at location'), write(X).
fact_description(park(X)):-
    write('park is at location '),write(X).
fact_description(school(X)):-
    write('school is at location '),write(X).
fact_description(airport(X)):-
    write('airport is at location '),write(X).
fact_description(not(congestion(Y))):-
    write('in route '), write(Y), write(',there is no congestion').
fact_description(transport(X)):-
    write(X),write(' is the transport method').
fact_description(direct_flight(X)):-
    write(X),write(' has direct flight').
fact_description(light_traffic(X)):-
    write(X),write(' route has light traffic').
fact_description(expensive(X)):-
    write('transport '),write(X),write(' is expensive').

fact_description(special_event(X)):-
    write('there is a special event in road '),write(X).
fact_description(major_city_event(X)):-
    write('there is a major city event in road '),write(X).
fact_description(many_people(X)):-
    write('there are lots of people in road '),write(X).
fact_description(slowest(X)):-
    write(X), write(' is the slowest route').
fact_description(route_name(X)):-
    write(X), write(' is the route name').
fact_description(cheapest(X)):-
    write('this is the cheapest '),write(X).

fact_description(quickest(X)):-
    write('this is the quickest '),write(X).
fact_description(ticket(X)):-
    write(X),write(' has avaliable ticket').
fact_description(strike(X)):-
    write('the staff of '), write(X), write(' is on strike').

fact_description(quickest(X)):-
    write(X), write(' is the quickest way').
fact_description(valid_route(X)):-
    write(X), write(' is a valid route').
fact_description(good_route(X)):-
   write(X), write(' is a good route').

fact_description(congestion(Y)):-
    write('in location '), write(Y), write(' ,there is a congestion').


rule_description(1):-
    write('1. If two individuals have names A and B, then they are considered friends').
rule_description(2):-
    write('2. If a person name is A and a city X then this person lives in this city').
rule_description(3):-
    write('3. If there are two friends, one person lives in city X and another person lives in city Y then one person want to travel from city X to Y ').
rule_description(4):-
    write('4. If there is a direct road connecting two locations, then this is the direct route.').
rule_description(5):-
    write('5. If there are two roads, with one connecting point A to point B and another connecting point B to point C, then there exists an indirect route from point A to point C.').
rule_description(6):-
    write('6. If there is a direct road connecting two locations, then we find the route between this two locations').
rule_description(7):-
    write('7. If there is a direct road connecting points A and B, and we discover the route between points B and C, then we can find all the route between points A and C.').
rule_description(8):-
    write('8. If there is a hotel, and a park, there is no congestion in park, then we choose the road bewteen hotel and park').
rule_description(9):-
    write('9. If there is a park and a school, then we choose the road between park and school').
rule_description(10):-
    write('10. If there is a school and a airport, then we choose this road between school and airport').
rule_description(11):-
    write('11. If there is no direct flight available for a certain mode of transport, then that mode of transport is considered expensive').
rule_description(12):-
    write('12. If there is light traffic in route C, and there exists a hotel A and an airport B in that area, such that there is a valid route between A and B, and the mode of transport denoted by Y is considered expensive, then the route C is considered valid').
rule_description(13):-
    write('13. If an event is categorized as a special event, then it is also categorized as a major city event').
rule_description(14):-
    write('14. If there is a major city event, then there are lots of people').
rule_description(15):-
    write('15. If X is the slowest mode of transport, then it is also considered the cheapest mode of transport').
rule_description(16):-
    write('16. If a route is associated with many people and has a route name Y, and the mode of transport denoted by X is considered the cheapest, then the route named Y is considered valid').
rule_description(17):-
    write('17. If you have a ticket X, then the mode of transport denoted by X is considered the quickest.').
rule_description(18):-
    write('18. If the mode of transport denoted by X is the quickest and there is a route name Y associated, then the route named Y is considered valid.').
    %write('23. If there is no strike and it has avaliable ticket, then this is the quickest transport method.').
rule_description(19):-
    write('19.If a route X is valid and there is light traffic on that route, then route X is considered a good route.').

%% Pretty print the system rules 

r_description(1):-
    write('1. If two individuals have names A and B, then they are considered friends').
r_description(2):-
    write('2. If a person name is A and a city X then this person lives in this city').
r_description(3):-
    write('3. If there are two friends, one person lives in city X and another person lives in city Y then one person want to travel from city X to Y ').
r_description(4):-
    write('4. If there is a direct road connecting two locations, then this is the direct route.').
r_description(5):-
    write('5. If there are two roads, with one connecting point A to point B and another connecting point B to point C, then there exists an indirect route from point A to point C.').
r_description(6):-
    write('6. If there is a direct road connecting two locations, then we find the route between this two locations').
r_description(7):-
    write('7. If there is a direct road connecting points A and B, and we discover the route between points B and C, then we can find all the route between points A and C.').
r_description(8):-
    write('8. If there is a hotel, and a park, there is no congestion in park, then we choose the road bewteen hotel and park').
r_description(9):-
    write('9. If there is a park and a school, then we choose the road between park and school').
r_description(10):-
    write('10. If there is a school and a airport, then we choose this road between school and airport').
r_description(11):-
    write('11. If there is no direct flight available for a certain mode of transport, then that mode of transport is considered expensive').
r_description(12):-
    write('12. If there is light traffic in route C, and there exists a hotel A and an airport B in that area, such that there is a valid route between A and B, and the mode of transport denoted by Y is considered expensive, then the route C is considered valid').
r_description(13):-
    write('13. If an event is categorized as a special event, then it is also categorized as a major city event').
r_description(14):-
    write('14. If there is a major city event, then there are lots of people').
r_description(15):-
    write('15. If X is the slowest mode of transport, then it is also considered the cheapest mode of transport').
r_description(16):-
    write('16. If a route is associated with many people and has a route name Y, and the mode of transport denoted by X is considered the cheapest, then the route named Y is considered valid').
r_description(17):-
    write('17. If you have a ticket X, then the mode of transport denoted by X is considered the quickest.').
r_description(18):-
    write('18. If the mode of transport denoted by X is the quickest and there is a route name Y associated, then the route named Y is considered valid.').
    %write('23. If there is no strike and it has avaliable ticket, then this is the quickest transport method.').
r_description(19):-
    write('19.If a route X is valid and there is light traffic on that route, then route X is considered a good route.').

system_rule(Rule):-
    r_description(Rule).

