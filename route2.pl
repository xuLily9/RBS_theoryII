% agree with the same reason(conclusion is true)

user_fact(1,vaccinated(harry), initial_fact, []).
user_fact(2,vaccinated(sara), initial_fact, []).
user_fact(3,taste_and_smell(sara), initial_fact, []).
user_fact(4,taste_and_smell(harry), initial_fact, []).

user_rule(1,[not(pinged(A)), not(pinged(B)), vaccinated(A), vaccinated(B), not(symptoms(A)), not(symptoms(B))],can_meet(A, B)).
user_rule(2,[not(taste_and_smell(X))], symptoms(X)).
user_rule(3,[fever(X)],symptoms(X)).
user_rule(4,[cough(X)],symptoms(X)).

%initial_question(1,can_meet(sara, harry), 'Can Sara and harry meet?').
conclusion(route(alex, c)).


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


rule(16,[weather_bad(X),highway(C),congestion(A)],route(X,C)).



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

