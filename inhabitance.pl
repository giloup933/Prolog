%lam(x,true).
%applies(false,_).
%applies(true,true).
%inhabitant(int).
%inhabitant(bool).
%inhabitant(unit).
%inhabitant(func(t1,t2)) :- applies(inhabitant(t1),inhabitant(t2)).
%inhabitant(injection(t1,t2)) :- inhabitant(t1) ; inhabitant(t2).
%inhabitant(product(t1,t2)) :- inhabitant(t1) , inhabitant(t2).
%inhabitant(lam(x,t)) :- lam(x, inhabitant(t)).

intuitionistic(X,Y) :- var(X)\==true,var(X)\==false,var(Y)\==true,var(Y)\==false.

and(A,A,A).
and(false,_,false).
and(_,false,false).
and(var(X),true,var(X)).
and(true,var(X),var(X)).
and(var(X),var(Y),and(var(X),var(Y))) :- intuitionistic(var(X),var(Y)).

or(A,A,A).
or(true,_,true).
or(_,true,true).
or(var(X),false,var(X)).
or(false,var(X),var(X)).
or(var(X),var(Y),or(var(X),var(Y))) :- intuitionistic(var(X),var(Y)).

implies(A,A,A).
implies(false,_,true).
implies(true,false,false).
implies(var(X),var(Y),implies(var(X),var(Y))) :- intuitionistic(var(X),var(Y)).

inhabitant(int,true).
inhabitant(bool,true).
inhabitant(unit,true).
inhabitant(void,false).
inhabitant(forall(X,var(X)),false).
inhabitant(forall(X,var(Y)),B) :- X\==Y, inhabitant(var(Y),B).
inhabitant(func(T1,T2),B) :- inhabitant(T1,B1), inhabitant(T2,B2), implies(B1,B2,B).
inhabitant(injection(T1,T2),B) :- inhabitant(T1,B1), inhabitant(T2,B2), or(B1,B2,B).
inhabitant(product(T1,T2),B) :- inhabitant(T1,B1), inhabitant(T2,B2), and(B1,B2,B).
inhabitant(forall(X,T),B) :- forall(X,inhabitant(T,B)).
inhabitant(var(X),var(X)).

%inhabitant(injection((forall(A,product(A,A))), (forall(A, (func(A,unit))))),B).
