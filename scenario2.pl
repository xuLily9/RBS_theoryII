% The user and computer disagree with the different rule
% conclusion is true, rule 23 is different
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
rule(4,[forcast_sunny(X)],weather_good(X)).
rule(5,[road(X,Y)],direct_route(X,Y)).
rule(6,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
rule(7,[direct_route(X,Y)],find_route(X, Y)).
rule(8,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).
rule(9,[hotel(X),museum(Y),not(congestion(Y))],road(X,Y)).
rule(10,[museum(X),luggage(Y)],road(X,Y)).
rule(11,[luggage(X),airport(Y)],road(X,Y)).
rule(12,[light_traffic(Y),transport(X),available(X),hotel(A),airport(B),find_route(A, B)],valid_route(Y)).

rule(13,[forcast_rain(X)],weather_bad(X)).
rule(14,[forcast_storm(X)],weather_bad(X)).

%the train for route a 

rule(15,[christmas(X)],holiday(X)).
rule(16,[holiday(X)],special_event(X)).
rule(17,[special_event(Y)],major_city_event(Y)).
rule(18,[major_city_event(Y)],many_people(Y)).
rule(19,[transport(X),costy(X)],quickest(X)).
rule(20,[many_people(Y),route_name(Y),quickest(X),costy(X)],valid_route(Y)).

% the car for route b

rule(21,[drive(X)],slowest(X)).
rule(22,[transport(X),slowest(X),route_name(Y)],valid_route(Y)).

rule(23,[valid_route(X),light_traffic(X)],good_route(X)).

conclusion(good_route(c)).


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
user_fact(11,transport(flight), initial_fact, []).
user_fact(12,light_traffic(c), initial_fact, []).

% fact for route a 
user_fact(13,transport(train), initial_fact, []).
user_fact(14,holiday(a), initial_fact, []).
user_fact(15,costy(train), initial_fact, []).
user_fact(16,route_name(a), initial_fact, []).

%fact for route b
user_fact(17,license(car), initial_fact, []).
user_fact(18,drive(car), initial_fact, []).
user_fact(19,route_name(b), initial_fact, []).
user_fact(20,transport(car), initial_fact, []).

user_rule(1,[name(A),name(B)],friend(A,B)).
user_rule(2,[name(A),city(X)],live(A,X)).
user_rule(3,[friend(A,B),live(A,X),live(B,Y)],travel(X,Y)).
user_rule(4,[forcast_sunny(X)],weather_good(X)).
user_rule(5,[road(X,Y)],direct_route(X,Y)).
user_rule(6,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
user_rule(7,[direct_route(X,Y)],find_route(X, Y)).
user_rule(8,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).
user_rule(9,[hotel(X),museum(Y),not(congestion(Y))],road(X,Y)).
user_rule(10,[museum(X),luggage(Y)],road(X,Y)).
user_rule(11,[luggage(X),airport(Y)],road(X,Y)).
user_rule(12,[light_traffic(Y),transport(X),available(X),hotel(A),airport(B),find_route(A, B)],valid_route(Y)).

user_rule(13,[forcast_rain(X)],weather_bad(X)).
user_rule(14,[forcast_storm(X)],weather_bad(X)).

%the train for route a 

user_rule(15,[christmas(X)],holiday(X)).
user_rule(16,[holiday(X)],special_event(X)).
user_rule(17,[special_event(Y)],major_city_event(Y)).
user_rule(18,[major_city_event(Y)],many_people(Y)).
user_rule(19,[transport(X),costy(X)],quickest(X)).
user_rule(20,[many_people(Y),route_name(Y),quickest(X),costy(X)],valid_route(Y)).

% the car for route b

user_rule(21,[drive(X)],slowest(X)).
user_rule(22,[transport(X),slowest(X),route_name(Y)],valid_route(Y)).

user_rule(23,[valid_route(X),quickest(X)],good_route(X)).

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
fact_description(light_traffic(X)):-
    write(X),write(' route has light traffic').

fact_description(direct_route(X,Y)):-
    write('it is a direct road from '), write(X), write(' to '),write(Y).
fact_description(indirect_route(X,Y)):-
    write('it is an indirect road from '), write(X), write(' to '),write(Y).
fact_description(quickest(X)):-
    write(X), write(' method is the quickest').
fact_description(costy(X)):-
    write(X), write(' method is costy').
fact_description(find_route(X, Y)):-
    write('we find aroute from '), write(X), write(' to '),write(Y).


fact_description(christmas(X)):-
    write(X), write(' is taken during christmas period').
fact_description(special_event(X)):-
    write('there is a special event in road '),write(X).
fact_description(major_city_event(X)):-
    write('there is a major city event in road '),write(X).
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
    write('1. If two individuals have names A and B, then they are considered friends').
rule_description(2):-
    write('2. If a person name is A and a city X then this person lives in this city').
rule_description(3):-
    write('3. If there are two friends, one person lives in city X and another person lives in city Y then one person want to travel from city X to Y ').
rule_description(4):-
    write('4. If there is a forecast indicating that X will be sunny, then the weather for X is considered good ').
rule_description(5):-
    write('5. If there is a direct road connecting two locations, then this is the direct route.').
rule_description(6):-
    write('6. If there are two roads, with one connecting point A to point B and another connecting point B to point C, then there exists an indirect route from point A to point C.').
rule_description(7):-
    write('7. If there is a direct road connecting two locations, then we find the route between this two locations').
rule_description(8):-
    write('8. If there is a direct road connecting points A and B, and we discover the route between points B and C, then we can find all the route between points A and C.').
rule_description(9):-
    write('9. If there is a hotel, and a museum there is no congestion near the museum, then we choose the road bewteen hotel and museum').
rule_description(10):-
    write('10. If there is a museum and the person needs to pick up his luggage in storage, then we choose the road between museum and luggage storage').
rule_description(11):-
    write('11. If there is a lugguge storage and a airport, then we choose this road between luggage and airport').
rule_description(12):-
    write('12. If the transport method has avaliable tickest and is part of a route from hotel to airport, we can find this route, then this route is a valid route').
rule_description(13):-
    write('13. If the forcast is rainy for a transport, then the weather is bad for a transport').
rule_description(14):-
    write('14. If the forcast is storm for a transport, then the weather is bad for a transport').

rule_description(15):-
    write('15. If there is a christmas period for a transport, then this is also a holiday for a transport').
rule_description(16):-
    write('16. If there is a holiday for a transport, then there is a special event').
rule_description(17):-
    write('17. If an event is categorized as a special event, then it is also categorized as a major city event').
rule_description(18):-
    write('18. If there is a major city event, then there are lots of people').
rule_description(19):-
    write('19. If the mode of transport denoted by X is both expensive and considered costly, then X is considered the quickest mode of transport.').
rule_description(20):-
    write('20. If a route has many people and is associated with a route name Y, and the mode of transport denoted by X is considered the quickest and costly, then the route named Y is considered valid.').
rule_description(21):-
    write('21. If you drive a mode of transport denoted by X, then X is considered the slowest mode of transport.').
rule_description(22):-
    write('22.  If the mode of transport denoted by X is the slowest and there is a route name Y associated, then the route named Y is considered valid.').
rule_description(23):-
    write('23. If there is a valid route and it is the quickest, then this route is a good route.').


%% Pretty print the system rules 
r_description(1):-
    write('1. If two individuals have names A and B, then they are considered friends').
r_description(2):-
    write('2. If a person name is A and a city X then this person lives in this city').
r_description(3):-
    write('3. If there are two friends, one person lives in city X and another person lives in city Y then one person want to travel from city X to Y ').
r_description(4):-
    write('4. If there is a forecast indicating that X will be sunny, then the weather for X is considered good ').
r_description(5):-
    write('5. If there is a direct road connecting two locations, then this is the direct route.').
r_description(6):-
    write('6. If there are two roads, with one connecting point A to point B and another connecting point B to point C, then there exists an indirect route from point A to point C.').
r_description(7):-
    write('7. If there is a direct road connecting two locations, then we find the route between this two locations').
r_description(8):-
    write('8. If there is a direct road connecting points A and B, and we discover the route between points B and C, then we can find all the route between points A and C.').
r_description(9):-
    write('9. If there is a hotel, and a museum there is no congestion near the museum, then we choose the road bewteen hotel and museum').
r_description(10):-
    write('10. If there is a museum and the person needs to pick up his luggage in storage, then we choose the road between museum and luggage storage').
r_description(11):-
    write('11. If there is a lugguge storage and a airport, then we choose this road between luggage and airport').
r_description(12):-
    write('12. If the transport method has avaliable tickest and is part of a route from hotel to airport, we can find this route, then this route is a valid route').
r_description(13):-
    write('13. If the forcast is rainy for a transport, then the weather is bad for a transport').
r_description(14):-
    write('14. If the forcast is storm for a transport, then the weather is bad for a transport').

r_description(15):-
    write('15. If there is a christmas period for a transport, then this is also a holiday for a transport').
r_description(16):-
    write('16. If there is a holiday for a transport, then there is a special event').
r_description(17):-
    write('17. If an event is categorized as a special event, then it is also categorized as a major city event').
r_description(18):-
    write('18. If there is a major city event, then there are lots of people').
r_description(19):-
    write('19. If the mode of transport denoted by X is both expensive and considered costly, then X is considered the quickest mode of transport.').
r_description(20):-
    write('20. If a route has many people and is associated with a route name Y, and the mode of transport denoted by X is considered the quickest and costly, then the route named Y is considered valid.').
r_description(21):-
    write('21. If you drive a mode of transport denoted by X, then X is considered the slowest mode of transport.').
r_description(22):-
    write('22.  If the mode of transport denoted by X is the slowest and there is a route name Y associated, then the route named Y is considered valid.').
r_description(23):-
    write('23. If there is a valid route and it is the quickest, then this route is a good route.').

system_rule(Rule):-
    r_description(Rule).


