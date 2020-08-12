%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Distância de Manhatan
%
heuristica(estado(_, tabuleiro(N, M, T)), Val) :-
    estado_final(estado(_, tabuleiro(_, _, Tf))), 
    dm_tabuleiros(T, Tf, N, M, Val).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Distância de Mahnattan (dm) entre dois tabuleiros:
%   é a soma das dm das posições das peças.
%   Isto é, dados dois tabuleiros T0 e T1,
%       seja dm_i a dm entre
%           a posição da peça i em T0 e 
%           a posição da peça i em T1. 
%       então a dm de T0 e T1 é a soma das dm_i de todas as peças.
%
dm_tabuleiros(Tabuleiro_0, Tabuleiro_1, N, M, Distancia) :-
    mapa_indice_pos(N, M, Tabuleiro_0, Mapa_0), sort(Mapa_0, MapaOrdenado_0),
    mapa_indice_pos(N, M, Tabuleiro_1, Mapa_1), sort(Mapa_1, MapaOrdenado_1),
    dm_soma(MapaOrdenado_0, MapaOrdenado_1, Distancia).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Dada um tabuleiro N x M, 
%   associa a cada peça a respectiva posição
%
%   **************************************************
%
%   O padrão K-V é semelhante aos dicionários ou mapas associativos
%   noutras linguagens, na medida em que numa lista de 
%   elementos desta forma,
%   os "V"s estão associados aos "K"s 
%
%   **************************************************
%
mapa_indice_pos(N, M, Tabuleiro, Mapa) :-
    !, mapa_indice_pos(0, N, M, Tabuleiro, Mapa).

mapa_indice_pos(_, _, _, [], []) :- !.

mapa_indice_pos(K, N, M, [A | R], [ A-(I, J) | RP]) :-
    indice(I, J, N, M, K),
    K1 is K + 1,
    mapa_indice_pos(K1, N, M, R, RP).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   dm_soma(L0, L1, D)
%
%   Soma as dm de todas as peças em L0 e L1.
%       Pressupõe que L0 e L1 têm as mesmas peças, pela mesma ordem,
%       diferindo apenas nas posições das peças.
%
dm_soma([], [], 0).

dm_soma([b-(_, _) | R0], [b-(_, _) | R1], S) :-
    !, dm_soma(R0, R1, S).

dm_soma([P-(I0, J0) | R0], [P-(I1, J1) | R1], S) :-
    P \= b, 
    dm_posicao(I0, J0, I1, J1, SP), !,
    dm_soma(R0, R1, SR),
    S is SP + SR.

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
dm_posicao(I0, J0, I1, J1, D) :-
    diferenca(I0, I1, DI),
    diferenca(J0, J1, DJ), !,
    D is DI + DJ.