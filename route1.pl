% agree with the same reason(conclusion is true)

node(1,name(alex), initial_fact, []).
node(2,name(sam), initial_fact, []).
node(3,driver(sam), initial_fact, []).
node(4,taxi(sam), initial_fact, []).
node(5,name(emma), initial_fact, []).
node(6,flight(8pm), initial_fact, []).
node(7,luggage(emma), initial_fact, []).
node(8,two_decades(sam), initial_fact, []).
node(9,airport(sam), initial_fact, []).
node(10,heavy_traffic(a), initial_fact, []).
node(11,parade(c), initial_fact, []).


rule(1,[two_decades(X),airport(X)],well_experience(X)).
rule(2,[driver(X),taxi(X),name(X),well_experience(X)],ask(X)).
rule(3,[direct(Y), less_traffic_light(Y)],short_path(Y)).
rule(4,[ask(X), not(heavy_traffic(A)),short_path(A)],route(A)).

rule(5,[not(direct(B))],longer_path(B)).
rule(6,[more_traffic_light(B)],longer_path(B)).
rule(7,[ask(X), longer_path(B),not(congestion(B)), country_road(B)],route(B)).
rule(8,[ask(X), hightway(C),not(accident(C))],route(C)).

rule(9,[not(peak_hours(A)),not(red(A)),short_path(A)],route(A)).
rule(10,[green(B),country_road(B),higher_speed_limited(B), personal_preference(C,D)], route(B)).
rule(11,[weather_bad(C),hightway(C),not(constrution(C))],route(C)).

rule(12,[forcast_rain(X)],weather_bad(X)).
rule(13,[forcast_storm(X)],weather_bad(X)).
rule(14,[forcast_sunny(X)],weather_good(X)).


rule(15,[narrow_road(X)],limited_road_apacity(X)).
rule(16,[limited_lanes(X)],limited_road_apacity(X)).
rule(17,[limited_road_apacity(X)],congestion(X)).
rule(18,[construction(X)],congestion(X)).
rule(19,[breakdown(X)],congestion(X)).
rule(20,[peak_hours(X)],congestion(X)).
rule(21,[weather_bad(X)],congestion(X)).

rule(22,[parade(X)],special_event(X)).
rule(23,[concert(X)],special_event(X)).
rule(24,[sport_game(X)],special_event(X)).
rule(25,[special_event(X)],major_city_event(X)).
rule(26,[major_city_event(X)],congestion(X)).

rule(27,[holidays(X)],seasonal_factors(X)).
rule(28,[festivals(X)],seasonal_factors(X)).
rule(29,[seasonal_factors(X)],many_people(X)).
rule(30,[many_people(X)],congestion(X)).

rule(31,[few_main_road(X)],lack_alternative_routes(X)).
rule(32,[few_highway(X)],lack_alternative_routes(X)).
rule(33,[lack_alternative_routes(X)],congestion(X)).

rule(34,[lane_closures(X)],heavy_traffic(X)).
rule(35,[heavy_traffic(X)],cause_delays(X)).
rule(36,[poorly_traffic_signals(X)],cause_delays(X)).

rule(37,[lack_public_transportation(X)],private_vehicles(X)).
rule(38,[private_vehicles(X)],high_vehicles(X)).
rule(39,[morning7_9(X)],peak_hours(X)).
rule(40,[evening5_7(X)],peak_hours(X)).
rule(41,[peak_hours(X)],high_vehicles(X)).
rule(42,[high_population_density(X)],high_vehicles(X)).
rule(43,[high_vehicles(X)],overwhelm_road_system(X)).
rule(44,[overwhelm_road_system(X)],heavy_traffic(X)).

rule(45,[car_accident(C)],accident(C)).
rule(46,[accident(C)],heavy_traffic(C)).
rule(47,[heavy_traffic(X)],congestion(X)).
rule(48,[congestion(X)],red(X)).


rule(49,[not(accident(X))],no_incidents(X)).
rule(50,[no_incidents(X)],green(X)).
rule(51,[not(peak_hours(X)],light_traffic(X)).
rule(52,[light_traffic(X)],green(X)).


rule(53,[around_3pm(X)],after_school(X)).
rule(54,[after_school(X)],yellow(X)).

rule(55,[luggage(X)],pick_up(X)).


rule(56,[pick_up(X)],takes_30(Y)).
rule(57,[visit_friend(X)],takes_30(X)).
rule(58,[museum_visit(X)],takes_60(X)).
rule(59,[dinner(X)],resturant(X)).
rule(60,[green(Y),resturant(X)],route(Y)).
rule(61,[resturant(X),eat(X)],takes_30(X)).

rule(62,[value_serene(C),scenic_drive(D)],personal_preference(C,D)).


%initial_question(1,route(b), 'In order to arriving the airport in time, which route do you think alex choose?').
conclusion(route(b)).



