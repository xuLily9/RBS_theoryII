whynot(F):-
    repeat,
    write('\n----------Please state your reason----------\n'),nl,
    write_reason,
    write('User: '),
    prompt(_, ''),
    read(Number),
    (   Number  =:= 1
    ->  initial_fact_check(F),nl
    ;   Number =:= 2
    ->  reason_rule(F),nl, !
    ;   Number =:= 3
    ->  write('Computer: Bye\n')->halt
    ;
        write('Not a valid choice, try again...'), nl, fail
    ).
    
initial_fact_check(F):-
     ( 
        user_fact(_,F,initial_fact,_)
        %\+ node(_N, F,_, _)
        -> (    write('User: Because '),print_fact(F),write(' is an initial fact.'),nl, 
                aggregate_all(count, y_computer_user(_,_), X),
                %aggregate_all(count, n_user_computer(_,_), Y),
                X1 is X +1,
                %Y1 is Y+1,
                assert(y_computer_user(X1,F)),!
               % assert(n_user_computer(Y1,F)),!,
               % write('Computer: I have found the disagreement '), 
               % print_fact(F),
               % write(' is an initial fact of user, but the computer neither believes nor infers it.\n'),nl,
               % assert(different(F)),!
        )
    ; (
        \+user_fact(_,F,initial_fact,_)
        ->write('\nComputer: I have checked. It is not an initial user fact, please select another reason.'),nl,whynot(F),nl,fail
        )
    ).

reason_rule(Fact):-
    repeat,
    write('\n-------Please select a rule number from related rule sets:-------\n'),nl,
    findall(N, user_rule(N, _Antecedants, Fact),Ruleset),
    write_element(Ruleset),
    last(Ruleset, Count),
    Restart is Count+1,
    write(Restart),write('. Restart to choose another reason\n'),
    Eixt is Restart+1,
    write(Eixt),write('. Exit\n'),
    write('User: '),
    prompt(_, ''),
    read(N),nl,     
    (  N=:=Eixt
    ->  write('Computer:Bye\n')->halt
    ;  N=:=Restart
    ->  write('\nComputer: Why do you believe '), print_fact(Fact), write('? '),
        whynot(Fact)
    ;   
        user_rule(N, A, Fact),
        check(A, _),
        user_question_list
        %write(A),
  
    ;   
        write('Not a valid choice, try again...'), nl, fail).

user_question_list:-
    write('\n----------Answer A QUESTION OR EXIT----------\n'),nl,
    write('1. I am satisfied. Exit\n'),
    write_w_list,
    write_x_list,
    write('user:'),
    prompt(_, ''),
    read(P),
    (
          P=:= 1
        -> write('Computer:Bye\n')->halt
    ;
        N1 is P-1,
        y_computer_user(N1, Question)
    ->  write('\nComputer: Why do you believe '),print_fact(Question), write('?\n'),
        assert(asked_question(Question)),
        whynot(Question)
        %initial_fact_check(Question),
        %conversations(_,_)
        
    ;   
        aggregate_all(count, y_computer_user(_,_), Count),
        A1 is P-Count-1,
        n_computer_user(A1,Question2)
         -> write('\nComputer: Why do not you believe '),print_fact(Question2), write('?\n'),
            write('\nUser: Because it is not an initial fact and can not be decuced from the rules.'),
            assert(asked_question(Question2)),nl 
            %conversations(_,_)
     ;   
        write('Not a valid choice, try again...'), nl,fail
    ).


check([],[]).
check([not(H)|T], N):-
    \+ deduce_user(H, _DAG),!, 
    %write(H),
    %assert(n_computer_user(_,H)),
    check(T, N).

check([H|T], [H|N]):-
    \+ deduce_user(H, _DAG),!, 
    %write(H),
    (   %\+n_computer_user(_,H)
    
        aggregate_all(count, n_computer_user(_,_), Count1),
        Number is Count1 +1,
       % write(Number),
        assert(n_computer_user(Number,H))
        ),
    check(T, N).

check([H|T], N):-
    deduce_user(H,_DAG),
    %write(H),
    (   \+y_computer_user(_,H)
    ->  
        aggregate_all(count, y_computer_user(_,_), Count4),
        Num is Count4 +1,
        assert(y_computer_user(Num,H))
    ;
    check(T,N)
    ).

pretty_list([],"").
pretty_list([Head|Tail],Out):-
    print_top(Head,_HeadPretty),
    pretty_list(Tail,Out).

print_top(Fact,_Pretty):-
    user_fact(_,Fact,Rule,_)
    ->assert(d_rule(Fact,Rule)).

%% LOUISE: Computer adds all positive literals in A to Y_computer_user
    %% LOUISE: Computer adds all negative literals in a to N_computer user
    %% LOUISE: Computer then selects a fact that is in Y_computer_user and is not a node and asks
    %% why the user believes that fact.
    %% OR the computer picks a fact that is in N_computer_user and is a node and asks why the user
    %% does not believe that fact.