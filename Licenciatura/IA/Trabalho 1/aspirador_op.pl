tr(
    estado(robo(pos(X), bateria(Z)), sala(dim(N,M),sujas(Dirt),Charger)),
    limpa,
    estado(robo(pos(X), bateria(Z1)), sala(dim(N,M),sujas(Dirt2),Charger)),
    1
):-
    Z > 0, Z1 is Z - 1,
    member(X, Dirt),
    delete(Dirt, X, Dirt2).

tr(
    estado(robo(pos(X), bateria(_)), sala(dim(N,M),Dirt,carregador(Charger))),
    carrega,
    estado(robo(pos(X), bateria(Z1)), sala(dim(N,M),Dirt,carregador(Charger))),
    1
):-
    member(X, Charger),
    Z1 is 7.

tr(
    estado(robo(pos((X,Y)), bateria(Z)), sala(dim(N,M),Dirt,Charger)),
    esquerda,
    estado(robo(pos((X1,Y)), bateria(Z1)), sala(dim(N,M),Dirt,Charger)),
    1
):-
	Z > 0, Z1 is Z - 1,
    X >= 1,
    X1 is X - 1.

tr(
    estado(robo(pos((X,Y)), bateria(Z)), sala(dim(N,M),Dirt,Charger)),
    direita,
    estado(robo(pos((X1,Y)), bateria(Z1)), sala(dim(N,M),Dirt,Charger)),
    1
):-
    Z > 0, Z1 is Z - 1,
    X1 is X + 1,
    X1 < N.

tr(
    estado(robo(pos((X,Y)), bateria(Z)), sala(dim(N,M),Dirt,Charger)),
    cima,
    estado(robo(pos((X,Y1)), bateria(Z1)), sala(dim(N,M),Dirt,Charger)),
    1
):-
	Z > 0, Z1 is Z - 1,
    Y >= 1,
    Y1 is Y - 1.

tr(
    estado(robo(pos((X,Y)), bateria(Z)), sala(dim(N,M),Dirt,Charger)),
    baixo,
    estado(robo(pos((X,Y1)), bateria(Z1)), sala(dim(N,M),Dirt,Charger)),
    1
):-
    Z > 0, Z1 is Z - 1,
    Y1 is Y + 1,
    Y1 < M.