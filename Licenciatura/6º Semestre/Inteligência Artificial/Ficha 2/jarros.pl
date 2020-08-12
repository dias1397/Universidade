/*
 Operações
*/
%
% Enche c1 (atesta)
%
tr( niveis(A, B), enche(c1), niveis(A1, B), 1) :- 
    capacidade(c1, A1),
    A \= A1. % garante que o proximo estado e diferente do actual.
%
% Enche c2 (atesta)
%
tr( niveis(A, B), enche(c2), niveis(A, B1), 1) :-
    capacidade(c2, B1),
    B \= B1.
%
% Despeja c1 (esvazia)
%
tr( niveis(A, B), despeja(c1), niveis(0, B), 1) :-
    A \= 0.
%
% Despeja c2 (esvazia)
%
tr( niveis(A, B), despeja(c2), niveis(A, 0), 1) :-
    B \= 0.
%
% Despeja de c1 para c2 (transfere)
%
tr( niveis(A, B), despeja(c1,c2), niveis(A1, B1), 1) :- 
    capacidade(c2, Capacidade2), 
    C is A + B,
    min(Capacidade2, C, B1), 
    Resto is C -  B1,
    max(Resto, 0, A1),
    A \= A1,
    B \=  B1.
%
% Despeja de c2 para c1
%
tr( niveis(A, B), despeja(c2,c1), niveis(A1, B1), 1):-
    capacidade(c1, Capacidade1),
    C is A + B,
    min(Capacidade1, C, A1),
    Resto is C - A1,
    max(Resto, 0, B1),
    B \= B1,
    A \= A1.


