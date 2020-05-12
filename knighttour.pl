moves(X,Y,M) :- X1 is X+1, XM1 is X-1, X2 is X+2, XM2 is X-2,
    Y1 is Y+1, YM1 is Y-1, Y2 is Y+2, YM2 is Y-2,
    append([[X2,Y1],[X2,YM1],[X1,Y2],[X1,YM2]],[[XM1,Y2],[XM1,YM2],[XM2,Y1],[XM2,YM1]], M).
filter([X,Y]) :- X>0, Y>0, X<9, Y<9.
hasbeen(P,[X,Y]) :- member([X,Y],P).
legalmoves(X,Y,P,M) :- moves(X,Y,M1), include(filter,M1,M2), exclude(hasbeen(P),M2,M).

tourlevel([_,_], _, [], []).
tourlevel([X,Y],P,T,[HD|_]) :- append(P,[X,Y],P1), tour(HD,P1,T), length(T,64).
tourlevel([X,Y],P,T,[HD|TL]) :- append(P,[X,Y],P1), tour(HD,P1,T), not(length(T,64)), tourlevel([X,Y],P,T,TL).

tour([X,Y],P,[]) :- legalmoves(X,Y,P,M), M=[], not(length(P,64)).
tour([X,Y],P,P) :- legalmoves(X,Y,P,M), M=[], length(P,64).
tour([X,Y],P,T) :- legalmoves(X,Y,P,M), not(M=[]), tourlevel([X,Y],P,T,M).
                                                                                       
knighttour(X,Y,T) :- tour([X,Y],[[X,Y]],T).
