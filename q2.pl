% ------"intersect" predicate------

intersect([X|_], [X,_]).    % base-case: when X is the first element of L1 and L2.
intersect([X|Rest], L2) :-
    member(X, L2); intersect(Rest, L2). % recursive-case: X is either in L2 (i.e member(X, L2)) OR we call intersect on the rest of the elements.

% ------"all_intersect" predicate------

all_intersect([], _).   % base-case: all elements in the empty list intersects with the given list.
all_intersect([X|Rest], L2) :-
    intersect(X, L2), all_intersect(Rest, L2).  % recursive-case: for each element X in the list check if it intersects with L2 and recursively do the same with the rest of the list subtract X. 

% ------"member_nl" predicate------

member_nl(X, L) :-
    flatten(L, Z), member(X, Z). % using swi-prologs functionality, flatten the list L and check if X is a member of the new flattened list Z.
