escreve(stat(EV, EM)) :-
    escreveln('--- desempenho ---'),
    escreveln(visitados(EV)),
    escreveln(em_memoria(EM)).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
escreve_no(no(Estado, Pai, Tr, Custo, _, Profundidade)) :-
    escreveln('===== Nó ====='),
    escreveln('--- árvore ---'),
    escreveln(custo(Custo)),
    escreveln(profundidade(Profundidade)),
    escreveln('--- acções ---'),
    escreve_accoes(no(Estado, Pai, Tr, _, _, _)).

escreve_accoes(nenhum).
escreve_accoes(no(Estado, Pai, Tr, _, _, _)) :-
    escreve_accoes(Pai),
    write(Tr), write(' -> '), write(Estado), nl.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
escreve_lista(X) :-
    \+ is_list(X),!,
    write(' é '),
    write(X),
    write('.').

escreve_lista([]) :- !, write(' é vazio.').

escreve_lista([X]) :- !, escreve_lista(X).

escreve_lista([X | L]) :- 
    write(' são '),
    write(X),
    escreve_itens(L),
    write('.').
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
escreve_itens([]) :- !.

escreve_itens([X]) :- 
    write(' e '),
    write(X).

escreve_itens([X | T]) :- 
    write(', '), write(X), !,
    escreve_itens(T).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
escreveln(A) :- write(A), nl.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
max(A, B, A):- A > B, !.

max(_, B, B).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
min(A, B, A):- A < B, !.

min(_, B, B).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
diferenca(A, B, D) :-
    A >= B, !,
    D is A - B.
diferenca(A, B, D) :-
    !,
    D is B - A.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   PROCESSAMENTO DE LISTAS
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Trocar dois elementos numa lista (Alínea 16)
%
%   troca(A, P1, P2, B)
%
%   B é igual a A, exceto os elementos das posições P1 e P2, que estão trocados.
%
%
%   Caso 1: se P1 = P2 então B = A.
%
troca(A, P1, P1, A) :- !.
%
%   Caso 2: P2 < P1, trocar P1 com P2.
%
troca(A, P1, P2, B) :-
    P2 < P1, !,
    troca(A, P2, P1, B).
%
% Caso 3: P1 < P2
%
%   A ideia é separar A em A1 + [X | B2] + [Y | B3]
%   de forma que X está na posição P1 e Y na posição P2 de A.
%
%   1. Separar A em A1 + B1, com comprimento de A1 = P1.
%   -- O primeiro elemento que queremos trocar, X, é a cabeça de B1.
%   2. separar B1 em [X | B2] + [Y | B2], de forma que [X | B1] tem P3 = P2 - P1 elementos.
%   -- O segundo elemento que queremos trocar é Y.
%   -- A lista inicial era A = A1 + [X | B2] + [Y | B3].
%   3. Reconstruir A1 + [Y | B2] + [X | B3]
%
troca(A, P1, P2, B) :-
    separar(A, P1, A1, B1),
    P3 = P2 - P1,
    separar(B1, P3, [X | B2], [Y | B3]),
    append(A1, [Y | B2], B4),
    append(B4, [X | B3], B).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   separar(L, N, A, B) separa L em A e B, de forma que A tem, no máximo, N elementos.
%
separar([], _, [], []) :- !.

separar(A, 0, [], A) :- !.

separar([X | A], 1, [X], A) :- !.

separar([A | T], N, [A | T1], A2) :-
    N1 is N - 1,
    separar(T, N1, T1, A2).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Operações numa tabela 
%
%   Uma tabela N x M é representada por uma lista com N * M elementos.
%   
%   À posição (I, J) de uma tabela N x M corresponde o índice K = J + I * M.
%   Ao índice K de uma tabela N x M corresponde a posição (I, J) onde
%       J = K mod M
%       I = (K - J) / M
%
%   indice( I, J, N, M, K)
%       o índice K na **lista** corresponde à posição (I, J) numa tabela N x M.
%
indice(I, J, N, M, K) :-
    ground(I), ground(J), !,
    0 =< I, I < N,
    0 =< J, J < M,
    K is J + I * M.

indice(I, J, N, M, K) :-
    0 =< K, K < N * M,
    J is K mod M,
    I is (K - J) div M.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
