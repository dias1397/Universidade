e([Naf, Afe]).

estado_inicial(e([
	v(q(1),[1,2,3,4], _),
	v(q(2),[1,2,3,4], _),
	v(q(3),[1,2,3,4], _),
	v(q(4),[1,2,3,4], _)
	],[])).

% Restricoes
ve_restricoes(e(Nafec, Afect)) :- \+
		(member(v(c(I), Di, Vi), Afect),
		 member(v(c(J), Dj, Vj), Afect),
		 I \= J,
		(
			Vi = Vj; 
			modDif(I, J, D1), 
			modDif(Vi, Vj, D2), D1=D2
		)).
ve_restricoes(e(Nafect,[A])).

modDif(I,J,D):- I >  J, D is I-J.
modDif(I,J,D):- I =< J, D is J-I.
