node(1,name(alex), initial_fact, []).
node(2,name(emma), initial_fact, []).
node(3,friend(alex,emma), initial_fact, []).
node(4,call(alex,emma), initial_fact, []).
node(5,give_advice(forcast), initial_fact, []).
node(6,app(forcast), initial_fact, []).
node(7,smile(forcast), initial_fact, []).
node(8,need_gas(car), initial_fact, []).
%node(8,road(00,10), initial_fact, []).
%node(9,road(10,20), initial_fact, []).
%node(10,road(20,30), initial_fact, []).
node(9,gas(00), initial_fact, []).
node(10,park(10), initial_fact, []).
node(11,school(20), initial_fact, []).
node(12,airport(30), initial_fact, []).
node(13,green(c), initial_fact, []).
node(14,drive(car), initial_fact, []).
node(15,highway(20,30), initial_fact, []).
node(16,route_set(a,b,c), initial_fact, []).
node(17,football_team(mancity), initial_fact, []).
node(18,cityroad(a), initial_fact, []).
node(19,celebrate(mancity), initial_fact, []).
node(20,narrow_road(b), initial_fact, []).
node(21,more_traffic_light(b), initial_fact, []).
node(22,country_road(b), initial_fact, []).


rule(1,[friend(X,Z),call(X,Z),give_advice(W)],take_advice(X,W)).
rule(2,[app(W),take_advice(X,W)],download(X,W)).
rule(3,[smile(W)],predict_sunny(W)).
rule(4,[predict_sunny(W),download(X,W)],weather_sunny(X)).
rule(5,[green(X)],light_traffic(X)).
rule(6,[road(X,Y)],direct_route(X,Y)).
rule(7,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
rule(8,[direct_route(X,Y)],find_route(X, Y)).
rule(9,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).
rule(10,[gas_station(X),park(Y),not(congestion(Y))],road(X,Y)).
rule(11,[park(X),school(Y),not(peak_hours(Y))],road(X,Y)).
rule(12,[school(X),airport(Y),highway(X,Y)],road(X,Y)).
rule(13,[drive(Y),need_gas(Y),gas(X)],gas_station(X)).
rule(14,[light_traffic(C),weather_sunny(X),gas_station(A),airport(B),find_route(A, B),name(X)],valid_route(C)).
rule(15,[route_set(A,B,C),not(valid_route(A)),not(valid_route(B)),valid_route(C)],choose_route(C)).

rule(16,[football_team(Y)],champion(Y)).
rule(17,[champion(Y),cityroad(X)],parade(Y,X)).
rule(18,[parade(Y,X),celebrate(Y)],special_event(X)).
rule(19,[special_event(X)],major_city_event(X)).
rule(20,[major_city_event(X)],many_people(X)).
rule(21,[many_people(X)],congestion(X)).
rule(22,[not(congestion(X)),cityroad(X)],valid_route(X)).

rule(23,[narrow_road(X)],limited_road_capacity(X)).
rule(24,[limited_road_capacity(X),more_traffic_light(X)],long_path(X)).
rule(25,[not(long_path(X)),country_road(X)],valid_route(X)).

conclusion(choose_route(c)).

user_fact(1,name(alex), initial_fact, []).
user_fact(2,name(emma), initial_fact, []).
user_fact(3,friend(alex,emma), initial_fact, []).
user_fact(4,call(alex,emma), initial_fact, []).
user_fact(5,give_advice(forcast), initial_fact, []).
user_fact(6,app(forcast), initial_fact, []).
user_fact(7,smile(forcast), initial_fact, []).
user_fact(8,need_gas(car), initial_fact, []).
%node(8,road(00,10), initial_fact, []).
%user_fact(9,road(10,20), initial_fact, []).
%user_fact(10,road(20,30), initial_fact, []).
user_fact(9,gas(00), initial_fact, []).
user_fact(10,park(10), initial_fact, []).
user_fact(11,school(20), initial_fact, []).
user_fact(12,airport(30), initial_fact, []).
user_fact(13,green(c), initial_fact, []).
user_fact(14,drive(car), initial_fact, []).
user_fact(15,highway(20,30), initial_fact, []).
user_fact(16,route_set(a,b,c), initial_fact, []).
user_fact(17,football_team(mancity), initial_fact, []).
user_fact(18,cityroad(a), initial_fact, []).
user_fact(19,celebrate(mancity), initial_fact, []).
user_fact(20,narrow_road(b), initial_fact, []).
user_fact(21,more_traffic_light(b), initial_fact, []).
user_fact(22,country_road(b), initial_fact, []).

user_rule(1,[friend(X,Z),call(X,Z),give_advice(W)],take_advice(X,W)).
user_rule(2,[app(W),take_advice(X,W)],download(X,W)).
user_rule(3,[smile(W)],predict_sunny(W)).
user_rule(4,[predict_sunny(W),download(X,W)],weather_sunny(X)).
user_rule(5,[green(X)],light_traffic(X)).
user_rule(6,[road(X,Y)],direct_route(X,Y)).
user_rule(7,[direct_route(X,Y),direct_route(Y,Z)],indirect_route(X,Z)).
user_rule(8,[direct_route(X,Y)],find_route(X, Y)).
user_rule(9,[direct_route(X, Z),find_route(Z, Y)],find_route(X, Y)).

user_rule(10,[gas_station(X),park(Y),not(congestion(Y))],road(X,Y)).
user_rule(11,[park(X),school(Y),not(peak_hours(Y))],road(X,Y)).
user_rule(12,[school(X),airport(Y),highway(X,Y)],road(X,Y)).
user_rule(13,[drive(Y),need_gas(Y),gas(X)],gas_station(X)).
user_rule(14,[light_traffic(C),weather_sunny(X),gas_station(A),airport(B),find_route(A, B),name(X)],valid_route(C)).
user_rule(15,[route_set(A,B,C),valid_route(C),not(valid_route(A)),not(valid_route(B))],choose_route(C)).
user_rule(16,[football_team(Y)],champion(Y)).
user_rule(17,[champion(Y),cityroad(X)],parade(Y,X)).
user_rule(18,[parade(Y,X),celebrate(Y)],special_event(X)).
user_rule(19,[special_event(X)],major_city_event(X)).
user_rule(20,[major_city_event(X)],many_people(X)).
user_rule(21,[many_people(X)],congestion(X)).
user_rule(22,[not(congestion(X)),cityroad(X)],valid_route(X)).

user_rule(23,[narrow_road(X)],limited_road_capacity(X)).
user_rule(24,[limited_road_capacity(X),more_traffic_light(X)],long_path(X)).
user_rule(25,[not(long_path(X)),country_road(X)],valid_route(X)).

fact_description(narrow_road(X)):-
   write(X), write(' is a narrow road').
fact_description(country_road(X)):-
    write(X), write(' is a country road').
fact_description(more_traffic_light(X)):-
    write('there are more traffic lights in this road '),write(X).
fact_description(limited_road_capacity(X)):-
    write(X),write(' has limited road capacity').
fact_description(long_path(X)):-
    write(X),write(' is a long path').

fact_description(football_team(X)):-
    write('the name of ffotball team is '), write(X).
fact_description(cityroad(X)):-
    write(X), write(' is a city road').
fact_description(celebrate(X)):-
    write(X), write(' is celebrated ').
fact_description(champion(X)):-
    write(X),write(' is the champion').
fact_description(parade(Y,X)):-
     write(' there is a parade about football team'), write(Y), write(' in city road'),write(X).
fact_description(special_event(X)):-
    write('there is a special event in road '),write(X).
fact_description(major_city_event(X)):-
    write('there is a major city event in road '),write(X).
fact_description(many_people(X)):-
    write('there are lots of people in road '),write(X).
%fact_description(congestion(X)):-
    %write('there is congestion in road '),write(X).
fact_description(congestion(Y)):-
    write('in location '), write(Y), write(' ,there is a congestion').

fact_description(name(X)):-
    write('his/her name is '), write(X).
fact_description(friend(X,Y)):-
    write(X), write(' and '),write(Y),write(' are friends').
fact_description(call(X,Y)):-
    write(X), write(' called '),write(Y).
fact_description(give_advice(X)):-
     write('his/her firends gave advice about app called '),write(X).
fact_description(app(X)):-
    write('app name is '),write(X).
fact_description(smile(X)):-
    write('there is a smile emoji showed on app '),write(X).

fact_description(need_gas(X)):-
    write(X), write(' needs gas').
fact_description(road(X,Y)):-
    write('we choose this road from '), write(X), write(' to '),write(Y).
fact_description(gas_station(X)):-
    write('gas station is at location '),write(X).
fact_description(gas(X)):-
   write(X), write(' has gas').
fact_description(park(X)):-
    write('park is at location '),write(X).
fact_description(school(X)):-
    write('school is at location '),write(X).
fact_description(airport(X)):-
    write('airport is at location '),write(X).
fact_description(green(X)):-
    write('the app shows route '),write(X),write(' is green').
fact_description(drive(X)):-
    write('he/She can dive'),write(X).

fact_description(take_advice(X,W)):-
   write(X), write(' took the advice about '),write(W).
fact_description(download(X,W)):-
   write(X), write(' downloaded the app '),write(W).
fact_description(predict_sunny(W)):-
    write(W),write('predictes it is a sunny day').
fact_description(light_traffic(X)):-
    write(X),write(' route has light traffic').
fact_description(direct_route(X,Y)):-
    write('it is a direct road from '), write(X), write(' to '),write(Y).
fact_description(indirect_route(X,Y)):-
    write('it is an indirect road from '), write(X), write(' to '),write(Y).
fact_description(find_route(X, Y)):-
    write('we find aroute from '), write(X), write(' to '),write(Y).
fact_description(not(congestion(Y))):-
    write('in location '), write(Y), write(' ,there is no congestion').

fact_description(weather_sunny(X)):-
    write(X), write(' knows it is a sunny day').
fact_description(peak_hours(X)):-
    write('it is the peak hours for '),write(X).
fact_description(not(peak_hours(X))):-
    write('it is not the peak hours for '),write(X).
fact_description(highway(X,Y)):-
    write('from '),write(X),write(' to '),write(Y),write(' is a highway road').

fact_description(choose_route(X)):-
    write('he/she will choose the route: '), write(X).
fact_description(route_set(A,B,C)):-
    write(A),write(','),write(B),write(','),write(C), write(' is a route set').
    
fact_description(valid_route(X)):-
    write(X), write(' is a valid route').
fact_description(not(valid_route(X))):-
    write(X), write(' is not a valid route').

rule_description(1):-
    write('1. If two friends talk on the phone and one of them offers advice, then the other buddy follows that advice.').
rule_description(2):-
    write('2. If one person take the advice about an app, then this person downloaded that app').
rule_description(3):-
    write('3. If there is a smile emogi in the app, then this app predict it is a sunny day').
rule_description(4):-
    write('4. If one person download an app and this app predicted it is a sunny day, then this person knows today is a sunny day'). 
rule_description(5):-
    write('5. If it shows green about an route, then there is light traffic on this route').
rule_description(6):-
    write('6. If there is a direct road connecting two locations, then this is the direct route.').
rule_description(7):-
    write('7. If there are two roads, with one connecting point A to point B and another connecting point B to point C, then there exists an indirect route from point A to point C.').
rule_description(8):-
    write('8. If there is a direct road connecting two locations, then we find the route between this two locations').
rule_description(9):-
    write('9. If there is a direct road connecting points A and B, and we discover the route between points B and C, then we can find all the route between points A and C.').
rule_description(10):-
    write('10. If there is a gas station, and a park, there is no congestion in park, then we choose the road bewteen gas station and park').
rule_description(11):-
    write('11. If there is a park and a school and it is not the peak hours for school, then we choose the road between park and school').
rule_description(12):-
    write('12. If there is a school and a airport, and there is a highway between these two places, then we choose this road between school and airport').
rule_description(13):-
    write('13. If one person dives a car and the car needs gas, then this person needs to go to gas station').
rule_description(14):-
    write('14. If there is a light traffic, and this person knows the weather is sunny, he/she need go from gas station to airport, then he choose valid route').
rule_description(15):-
    write('15. If there is a route set, only one of them is valid, then he/she will choose that route').

rule_description(16):-
    write('16. If there is a footable team win the final match, then this footbal team is the champion').
rule_description(17):-
    write('17. if there is a champion football team and a main city road, then theere will be a parade event in this city road').
rule_description(18):-
    write('18. If there is parade about a champion footbal team in the city road and this footabll team is celerabte it, then this is a spcial event').
rule_description(19):-
    write('19. If this is a special event, then this is also a major city event').
rule_description(20):-
    write('20. If there is a major city event, then there are lots of people').
rule_description(21):-
    write('21. If there are lots of people, then there is a congestion').
rule_description(22):-
    write('22. If there is no congestion in the road, then this road is valid').
rule_description(23):-
    write('23. If there is a narrow road, then this road has limited road capacity').
rule_description(24):-
    write('24. If there this road has limited capacity and it has more traffic lights, then this road is a long path').
rule_description(25):-
    write('25. If there is a short path and it is a country road, then this road is valid').

%% Pretty print the system rules 
r_description(1):-
    write('1. If two friends talk on the phone and one of them offers advice, then the other buddy follows that advice.'),nl.
r_description(2):-
    write('2. If one person take the advice about an app, then this person downloaded that app'),nl.
r_description(3):-
    write('3. If there is a smile emogi in the app, then this app predict it is a sunny day'),nl.
r_description(4):-
    write('4. If one person download an app and this app predicted it is a sunny day, then this person knows today is a sunny day'),nl. 
r_description(5):-
    write('5. If it shows green about an route, then there is light traffic on this route'),nl.
r_description(6):-
    write('6. If there is a direct road connecting two locations, then this is the direct route.'),nl.
r_description(7):-
    write('7. If there are two roads, with one connecting point A to point B and another connecting point B to point C, then there exists an indirect route from point A to point C.'),nl.
r_description(8):-
    write('8. If there is a direct road connecting two locations, then we find the route between this two locations'),nl.
r_description(9):-
    write('9. If there is a direct road connecting points A and B, and we discover the route between points B and C, then we can find all the route between points A and C.'),nl.
r_description(10):-
    write('10. If there is a gas station, and a park, there is no congestion in park, then we choose the road bewteen gas station and park'),nl.
r_description(11):-
    write('11. If there is a park and a school and it is not the peak hours for school, then we choose the road between park and school').

r_description(12):-
    write('12. If there is a school and a airport, and there is a highway between these two places, then we choose this road between school and airport').
r_description(13):-
    write('13. If one person dives a car and the car needs gas, then this person needs to go to gas station'),nl.
r_description(14):-
    write('14. If there is a light traffic, and this person knows the weather is sunny, he/she need go from gas station to airport, then this route ia a  valid route to choose'),nl.
r_description(15):-
    write('15. If there is a route set, only one of them is valid, then he/she will choose that route').
r_description(16):-
    write('16. If there is a footable team win the final match, then this footbal team is the champion').
r_description(17):-
    write('17. if there is a champion football team and a main city road, then theere will be a parade event in this city road').
r_description(18):-
    write('18. If there is parade about a champion footbal team in the city road and this footabll team is celerabte it, then this is a spcial event').
r_description(19):-
    write('19. If this is a special event, then this is also a major city event').
r_description(20):-
    write('20. If there is a major city event, then there are lots of people').
r_description(21):-
    write('21. If there are lots of people, then there is a congestion').
r_description(22):-
    write('22. If there is no congestion in the road, then this road is valid').
r_description(23):-
    write('23. If there is a narrow road, then this road has limited road capacity').
r_description(24):-
    write('24. If there this road has limited capacity and it has more traffic lights, then this road is a long path').
r_description(25):-
    write('25. If there is a short path and it is a country road, then this road is valid').


system_rule(Rule):-
    r_description(Rule).



