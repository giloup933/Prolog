move(X0,Y0,X,Y) :- 
    X is X0+2, Y is Y0+1;
    X is X0+2, Y is Y0-1;
    X is X0+1, Y is Y0+2;
    X is X0+1, Y is Y0-2;
    X is X0-1, Y is Y0+2;
    X is X0-1, Y is Y0-2;
    X is X0-2, Y is Y0+1;
    X is X0-2, Y is Y0-1.
hasbeen(P,X,Y) :- member([X,Y],P).
legalmove(N,X0,Y0,P,[X,Y]) :- move(X0,Y0,X,Y), X>0, Y>0, X=<N, Y=<N, not(member([X,Y],P)).
heuristic(N,X0,Y0,P,H) :- 
    findall([X,Y],legalmove(N,X0,Y0,P,[X,Y]),Bag), length(Bag,H).
mvh(N,X0,Y0,P,[H,X,Y]) :- legalmove(N,X0,Y0,P,[X,Y]), heuristic(N,X,Y,P,H).    
warnsdorff(N,X0,Y0,P,M) :- 
    findall([X,Y,H],mvh(N,X0,Y0,P,[X,Y,H]),Bag),
    sort(1,@=<,Bag,SBag),
    member(M,SBag).
tour(N,X0,Y0,P,T) :- append(P,[[X0,Y0]],T), L is N*N, length(T,L).
tour(N,X0,Y0,P,T) :- append(P,[[X0,Y0]],P1), L is N*N, not(length(P1,L)), 
    warnsdorff(N,X0,Y0,P,[_,X,Y]), tour(N,X,Y,P1,T).
knighttour(N,X,Y,T) :- tour(N,X,Y,[],T).


% knighttour(24,1,1,T);
