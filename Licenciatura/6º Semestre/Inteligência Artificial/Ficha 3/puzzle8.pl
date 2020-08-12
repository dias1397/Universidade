%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   ESTADOS
%
%   estado( branca(I, J), tabuleiro(NumLinhas, NumColunas, [ linhas ]))
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Estado Inicial
%
estado_inicial(
    estado(
        branca(1, 1),
        tabuleiro(3, 3, [
            2, 3, 5,
            1, b, 8,
            4, 7, 6
        ])
    )
).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Estado Final
%
estado_final(
    estado(
        branca(1, 1),
        tabuleiro(3, 3, [
            1, 2, 3,
            4, b, 5,
            6, 7, 8
        ])
    )
).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   TRANSIÇÕES
%
%   tr(Estado_Inicial, Operação, Estado_Final, Custo)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   SOBE
%
tr(
    estado(branca(I, J), tabuleiro(N, M, T0)),
    sobe,
    estado(branca(K, J), tabuleiro(N, M, T1)),
    1
) :- 
    K is I - 1,
    K >= 0,
    troca_tabela(I, J, K, J, N, M, T0, T1).
%
%   DESCE
%
tr(
    estado(branca(I, J), tabuleiro(N, M, T0)),
    desce,
    estado(branca(K, J), tabuleiro(N, M, T1)),
    1
) :- 
    K is I + 1, 
    K < N,
    troca_tabela(I, J, K, J, N, M, T0, T1).
%
%   ESQUERDA
%
tr(
    estado(branca(I, J), tabuleiro(N, M, T0)),
    esquerda, 
    estado(branca(I, K), tabuleiro(N, M, T1)),
    1
) :- 
    K is J - 1, 
    K >= 0,
    troca_tabela(I, J, I, K, N, M, T0, T1).
%
%   DIREITA
%
tr(
    estado(branca(I, J), tabuleiro(N, M, T0)),
    direita, 
    estado(branca(I, K), tabuleiro(N, M, T1)),
    1
) :- 
    K is J + 1,
    K < M,
    troca_tabela(I, J, I, K, N, M, T0, T1).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   troca_tabela(I0, J0, I1, J1, N, M, T0, T1)
%
%   Numa tabela T0 de dimensões N x M,
%   troca os elementos que estão
%   nas posições (I0, J0) e (I1, J1).
%
%   Usa os seguintes predicados em tools:
%       indice(I, J, N, M, K)
%       troca(L0, P0, P1, L1)
%
troca_tabela(I0, J0, I1, J1, N, M, T0, T1) :-
    indice(I0, J0, N, M, K0),
    indice(I1, J1, N, M, K1),
    troca(T0, K0, K1, T1).