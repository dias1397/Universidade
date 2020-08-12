alvo(31).

op_mais(1).
op_mais(2).
op_mais(3).

estado_inicial(e(a, 10)).

estado_terminal(e(_, N)) :- alvo(N).

utilidade(e(b, N), +1) :- alvo(N).
utilidade(e(a, N), -1) :- alvo(N).

sucessor(e(J, X), mais(N), e(K, Y)) :-
	alvo(Alvo),
	op_mais(N),
	Y is X + N,
	Y =< Alvo,
	outro(J, K).

escreve(e(_, N)) :-
	nl, write(' : '), write(N), nl.

outro(a, b).
outro(b, a).