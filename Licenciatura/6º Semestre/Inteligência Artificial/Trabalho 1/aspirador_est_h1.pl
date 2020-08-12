% heuristica 1
% distancia de manhattan

heuristica(estado(
    robo(pos((X,Y)), bateria(B)),
    sala(_, sujas(Dirt), carregador(Charger)
    )), Val):-
        calcula_distancia((X,Y), Dirt, Charger, Val).

calcula_distancia((X,Y), [], [(X1,Y1)|_], Val):-
    dif(X,X1, M),
    dif(Y,Y1, N),
    Val is M + N.
calcula_distancia((X,Y), Lista, _, Val):-
    calcula_distancia((X,Y), Lista, Val).

calcula_distancia((X,Y), [(X1,Y1)|Lista], Val):-
    dif(X,X1, M),
    dif(Y,Y1, N),
    Val1 is M + N,
    (nonvar(Val); Val is Val1),
    min(Val1, Val, P),
    calcula_distancia((X,Y), Lista, P).
calcula_distancia(_, [], _).

dif(A,B,C):- A>B, C is A-B.
dif(A,B,C):- A=<B, C is B-A.
