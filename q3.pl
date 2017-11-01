        :- op(100,xfy,on).  % a bit of grammar

% Who ordered the pizza?

find(PizzaOrderer) :-
    
%       ************  THE FACTS ************
%   There are 4 people (Donna, Danny, David, and Doreen), sat in a restaurant 
%   table. The men sat across from each other, as did the women. They each
%   ordered a different main course with a different beverage.

        % let L1 denote the side with all women
        makesides(2, L1),                                        

        % put all the women on the List
        person(doreen, _, _) on L1,
        person(donna, _, _) on L1,

        % let L2 denote the side with all men
        makesides(2, L2),     

        % put all the men on the List
        person(david, _, _) on L2,
        person(danny, _, _) on L2,

        % Fact 1: Doreen sat beside the person who ordered steak.
        beside(person(doreen, _, _), person(_, steak, _), L1),          

        % Fact 2: The chicken came with a coke.
        (person(_, chicken, coke) on L1; person(_, chicken, coke) on L2),

        % Fact 3: The person with the lasagna sat across from the person with milk.
        across(person(_, lasagna, _), person(_, _, milk), L1, L2),

        % Fact 4: David never drinks coffee (i.e coffee must be ordered by someone else in L1 or just danny).
        (person(_, _, coffee) on L1; person(danny, _, coffee) on L2),

        % Fact 5: Donna only drinks water.
        person(donna, _, water) on L1,

        % Fact 6: Danny could not afford to order steak (i.e steak must be ordered by someone else in L1 or just david).
        (person(_, steak, _) on L1; person(david, steak, _) on L2),

        % find the pizzaOrderer (the pizzaOrderer could be either in L1 or L2)
        (person(PizzaOrderer, pizza, _) on L1; person(PizzaOrderer, pizza, _) on L2),

        % put everyone in one list to print it, the women followed by the men
        append(L1, L2, List),
        write(List), !.

        
%       ********** DEFINITIONS **********

        % makes N people with type predicate people(name, main_course, beverage) and assigns them to a list that represents one side of the table.
        makesides(0, []).
        makesides(N, [person(_, _, _)|List])
                :- N>0, N1 is N - 1, makesides(N1,List).

        % definition taken from the zebra example. X is on List if X is a member of List.
        X on List :- member(X, List).

        % definition taken from the zebra example to find if two elements are next to one another in a List.
        sublist2([S1, S2], [S1, S2 | _]) .
        sublist2(S, [_ | T]) :- sublist2(S, T).

        beside(X, Y, L) :- sublist2([X, Y], L).
        beside(X, Y, L) :- sublist2([Y, X], L).

        % across holds if person X is in L1 and Y is in L2 OR X is in L2 and Y is in L1; but both not in L1 and L2 at the same time. 
        across(X, Y, L1, L2) :-
            (member(X, L1), not(member(X, L2)),
            member(Y, L2), not(member(Y, L1)));

            (member(X, L2), not(member(X, L1)),
            member(Y, L1), not(member(Y, L2))).
