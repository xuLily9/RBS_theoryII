print_indent(0, _).
print_indent(N, Char) :- N > 0, write(Char), N1 is N - 1, print_indent(N1, Char).

% 递归地打印嵌套树
print_tree([], _, _).
print_tree([node(ID, Label, Rule, Children) | Rest], Indent, LastChild) :-
    print_indent(Indent, ' '),
    (LastChild = true -> write('└── ') ; write('├── ')),
    format("~w. ~w,[~w]~n", [ID, Label,Rule]),
    %format("~w. ~w~n", [ID, Label]),
    NewIndent is Indent + 4,
    length(Children, ChildrenCount),
    print_children(Children, NewIndent, ChildrenCount, Rest),
    print_tree(Rest, Indent, LastChild).

% 打印子节点
print_children([], _, _, _).
print_children([Child | Children], Indent, ChildrenCount, Rest) :-
    (ChildrenCount = 1 -> print_tree([Child], Indent, true) ; print_tree([Child], Indent, false)),
    NewChildrenCount is ChildrenCount - 1,
    print_children(Children, Indent, NewChildrenCount, Rest).


list_to_tree([], []).
list_to_tree([H|T], [H|Children]) :-
    is_list(H),  %如果元素是列表递归转换为子树
    list_to_tree(H, Children),
    list_to_tree(T, _Rest).
list_to_tree([H|T], [H|Rest]) :-
    \+ is_list(H),  %如果元素不是列表保留元素
    list_to_tree(T, Rest).

print(F):-
    %conclusion(F), 
    %deduce_backwards(F,node(_ID, F, _R, List)),
    %deduce_backwards(F,node(_ID, F, _R, List)),
    node(_ID, F, _R, List),
    list_to_tree(List, Tree),
    print_tree(Tree, 0, true).