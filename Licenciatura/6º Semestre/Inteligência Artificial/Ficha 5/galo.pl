:-include('padversario.pl').

estado_inicial(e([	A,B,C,
					D,E,F,
					G,H,I], [x,o,n])).

estado_terminal(linha).
estado_terminal(coluna).
estado_terminal(diagonal).
estado_terminal(empate).

linha(e([X,X,X,_,_,_,_,_,_],[_])).
linha(e([_,_,_,X,X,X,_,_,_],[_])).
linha(e([_,_,_,_,_,_,X,X,X],[_])).

coluna(e([X,_,_,X,_,_,X,_,_],[_])).
coluna(e([_,X,_,_,X,_,_,X,_],[_])).
coluna(e([_,_,X,_,_,X,_,_,X],[_])).

diagonal(e([X,_,_,_,X,_,_,_,X],[_])).
diagonal(e([_,_,X,_,X,_,X,_,_],[_])).

empate(e([n,n,n,n,n,n,n,n,n],[_])).

utilidade(linha,1).

