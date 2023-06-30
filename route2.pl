


conclusion(chosen_route(alex,c)).


node(1,name(alex), initial_fact, []).
node(2,name(emma), initial_fact, []).
node(3,phone(alex), initial_fact, []).
node(4,phone(emma), initial_fact, []).
node(5,friend(alex,jane), initial_fact, []).
node(6,friend(jane,emma), initial_fact, []).
node(7,talk(alex,emma), initial_fact, []).
node(8,question(alex), initial_fact, []).
node(9,warning(forcast), initial_fact, []).
node(10,high_rating(forcast), initial_fact, []).
node(11,weather_answer(forcast), initial_fact, []).
node(12,weather_question(emma), initial_fact, []).
node(13,yellow(forcast), initial_fact, []).
node(14,highway(c), initial_fact, []).


node(15,football_team(mancity), initial_fact, []).
node(16,cityroad(a), initial_fact, []).
node(17,celebrate(mancity), initial_fact, []).

rule(1,[friend(X,Y),friend(Y,Z)],friend(X,Z)).
rule(2,[phone(X),phone(Y),talk(X,Y)],call(X,Y)).

rule(3,[call(X,Y),question(X)],advice(X,Y)).

rule(4,[name(X),name(Y),friend(X,Y),advice(X,Y)],recommend(X,Y)).

rule(5,[high_rating(Z),weather_answer(Z),weather_question(X)],app(X,Z)).

rule(6,[app(Y,Z),recommend(X,Y)],download(X,Z)).

rule(7,[yellow(X)],warning(X)).
rule(8,[warning(X)],predict_rain(X)).
rule(9,[predict_rain(Z),download(X,Z)],weather_bad(X)).


rule(10,[football_team(Y)],champion(Y)).
rule(11,[champion(Y),cityroad(X)],parade(Y,X)).
rule(12,[parade(Y,X),celebrate(Y)],special_event(X)).
rule(13,[special_event(X)],major_city_event(X)).
rule(14,[major_city_event(X)],many_people(X)).
rule(15,[many_people(X)],congestion(X)).


rule(16,[name(X),weather_bad(X),highway(C),congestion(A)],chosen_route(X,C)).



