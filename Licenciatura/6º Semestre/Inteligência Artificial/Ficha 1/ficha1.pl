:-include('p.pl').
%
% Alinea 2
%
irmao(X, Y) :- filho(X, Z),
				filho(Y, Z),
				X \== Y.

%
% Alinea 3
%
primoDireito(X, Y) :- filho(X, A),
						filho(Y, B),
						irmao(A, B).

%
% Alinea 4
%
irmaos(X, L) :- findall(Y ,irmao(X, Y), L).

%
% Alinea 5
% minha
% primos direitos
primos(X, L) :- findall(Y, primoDireito(X, Y), L).
% filhos dos primos
primos(X, L) :- primoDireito(X, Y),
					findall(Z, filho(Z, Y), L).
% primo dos pais
primos(X, L) :- filho(X, Y),
					findall(Z, primoDireito(Y, Z), L).

% professor
primos1(X, Y) :- primoDireito(X, Y).
primos1(X, Y) :- filho(Y, Pai_de_Y), 
					primos1(X, Pai_de_Y).
primos1(X, Y) :- filho(X, Pai_de_X), 
					primos1(Pai_de_X, Y).

%
% Alinea 6
%
esposa(M, H) :- mulher(M, _, _),
				homem(H, _, _),
				filho(X, M),
				filho(X, H).

%
% ALinea 7
%
descende(X, Y) :- filho(X, Y).
descende(X, Y) :- filho(X, Z), descende(Z, Y).

ascendentes(X, A) :- setof(Y, descende(X, Y), A), !.
ascendentes(_, []).

%
% Alinea 8
%
ascende(X, Y) :- filho(Y, X).
ascende(X, Y) :- filho(Y, Z), ascende(X, Z).

descendentes(X, A) :- setof(Y, ascende(X, Y), A), !.
descendentes(_, []).

%
% Alinea 9
%
no(N, Esq, Dir) :- filho(N, X),
					homem(X, _, _),
					filho(N, Y),
					mulher(Y, _, _),
					no(X, _, _),
					no(Y, _, _).
no(N, Esq, Dir) :- no(N, 0, 0).

asc(N, Lis) :- asc(N, [no(N, L, R)|Lis]).
 
%
% Alinea 10
%
% caso mulher
descendentes_sep(Mulher, c(Homem, Mulher, DescFilhos)) :- 
					mulher(Mulher, _, _),
					esposa(Mulher, Homem), !,
					findall(X, (filho(X, Mulher), filho(X, Homem)), Filhos),
					proc_ds(Filhos, DescFilhos).
% caso homem
descendentes_sep(Homem, c(Homem, Mulher, DescFilhos)) :- 
					homem(Homem, _, _),
					esposa(Mulher, Homem), !,
					findall(X, (filho(X, Mulher), filho(X, Homem)), Filhos),
					proc_ds(Filhos, DescFilhos).
% nenhum dos anteriores
descendentes_sep(_, []).

proc_ds([], []).
proc_ds([Pessoa|Resto], [DP|DR]) :- 
					descendentes_sep(Pessoa, DP),
					proc_ds(R, DR).
