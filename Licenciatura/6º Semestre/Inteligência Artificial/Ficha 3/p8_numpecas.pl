%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Número de peças diferentes:
%
%       O número de posições em que o estado dado difere do estado final.
%
heuristica(estado(_, tabuleiro(_, _, T)), Val) :- 
    estado_final(estado(_, tabuleiro(_, _, Tf))),
    distancia_numpecas(T, Tf, Val).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
distancia_numpecas([], [], 0).

distancia_numpecas([X | R1], [X | R2], N) :-
    !,
    distancia_numpecas(R1, R2, N).

distancia_numpecas([X | R1], [Y | R2], N) :-
    X \= Y,
    distancia_numpecas(R1, R2, N1),
    N is N1 + 1.