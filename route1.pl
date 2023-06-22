% agree with the same reason(conclusion is true)

node(1,name(alex), initial_fact, []).
node(2,name(sam), initial_fact, []).
node(3,name(emma), initial_fact, []).
node(4,flight(8pm), initial_fact, []).
node(5,luggage(sam), initial_fact, []).
node(1,vaccinated(harry), initial_fact, []).
node(2,vaccinated(sara), initial_fact, []).
node(3,taste_and_smell(sara), initial_fact, []).
node(4,taste_and_smell(harry), initial_fact, []).



rule(1,[not(peak_hours(Y)),not(heavy_traffic(Y)),direct_path(Y)],route(Y,A)).
rule(2,[light_traffic(Y),country_road(Y),higher_speed_limited(Y), personal_preference(C,D)], route(Y,B)).
rule(3,[weather_bad(Y),hightway(Y),not(constrution(Y))],route(Y,C)).
rule(4,[red(X)],heavy_traffic(X)).

rule(6,[green(X)],no_incidents(X)).
rule(7,[yellow(X)],congestion(X)).
rule(8,[major_city_event(X)],yellow(X)).
rule(10,[after_school(X)],yellow(X)).
rule(11,[around_3pm(X)],after_school(X)).
rule(12,[luggage(X)],pick_up(X)).

rule(9,[parade(X)],special_event(X)).
rule(9,[concert(X)],special_event(X)).
rule(9,[sport_game(X)],special_event(X)).
rule(9,[special_event(X)],major_city_event(X)).

rule(9,[holidays(X)],seasonal_factors(X)).
rule(9,[festivals(X)],seasonal_factors(X)).
rule(9,[seasonal_factors(X)],many_people(X)).
rule(9,[many_people(X)],congestion(X)).


rule(9,[few_main_road(X)],lack_alternative_routes(X)).
rule(9,[few_highway(X)],lack_alternative_routes(X)).
rule(9,[lack_alternative_routes(X)],congestion(X)).

rule(13,[pick_up(X)],takes_30(Y)).
rule(14,[visit_friend(X)],takes_30(X)).
rule(15,[museum_visit(X)],takes_60(X)).
rule(16,[dinner(X)],resturant(X)).
rule(17,[green(Y),resturant(X)],route(Y)).
rule(18,[resturant(X),eat(X)],takes_30(X)).

rule(7,[narrow_road(X)],limited_road_apacity(X)).
rule(7,[limited_lanes(X)],limited_road_apacity(X)).
rule(7,[limited_road_apacity(X)],congestion(X)).

rule(5,[construction(X)],congestion(X)).
rule(7,[car_accident(X)],congestion(X)).
rule(7,[breakdown(X)],congestion(X)).
rule(7,[peak_hours(X)],congestion(X)).
rule(7,[weather_bad(X)],congestion(X)).
rule(7,[forcast_rain(X)],weather_bad(X)).
rule(7,[forcast_storm(X)],weather_bad(X)).
rule(7,[forcast_sunny(X)],weather_good(X)).

rule(7,[morning7_9(X)],peak_hours(X)).
rule(7,[evening5_7(X)],peak_hours(X)).
rule(7,[high_population_density(X)],high_vehicles(X)).
rule(7,[high_vehicles(X)],overwhelm_road_system(X)).
rule(7,[overwhelm_road_system(X)],heavy_traffic(X)).

rule(7,[lack_public_transportation(X)],private_vehicles(X)).
rule(7,[private_vehicles(X)],high_vehicles(X)).


rule(7,[lane_closures(X)],traffic_volume(X)).
rule(7,[traffic_volume(X)],cause_delays(X)).
rule(7,[poorly_traffic_signals(X)],cause_delays(X)).

rule(7,[evening5_7(X)],peak_hours(X)).

rule(9,[value_serene(X),scenic_drive(D)],personal_preference(C,D)).



user_fact(1,vaccinated(harry), initial_fact, []).
user_fact(2,vaccinated(sara), initial_fact, []).
user_fact(3,taste_and_smell(sara), initial_fact, []).
user_fact(4,taste_and_smell(harry), initial_fact, []).

user_rule(1,[not(pinged(A)), not(pinged(B)), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B))],can_meet(A, B)).
user_rule(2,[not(taste_and_smell(X))], symptoms(X)).
user_rule(3,[fever(X)],symptoms(X)).
user_rule(4,[pass(A),pass(B)],arrive(A,B)).

%initial_question(1,can_meet(sara, harry), 'In order to arriving the airport in time, which route do you think alex choose?').
conclusion(route(alex,b)).


fact_description(not(pinged(A))):-
    write(A), write(' has not been in close contact with someone who has Covid-19 ').
fact_description(pinged(A)):-
    write(A), write(' has been in close contact with someone who has Covid-19 ').
fact_description(vaccinated(A)):-
    write(A), write(' is vaccinated').
fact_description(taste_and_smell(X)):-
    write(X), write(' has the taste and smell').
fact_description(symptoms(X)):-
    write(X), write(' has symptoms').
fact_description(not(symptoms(X))):-
    write(X), write(' does not have any symptoms').
fact_description(not(taste_and_smell(X))):-
    write(X), write(' does not have taste and smell').
fact_description(can_meet(A, B)):-
    write(A), write(' and '), write(B),write(' can meet').
fact_description(fever(X)):-
    write(X), write(' has a fever').
fact_description(cough(X)):-
    write(X), write(' has a cough').

rule_description(1):-
    write('1. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, then A and B can meet.').
rule_description(2):-
    write('2. If X does not have taste or smell, then X has symptoms.').
rule_description(3):-
    write('3. If X has a fever, then X has symptoms.').
    
rule_description(4):-
    
    write('4. If X has a cough, then X has symptoms.').
%% Pretty print the system rules 
r_description(1):-
    write('1. If both A and B are vaccinated, and none of them have been pinged(close contact with someone who has Covid-19), and none of them have symptoms, then A and B can meet.'),nl.
r_description(2):-
    write('2. If X does not have taste or smell, then X has symptoms.'),nl.
r_description(3):-
    write('3. If X has a fever, then X has symptoms.'),nl.
r_description(4):-
    write('4. If X has a cough, then X has symptoms.'),nl.
system_rule(Rule):-
    r_description(Rule).

