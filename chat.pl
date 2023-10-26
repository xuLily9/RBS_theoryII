:- [deduce_backwards],[why_question],[whynot_question],[write_list].
:- use_module(library(random)).
:-dynamic node/4, user_fact/4, different/1, asked_question/1,n_computer_user/2,y_computer_user/2,y_user_computer/2,n_user_computer/2,yr_user_computer/3,yr_computer_user/3,computer_ask_user/2,rule_used/1,d_rule/2.

chat:-
    print_welcome,
    print_conclusion(Conclusion,F),
    assert(asked_question(F)),
    (
        Conclusion=true
    ->  ask_why(F)
    ;   
        ask_whynot(F)
    ),
    conversations(_Used,_).

print_welcome:-
    write_user_fact,
    write_user_rule.

print_conclusion(Conclusion,F):-
    write('\n----------CONVERSATION ----------\n'),nl,
    write('Computer: '),
    conclusion(F), 
    (
        deduce_backwards(F,node(_ID, F, _R, _DAG))
    ->  
        Conclusion = true, 
        print_fact(F),write(': True.\n'),
        aggregate_all(count, y_user_computer(_,_), Count1), % user knows the system believe f
        A is Count1 +1,
        assert(y_user_computer(A,F)),!,
        assert(asked_question(F)),!
    ;   
        Conclusion = false,
        print_fact(F),write(': False.\n'),
        aggregate_all(count, n_user_computer(_,_), Count2), % user knows the system does not believe f
        B is Count2 +1,
        assert(n_user_computer(B,F)),!       
    ).


ask_why(F):-    % conclusion is true and the user ask all trypes of why questions 
    repeat,
    nl,
    write('Computer: Do you agree '), print_fact(F),write(' is true?'),nl,
    true_then,
    write('User:'),read(N),
    (   N =:= 1
    ->  
        Agree=true,
        database1(Agree,F),
        write('User: [I agree]. Why do you believe '), print_fact(F), write('?\n'),
        why(F)
    ;  
         N =:= 2
    ->   
        Agree=false,
        database1(Agree,F),
        write('User: [I disagree]. Why do you believe '),print_fact(F), write('?\n'), 
        why(F)
    ;   
        N =:= 3
    ->  write('User: [I do not know]. Why do you believe '), print_fact(F), write('?\n'), 
        why(F),write('hello')

    ;   write("Not a valid choice, try again..."), nl,fail
    ).

ask_whynot(F):- % conclusion is false and the user ask all trypes of whynot questions 
    repeat,
    write('Computer: Do you agree '), print_fact(F),write(' is not true?'),nl,
    false_then,
    write('User:'),read(N),
    (   N =:= 1
    ->  
        Agree=true,
        database2(Agree,F),
        write('User: [I agree] Why do not you believe '), print_fact(F), write('?\n'),
        write('\nComputer: Because it is not an initial fact and can not be decuced from the rules.'),
        assert(asked_question(F)),nl, 
        conversations(_,_)
    ;  
         N =:= 2
    ->   Agree=false,
         database2(Agree,F),
         write('User: [I disagree] Why do not you believe '), print_fact(F), write('?\n'),
         write('\nComputer: Why do you beleive '), print_fact(F), write('? '),
         assert(asked_question(F)),nl,
         whynot(F)
    ;   
        N =:= 3
    ->  
        write('User: [I do not know] Why do not you believe '), print_fact(F), write('?\n'),whynot(F)
    ;   
        write("Computer: Not a valid choice, try again..."), nl,fail
    ).

database1(Agree,F):-   %conlcuison is true, update the state
    (   
        Agree =true
    ->  
        aggregate_all(count, y_computer_user(_,_), Count3), % computer knows user believes it
        C is Count3 +1,
        assert(y_computer_user(C,F)),!, 
        assert(asked_question(F)),!
    ;
        aggregate_all(count, n_computer_user(_,_), Count0), % computer knows user does not believe it
        A is Count0 +1,
        assert(n_computer_user(A, F)),!, 
        assert(asked_question(F)),!
    ).

