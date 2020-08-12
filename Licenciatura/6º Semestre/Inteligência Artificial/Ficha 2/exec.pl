:- include('lib_ficha2.pl').

min(X, Y, X) :-
	X < Y , !.
min(_, Y, Y).

max(X, Y, X) :-
	X > Y, !.
max(_, Y, Y).

capacidade(c1, 5).
capacidade(c2, 2).

estado_inicial(niveis(0,0)).
estado_final(niveis(3,2)).


