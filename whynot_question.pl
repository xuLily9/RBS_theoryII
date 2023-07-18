whynot(F):-
    repeat,
    write('Computer: Please state your reason:\n'),
    write_reason,
    write('User: '),
    prompt(_, ''),
    read(Number),
    (   Number  =:= 1
    ->  
        ( 
            user_fact(_,F,initial_fact,_),
            \+ node(_N, F,_, _)
            -> (    write('User: Because '),print_fact(F),write(' is an initial fact.'),nl, 
                    aggregate_all(count, y_computer_user(_,_), X),
                    aggregate_all(count, n_user_computer(_,_), Y),
                    X1 is X +1,
                    Y1 is Y+1,
                    assert(y_computer_user(X1,F)),!,
                    assert(n_user_computer(Y1,F)),!,
                    write('Computer: I have found the disagreement.'), 
                    print_fact(F),
                    write(' is an initial fact of user, but the computer neither believes nor infers it.\n'),nl,
                    assert(different(F)),!
            )
        ; (
            \+user_fact(_,F,initial_fact,_)
            ->write('\nComputer: I have checked. It is not an initial user fact, please select another reason.'),nl,whynot(F),nl,fail
            )
        )
    ;    Number =:= 2
    ->   reason_rule(F,_), nl, !
    ;    Number =:= 3
    ->  write('Computer: Bye\n')->halt
    ;
        write('Not a valid choice, try again...'), nl, fail
    ).
    

reason_rule(Fact,F):-
    repeat,
    write('User: Please select a rule number from your rule sets: '),nl,
    %write_user_rule,
    %aggregate_all(count, user_rule(_,_,Fact), Count),
    findall(N, user_rule(N, _Antecedants, Fact),Ruleset),
    write(Ruleset),
    Restart is N+1,
    write(Restart),write('. Restart to choose another reason\n'),
    E is Restart+1,
    write(E),write('. Exit\n'),
    write('User: '),
    prompt(_, ''),
    read(N),nl,     
    (  N=:=E
    ->  write('Computer:Bye\n')->halt
    ;  N=:=Restart
    ->  write('\nComputer: Why do you believe '), print_fact(Fact), write('? '),
        whynot(Fact)
    ;   
        (   
            user_rule(N, A, F),
            check(A, _)
            %deduce_user(F,_)
            %write(A),write(F)
            
            %user_fact(_,F,_,_)
        -> 
            (
                rule(_,A,F)
            ->  
                assert(yr_computer_user(N,A,F)),!,
                write_w_list,
                write_x_list,
                aggregate_all(count, computer_ask_user(_,_), Num),
                (   Num==0
                ->  %write('Computer: This rule is used in deduction. Both computer and user are agree with this rule, please select another rule to find disagreement.\n'),
                    write('Computer:  Why do you believe '),print_fact(F), write('? '),
                    whynot(F)
                    %reason_rule(F,_)
                ;   computer_ask_user(Num,_F),
                    choose(Num)
                )
             ;   
                write('Computer: I found the disagreement! I do not have this rule'),
                print_rule(N),write(', but the user has it.'), nl,
                assert(different(user_rule(N,_,_))),!,conversations(false,_)
            )

        ;   write('Computer: This rule is not used in deduction of this fact.'),
            button(Fact)
        )
    ;   
        write('Not a valid choice, try again...'), nl, fail).



button(F):-
    repeat,
    write('Please choose another rule or reason\n'),
    write('1. Restart to choose a reason\n'),
    write('2. Choose another rule\n'),
    write('3. Exit\n'),
    write('User:'),
    prompt(_, ''),
    read(N),
    (   N=:= 1
    -> write('\nComputer: Why do you beleive '), print_fact(F), write('? '),
        whynot(F)
    ;   N=:= 2
    -> reason_rule(F,_)
    ;   N=:= 3
    -> write('Computer:Bye\n')->halt
    ;   
        write('Not a valid choice, try again...'), nl, fail
      ).


option_whynot:-
    write_w_list,
    write_x_list,
    aggregate_all(count, computer_ask_user(_,_), N),
    computer_ask_user(N,_F),
    choose(N).

choose(0):-
    write('----------FINISHED----------\n'),
    write('Computer: Bye\n'), !,halt .
choose(N):-
    computer_ask_user(N,F),
    assert(asked_question(F)),
    Num is N-1,
    ( n_computer_user(_,F)
     ->  
        write('Computer: Why do not you believe '),print_fact(F), write('?\n'),
        write('User: Why do you believe '), print_fact(F),write('? '),
        whynot(F),choose(Num)
    ;   write('Computer: Why do you believe '),print_fact(F), write('? '),
        whynot(F),choose(Num)
    ),
    choose(Num).

check([],[]).
check([not(H)|T], N):-
    \+ deduce_user(H, _DAG),!, 
    assert(n_computer_user(_,H)),
    check(T, N).
check([H|T], [H|N]):-
    \+ deduce_user(H, _DAG),!, 
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