database2(Agree,F):-   %conclusion is false, update the state
    (   
        Agree =true
    ->  
        aggregate_all(count, n_computer_user(_,_), Count1),
        B is Count1 +1,
        assert(n_computer_user(B,F)),!,     
        assert(asked_question(F)),!
    ;
        aggregate_all(count, y_computer_user(_,_), Count3),
        C is Count3 +1,
        assert(y_computer_user(C,F)),!,     
        assert(asked_question(F)),!
    ).


option(F):-
    repeat,
    write('\n----------User option----------\n'),nl,
    write('1. I am satisfied. Exit\n'),
    write('2. I do not have this rule or I have a slightly different rule\n'), 
    write('3. I agree. But I need more explanations. Please list all possible questions again.\n' ),
    write('4. I disagree. I need more explanations. Please list all possible questions again.\n' ), 
    write('User:'),
    prompt(_, ''),
    read(N),
    (   
        N=:= 1
     -> write('Computer:Bye\n')->halt
    ;   
        N=:= 2
    ->  rule(_R,A,F),
       ( \+ user_rule(_,A,F),
         write('\nCopmuter: I have found the disagreement. The computer used a rule that the user do not have it.\n'),nl,
         dialogue2
        ;  write('\nComputer: This computer and user both have this rule, please select again.\n'),
         dialogue2
        )
    ;   N=:= 3
    ->  write('\n----------Please select one of the question----------\n'),nl,
        question_list
    ;   N=:= 4
    ->  write('\n----------Please select one of the question----------\n'),nl,
        question_list
    ;   
        write('Not a valid choice, try again...'), nl,fail
    ). 

question_list:-
    write('1. I am satisfied. Exit\n'),
    write_why_list,!,
    write_whynot_list,!, 
    write('User:'),
    prompt(_, ''),
    read(N),
    (
        N=:= 1
     -> write('Computer:Bye\n')->halt
     ;
        N1 is N,
        y_user_computer(N1, Fact)
        ->  write('\nUser: Why do you believe '),print_fact(Fact), write('?\n'),
            assert(asked_question(Fact)),
            ask_why(Fact),
            conversations(_,_)
    ;   
        aggregate_all(count, y_user_computer(_,_), Count),
        A is N-Count,
        n_user_computer(A,Fact)
         -> write('\nUser: Why do not you believe '),print_fact(Fact), write('?\n'),
            ask_whynot(Fact),
            write('\nComputer: Because it is not an initial fact and can not be decuced from the rules.'),
            assert(asked_question(Fact)),nl, 
            conversations(_,_)
    ;   
        write('Not a valid choice, try again...'), nl,fail
    ).


conversations(_Used,_R):-
    repeat,
    write('\n----------SELECT A QUESTION OR EXIT----------\n'),nl,
    question_list.



dialogue2:-
    repeat,
    nl,
    write('Computer: Please select one of the option:\n'),
    write('1. I am satisfied. Exit\n'),
    write_why_list,!,
    write_whynot_list,!,
    write('User:'),
    prompt(_, ''),
    read(N),
    (   
        N=:= 1
     -> write('Computer:Bye\n')->halt
   ;   
        N1 is N-1,
        y_user_computer(N1, Fact)
        ->  write('\nUser: Why do you believe '),print_fact(Fact), write('?\n'),
            assert(asked_question(Fact)),
            why(Fact)
    ;   
        aggregate_all(count, y_user_computer(_,_), Count),
        A is N-Count-1,
        n_user_computer(A,Fact)
         -> write('\nUser: Why do not you believe '),print_fact(Fact), write('?\n'),
            %write('\nComputer: Why do you beleive '), print_fact(Fact), write('? '),
            write('\nComputer: Because it is not an initial fact and can not be decuced from the rules.'),
            assert(asked_question(Fact))
            %whynot(Fact)
    ;   
        write('Not a valid choice, try again...'), nl,fail
    ).
