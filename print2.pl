

% Print a tree-like structure with forest-style formatting
% 打印指定数量的缩进
print_indent(0).
print_indent(N) :- N > 0, write('  '), N1 is N - 1, print_indent(N1).

% 递归地打印嵌套树
print_tree([], _).
print_tree([node(ID, Label, _, Children) | Rest], Indent) :-
    print_indent(Indent),
    format("~t~w. ~w~n", [ID, Label]),
    NewIndent is Indent + 2,
    print_children(Children, NewIndent),
    print_tree(Rest, Indent).

% 打印子节点
print_children([], _).
print_children([Child | Children], Indent) :-
    print_tree([Child], Indent),
    print_children(Children, Indent).

% 将您提供的树数据作为参数传递给print_tree/1
%tree_data([node(44,valid_route(c),14,[node(26,light_traffic(c),initial_fact,[]),node(30,weather_sunny(alex),4,[node(27,predict_sunny(forcast),3,[node(7,smile(forcast),initial_fact,[])]),node(29,download(alex,forcast),2,[node(6,app(forcast),initial_fact,[]),node(28,take_advice(alex,forcast),1,[node(3,friend(alex,emma),initial_fact,[]),node(4,call(alex,emma),initial_fact,[]),node(5,give_advice(forcast),initial_fact,[])])])]),node(31,gas_station(0),13,[node(14,transport(car),initial_fact,[]),node(8,need_gas(car),initial_fact,[]),node(9,gas(0),initial_fact,[])]),node(12,airport(30),initial_fact,[]),node(43,find_route(0,30),9,[node(35,direct_route(0,10),6,[node(34,road(0,10),10,[node(31,gas_station(0),13,[node(14,transport(car),initial_fact,[]),node(8,need_gas(car),initial_fact,[]),node(9,gas(0),initial_fact,[])]),node(10,park(10),initial_fact,[]),node(33,not(congestion(10)),unprovable,[])])]),node(42,find_route(10,30),9,[node(38,direct_route(10,20),6,[node(37,road(10,20),11,[node(10,park(10),initial_fact,[]),node(11,school(20),initial_fact,[]),node(36,not(peak_hours(20)),unprovable,[])])]),node(41,find_route(20,30),8,[node(40,direct_route(20,30),6,[node(39,road(20,30),12,[node(11,school(20),initial_fact,[]),node(12,airport(30),initial_fact,[]),node(15,highway(20,30),initial_fact,[])])])])])]),node(1,name(alex),initial_fact,[])]),node(26,light_traffic(c),initial_fact,[])]).

% 调用print_tree/1来打印树的结构
%:- initialization(tree_data(Data), print_tree(Data), halt).


% 列表转树形结构
list_to_tree([], []).
list_to_tree([H|T], [H|Children]) :-
    is_list(H),  % 如果元素是列表，递归转换为子树
    list_to_tree(H, Children),
    list_to_tree(T, Rest).
list_to_tree([H|T], [H|Rest]) :-
    \+ is_list(H),  % 如果元素不是列表，保留元素
    list_to_tree(T, Rest).

print:-
    conclusion(F), 
    deduce_backwards(F,node(_ID, F, _R, List)),
    list_to_tree(List, Tree),
    print_tree(Tree, 0).