%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
estado(cavalo(I,J), tabuleiro(N,M)).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
estado_inicial(estado(cavalo(1,1), tabuleiro(8,8))).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
estado_final(estado(cavalo(4,5), tabuleiro(8,8))).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  - - - - - - -
%  - - a - b - -
%  - h - - - c - 
%  - - - N - - - 
%  - g - - - d -
%  - - f - e - -
%  - - - - - - -
%
salto_cavalo(a, delta(-1, -2)).
salto_cavalo(b, delta(+1, -2)).
salto_cavalo(c, delta(+2, -1)).
salto_cavalo(d, delta(+2, +1)).
salto_cavalo(e, delta(+1, +2)).
salto_cavalo(f, delta(-1, +2)).
salto_cavalo(g, delta(-2, +1)).
salto_cavalo(h, delta(-2, -1)).
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Transicoes
%
tr(estado(Pos0, Dim), op, estado(Pos1, Dim), custo) :-
	salto_cavalo(Pos1, Delta),
	destino(Pos0, Delta, Pos1),
	valido(Pos1, Dim).
%
%


