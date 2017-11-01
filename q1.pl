% --------facts--------

on(b1, b2).

on(b3, b4).
on(b4, b5).
on(b5, b6).

just_left(b1, b5).
just_left(b2, b6).
just_left(b6, b7).

% ------"above" predicate------

above(X, Y) :-
    on(X,Y).	% base-case: when X is exactly on Y.
above(X, Y) :-(
    on(X, Z), above(Z, Y). % recursive-case: there is a Z such that X is on Z, and Z is above Y.

% helper predicate "below". X is below Y, if Y is above X.

below(X, Y) :-
    above(Y, X).

% ------"left" predicate------

left(X, Y) :-
      ((above(X, Y); below(X, Y)) -> !, fail).	% if X is above Y OR X is below Y, terminate right away.

left(X, Y) :- just_left(X, Y).	% base-case: when X is just left of Y.
left(X, Y) :-
       (above(Z, Y); below(Z, Y)), just_left(X, Z).	% base-case: there is a Z such that Z is above Y OR Z is below Y and X is just left of Z.
left(X, Y) :-
        just_left(Z, Y), (above(X, Z); below(X, Z)). % base-case: there is a Z such that Z is just left of Y and X is above Z OR X is below Z.

left(X, Y) :-
      left(Z, Y), left(X, Z).	% recursive-case: there is a Z such that Z is to the left of Y and X is to the left of Z.

% ------"right" predicate------     	  

right(X, Y) :-
    left(Y, X).	% X is to the right of Y, if Y is to the left of X.
