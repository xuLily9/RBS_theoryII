% The user and computer agree with the different reason 
% From manchester to london: flying, by train, by car 
node(1,name(sarah), initial_fact, []).
node(2,name(jack), initial_fact, []).
node(3,hotel(00), initial_fact, []).
node(4,museum(10), initial_fact, []).
node(5,luggage(20), initial_fact, []).
node(6,airport(30), initial_fact, []).
node(7,live(sarah,manchester), initial_fact, []).
node(8,live(jack,london), initial_fact, []).
node(9,available(flight), initial_fact, []).
node(10,forcast_sunny(flight), initial_fact, []).
node(11,transport(flight), initial_fact, []).
node(12,light_traffic(c), initial_fact, []).

% fact for route a 
node(13,transport(train), initial_fact, []).
node(14,holiday(a), initial_fact, []).
node(15,costy(train), initial_fact, []).
node(16,route_name(a), initial_fact, []).

%fact for route b
node(17,license(car), initial_fact, []).
node(18,drive(car), initial_fact, []).
node(19,route_name(b), initial_fact, []).
node(20,transport(car), initial_fact, []).

%the flight for route c
rule(1,[name(A),name(B)],friend(A,B)).
rule(2,[name(A),city(X)],live(A,X)).
rule(3,[friend(A,B),live(A,X),live(B,Y)],travel(X,Y)).
rule(5,[forcast_sunny(X)],weather_good(X)).
rule(6,[road(X,Y)],direct_route(X,Y)).
rule(7,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
rule(8,[direct_route(X,Y)],find_route(X, Y)).
rule(9,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).
rule(10,[hotel(X),museum(Y),not(congestion(Y))],road(X,Y)).
rule(11,[museum(X),luggage(Y)],road(X,Y)).
rule(12,[luggage(X),airport(Y)],road(X,Y)).
rule(13,[light_traffic(Y),transport(X),available(X),hotel(A),airport(B),find_route(A, B)],valid_route(Y)).

rule(14,[forcast_rain(X)],weather_bad(X)).
rule(15,[forcast_storm(X)],weather_bad(X)).

%the train for route a 

rule(16,[christmas(X)],holiday(X)).
rule(17,[holiday(X)],special_event(X)).
rule(18,[special_event(Y)],major_city_event(Y)).
rule(19,[major_city_event(Y)],many_people(Y)).
rule(21,[transport(X),costy(X)],quickest(X)).
rule(22,[many_people(Y),route_name(Y),quickest(X),costy(X)],valid_route(Y)).

% the car for route b

rule(23,[drive(X)],slowest(X)).
rule(24,[transport(X),slowest(X),route_name(Y)],valid_route(Y)).

rule(25,[valid_route(X)],good_route(X)).

conclusion(good_route(b)).


user_fact(1,name(sarah), initial_fact, []).
user_fact(2,name(jack), initial_fact, []).
user_fact(3,hotel(00), initial_fact, []).
user_fact(4,museum(10), initial_fact, []).
user_fact(5,luggage(20), initial_fact, []).
user_fact(6,airport(30), initial_fact, []).
user_fact(7,live(sarah,manchester), initial_fact, []).
user_fact(8,live(jack,london), initial_fact, []).
user_fact(9,available(flight), initial_fact, []).
user_fact(10,forcast_sunny(flight), initial_fact, []).
user_fact(11,route_name(c), initial_fact, []).
% fact for route a 
user_fact(12,city(london), initial_fact, []).
user_fact(13,city(manchester), initial_fact, []).
user_fact(14,city(birminghan), initial_fact, []).
user_fact(15,direct(manchester,birminghan), initial_fact, []).
user_fact(16,direct(birminghan,london), initial_fact, []).
user_fact(17,transport(train), initial_fact, []).
user_fact(18,christmas(train), initial_fact, []).
user_fact(19,route_name(a), initial_fact, []).

%fact for route b

user_fact(20,license(car), initial_fact, []).
user_fact(21,drive(car), initial_fact, []).
user_fact(22,route_name(b), initial_fact, []).

user_rule(1,[name(A),name(B)],friend(A,B)).
user_rule(2,[name(A),city(X)],live(A,X)).
user_rule(3,[friend(A,B),live(A,X),live(B,Y)],travel(X,Y)).
user_rule(4,[city(A), city(B), travel(A,B), available(X)],transport(X)).
user_rule(5,[forcast_sunny(X)],weather_good(X)).
user_rule(6,[road(X,Y)],direct_route(X,Y)).
user_rule(7,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
user_rule(8,[direct_route(X,Y)],find_route(X, Y)).
user_rule(9,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).
user_rule(10,[hotel(X),museum(Y),not(congestion(Y))],road(X,Y)).
user_rule(11,[museum(X),luggage(Y)],road(X,Y)).
user_rule(12,[luggage(X),airport(Y)],road(X,Y)).

user_rule(13,[available(X),transport(X),route_name(Y),weather_good(X),hotel(A),airport(B),find_route(A, B)],valid_route(Y)).

user_rule(14,[forcast_rain(X)],weather_bad(X)).
user_rule(15,[forcast_storm(X)],weather_bad(X)).

%the train for route a 

user_rule(16,[city(A),city(C),indirect(A,C),transport(X)],ticket(X)).
user_rule(17,[direct(A,B),direct(B,C)],indirect(A,C)).
user_rule(18,[christmas(X)],holiday(X)).
user_rule(19,[holiday(Y)],many_people(Y)).
user_rule(20,[many_people(Y)],expensive(Y)).
user_rule(21,[route_name(Y),expensive(X),ticket(X)],valid_route(Y)).

% the car for route b
user_rule(22,[license(X)], drive(X)).
user_rule(23,[drive(X)],slowest(X)).
user_rule(24,[transport(X),slowest(X),route_name(Y)],valid_route(Y)).


user_rule(25,[valid_route(X)],good_route(X)).

fact_description(name(X)):-
    write('his/her name is '), write(X).
fact_description(friend(X,Y)):-
    write(X), write(' and '),write(Y),write(' are friends').
fact_description(live(X,A)):-
    write(X), write(' lives in city '),write(A).
fact_description(travel(X,Y)):-
    write('travel from city '),write(X), write(' to city '),write(Y).
fact_description(city(X)):-
    write(X), write(' is a city ').
fact_description(available(X)):-
     write(X), write(' has available tickets').
fact_description(hotel(X)):-
    write(X), write(' is a hotel').
fact_description(road(X,Y)):-
    write('we choose this road from '), write(X), write(' to '),write(Y).
fact_description(museum(X)):-
    write(X), write(' is a museum').
fact_description(luggage(X)):-
    write(X), write(' is a luggage storage').
fact_description(airport(X)):-
    write('airport is at location '),write(X).
fact_description(forcast_sunny(X)):-
    write('it is a sunny day for'),write(X).
fact_description(weather_good(X)):-
    write('it is a good weather for taking '),write(X).
fact_description(forcast_rain(X)):-
    write('it is a rainy day for'),write(X).
fact_description(weather_bad(X)):-
    write('it is a bad weather for taking '),write(X).
fact_description(forcast_storm(X)):-
    write('it is a storm for'),write(X).
fact_description(drive(X)):-
    write('he/She can dive'),write(X).
fact_description(transport(X)):-
    write(X),write(' is the transport method').
fact_description(route_name(X)):-
    write(X), write(' is the route name').
fact_description(not(congestion(Y))):-
    write('in location '), write(Y), write(',there is no congestion').

fact_description(direct_route(X,Y)):-
    write('it is a direct road from '), write(X), write(' to '),write(Y).
fact_description(indirect_route(X,Y)):-
    write('it is an indirect road from '), write(X), write(' to '),write(Y).
fact_description(costy(X)):-
    write(X), write(' method is costy').
fact_description(find_route(X, Y)):-
    write('we find aroute from '), write(X), write(' to '),write(Y).


fact_description(christmas(X)):-
    write(X), write(' is taken during christmas period').
fact_description(many_people(X)):-
    write('there are lots of people in road '),write(X).
fact_description(holiday(X)):-
    write(X), write(' is taken on holiday').
fact_description(expensive(X)):-
    write(X), write(' is expensive').
fact_description(ticket(X)):-
    write(X),write(' has avaliable tickets').
fact_description(valid_route(X)):-
    write(X), write(' is a valid route').


fact_description(slowest(X)):-
    write(X), write(' is the slowest route').
fact_description(license(X)):-
    write('he/she has the license of '),write(X).

fact_description(good_route(X)):-
   write(X), write(' is a good route').


rule_description(1):-
    write('1. If there are names of two person, then they are friends').
rule_description(2):-
    write('2. If a person with name and a city name, then he/she lives in this city is true').
rule_description(3):-
    write('3. If a person live in a city and another person lives in another city, these two persons are friends, then one person wats to travel from his city to another city').
rule_description(4):-
    write('4. If there are twi cities and a person wants to travel from one to another, there is avaliable tickets on a method, then this method is a transport').
rule_description(5):-
    write('5. If the forcast is sunny for a transport, then the weather is good for a transport').
rule_description(6):-
    write('6. If there is a direct road connecting two locations, then this is the direct route.').
rule_description(7):-
    write('7. If there are two roads, with one connecting point A to point B and another connecting point B to point C, then there exists an indirect route from point A to point C.').
rule_description(8):-
    write('8. If there is a direct road connecting two locations, then we find the route between this two locations').
rule_description(9):-
    write('9. If there is a direct road connecting points A and B, and we discover the route between points B and C, then we can find all the route between points A and C.').
rule_description(10):-
    write('10. If there is a hotel, and a museum there is no congestion near the museum, then we choose the road bewteen hotel and museum').
rule_description(11):-
    write('11. If there is a museum and the person needs to pick up his luggage in storage, then we choose the road between museum and luggage storage').
rule_description(12):-
    write('12. If there is a lugguge storage and a airport, then we choose this road between luggage and airport').


rule_description(13):-
    write('13. If the transport method has avaliable tickest and is part of a route from hotel to airport, we can find this route, and the weather is good, then this route is a valid route').
rule_description(14):-
    write('14. If the forcast is rainy for a transport, then the weather is bad for a transport').
rule_description(15):-
    write('15. If the forcast is storm for a transport, then the weather is bad for a transport').

rule_description(16):-
    write('16. If we travel from city to another city, there is only indirect the transport method, then this transport has avaliable tickets').
rule_description(17):-
    write('17. If there are one connecting way from city A to city B and another connecting way from city B to city C, then there exists an indirect transport from city A to city C.').
rule_description(18):-
    write('18. If there is a christmas period for a transport, then this is also a holiday for a transport').
rule_description(19):-
    write('19. If there is a holiday for a transport, then there are lots of people').
rule_description(20):-
    write('20. If there are lots of people, then the transport ticket is expensive').
rule_description(21):-
    write('21. If this is transport is expensive and is part of a route, and has avaliable tickets then this is a valid route').
rule_description(22):-
    write('22. If a person has a license of a method, then this method is transport method.').
rule_description(23):-
    write('23. If this transport is the drive a method, then this transport is the slowest.').
rule_description(24):-
    write('24. If there is a transport method, is the slowest and is part of a route then this route is a valid route.').
rule_description(25):-
    write('25. If there is a valid route, then this route is a good route.').

%% Pretty print the system rules 
r_description(1):-
    write('1. If there are names of two person, then they are friends').
r_description(2):-
    write('2. If a person with name and a city name, then he/she lives in this city is true').
r_description(3):-
    write('3. If a person live in a city and another person lives in another city, these two persons are friends, then one person wats to travel from his city to another city').
r_description(4):-
    write('4. If there are twi cities and a person wants to travel from one to another, there is avaliable tickets on a method, then this method is a transport').
r_description(5):-
    write('5. If the forcast is sunny for a transport, then the weather is good for a transport').
r_description(6):-
    write('6. If there is a direct road connecting two locations, then this is the direct route.').
r_description(7):-
    write('7. If there are two roads, with one connecting point A to point B and another connecting point B to point C, then there exists an indirect route from point A to point C.').
r_description(8):-
    write('8. If there is a direct road connecting two locations, then we find the route between this two locations').
r_description(9):-
    write('9. If there is a direct road connecting points A and B, and we discover the route between points B and C, then we can find all the route between points A and C.').
r_description(10):-
    write('10. If there is a hotel, and a museum there is no congestion near the museum, then we choose the road bewteen hotel and museum').
r_description(11):-
    write('11. If there is a museum and the person needs to pick up his luggage in storage, then we choose the road between museum and luggage storage').
r_description(12):-
    write('12. If there is a lugguge storage and a airport, then we choose this road between luggage and airport').


r_description(13):-
    write('13. If the transport method has avaliable tickest and is part of a route from hotel to airport, we can find this route, and the weather is good, then this route is a valid route').
r_description(14):-
    write('14. If the forcast is rainy for a transport, then the weather is bad for a transport').
r_description(15):-
    write('15. If the forcast is storm for a transport, then the weather is bad for a transport').

r_description(16):-
    write('16. If we travel from city to another city, there is only indirect the transport method, then this transport has avaliable tickets').
r_description(17):-
    write('17. If there are one connecting way from city A to city B and another connecting way from city B to city C, then there exists an indirect transport from city A to city C.').
r_description(18):-
    write('18. If there is a christmas period for a transport, then this is also a holiday for a transport').
r_description(19):-
    write('19. If there is a holiday for a transport, then there are lots of people').
r_description(20):-
    write('20. If there are lots of people, then the transport ticket is expensive').
r_description(21):-
    write('21. If this is transport is expensive and is part of a route, and has avaliable tickets then this is a valid route').
r_description(22):-
    write('22. If a person has a license of a method, then this method is transport method.').
r_description(23):-
    write('23. If this transport is the drive a method, then this transport is the slowest.').
r_description(24):-
    write('24. If there is a transport method, is the slowest and is part of a route then this route is a valid route.').
r_description(25):-
    write('25. If there is a valid route, then this route is a good route.').


system_rule(Rule):-
    r_description(Rule).


