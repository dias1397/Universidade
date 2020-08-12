% dados a saber
% -posiçao do aspirador
% -posiçao das salas sujas
% -dimensao da grelha

estado_inicial(E) :-
    !, estado_inicial(3,3, 0,0, E).
estado_inicial(N, M, E) :-
    !, estado_inicial(N, M, 0, 0, E). 
estado_inicial(N, M, X, Y, estado(pos(X,Y), salas(S), dim(N, M))) :-
    !, salas_iniciais(N, M, S). 

estado_final(estado(_, salas(S), _)) :- todas_limpas(S).

tr(
    estado(pos(X, Y), Salas, Dim),
    esquerda,
    estado(pos(X1, Y), Salas, Dim),
    1
) :- move_esquerda(X, Dim, X1).

tr(
    estado(pos(X, Y), Salas, Dim),
    direita,
    estado(pos(X1, Y), Salas, Dim),
    1
) :- move_direita(X, Dim, X1).

tr(
    estado(pos(X, Y), Salas, Dim),
    baixo,
    estado(pos(X, Y1), Salas, Dim),
    1
) :- move_baixo(Y, Dim, Y1).

tr(
    estado(pos(X ,Y), Salas, Dim),
    cima,
    estado(pos(X, Y1), Salas, Dim),
    1
) :- move_cima(Y, Dim, Y1).

tr(
    estado(pos(X,Y), salas(S), Dim),
    limpa,
    estado(pos(X,Y), salas(S1), Dim),
    1
) :-
    \+ sala_limpa(S, X, Y), 
    modificar(S, X, Y, 0, S1).

/*
    Movimentos
*/
move_esquerda(X, _, X1) :- !,
    X >= 1,
    X1 is X - 1.

move_direita(X, dim(_, M), X1) :- !,
    X1 is X + 1,
    X1 < M.

move_baixo(Y, dim(N, _), Y1) :- !,
    Y1 is Y + 1,
    Y1 < N.

move_cima(Y, _, Y1) :- !,
    Y >= 1,
    Y1 is Y - 1.
/*
    Construção das salas
*/
gera_linha(0, []) :- !.
gera_linha(N, [0 | R]) :-
    0 is mod(N, 2), !,
    N1 is N - 1,
    gera_linha(N1, R).
gera_linha(N, [1 | R]) :-
    !, N1 is N - 1, 
    gera_linha(N1, R).

nega_linha([], []) :- !.
nega_linha([0 | A], [1 | B]) :- !, nega_linha(A, B).
nega_linha([1 | A], [0 | B]) :- !, nega_linha(A, B).

salas_iniciais(0, _, []) :- !.
salas_iniciais(N, M, [L | R]) :-
    0 is mod(N, 2), !,
    gera_linha(M, L),
    N1 is N - 1,
    salas_iniciais(N1, M, R).
salas_iniciais(N, M, [L | R]) :-
    !, gera_linha(M, L1),
    nega_linha(L1, L),
    N1 is N - 1,
    salas_iniciais(N1, M, R).
%
% Obter o valor numa matriz
%
valor_em([L | _], 0, M, X) :-
    valor_em(L, M, X).
valor_em([_ | R], N, M, X) :-
    N1 is N - 1,!,
    valor_em(R, N1, M, X).
%
% Obter o valor numa linha
%
valor_em([X | _], 0, X).
valor_em([_ | L], M, X) :-
    M1 is M - 1, !,
    valor_em(L, M1, X).
%
% Modificar o valor numa matriz
%
modificar([L | R], 0, Y, V, [L1 | R]) :-
    !, modificar(L, Y, V, L1).
modificar([L | R], N, Y, V, [L | R1]) :-
    N1 is N - 1,
    modificar(R, N1, Y, V, R1).
%
% Modificar o valor numa linha
% 
modificar([_ | R], 0, V, [V | R]) :- !.
modificar([A | R], Y, V, [A | R1]) :-
    !, Y1 is Y -1,
    modificar(R, Y1, V, R1).
%
%   Testar se todas as salas estão limpas
%
linha_limpa([]) :- !.
linha_limpa([0]) :- !.
linha_limpa([0 | R]) :- !, linha_limpa(R).
todas_limpas([]).
todas_limpas([L | R]) :-
    !, linha_limpa(L),
    todas_limpas(R).
%
%  Observar sala numa posição
%  
%   limpa(X, Y, Salas)
sala_limpa(Salas, X, Y) :-
    valor_em(Salas, X, Y, 0).


