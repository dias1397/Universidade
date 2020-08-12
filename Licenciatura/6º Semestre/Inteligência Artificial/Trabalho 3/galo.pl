% tablueir([num, num,...])
% num(pos(X,Y), Value)

% jogador(humano).
% jogador(ia).

% galo(jog(X), [num])

estado_inicial(e(jog(x), Tab)):-
    gerar_tab(Tab).

estado_terminal(e(jog(X), Tab)):-
    other_player(X,X1), (
    check_winner(X1, Tab) ;
    check_tab(Tab)).

utilidade(e(jog(x), Tab), -1):-
    check_winner(x,Tab).
utilidade(e(jog(o), Tab), +1):-
    check_winner(o,Tab).
utilidade(_, 0).

sucessor(e(jog(X), Tab), galo(Linha, Coluna), e(jog(X1), Tab1)):-
    member(num(pos(Linha, Coluna), _, n), Tab),
    mudar_peca(X, Tab, Linha,Coluna, Tab1),
    other_player(X,X1).

gerar_tab(Tab):-
    gerar_tab(1,1,Tab).
gerar_tab(_,4,[]):- !.
gerar_tab(X,Y,Tab):-
    X == 4,
    Y1 is Y + 1,
    gerar_tab(1, Y1, Tab).
gerar_tab(X,Y,[num(pos(X,Y), dn, n)|Tab]):-
    X1 is X + 1,
    gerar_tab(X1, Y, Tab).
check_tab([]).
check_tab([num(_, _, X)|Tab]):-
    X \= n,
    check_tab(Tab).

check_winner(J,Tab):-
    member(num(pos(1,1),_,X1), Tab),
    member(num(pos(2,1),_,X2), Tab),
    member(num(pos(3,1),_,X3), Tab),
    member(num(pos(1,2),_,X4), Tab),
    member(num(pos(2,2),_,X5), Tab),
    member(num(pos(3,2),_,X6), Tab),
    member(num(pos(1,3),_,X7), Tab),
    member(num(pos(2,3),_,X8), Tab),
    member(num(pos(3,3),_,X9), Tab),
    (
    iguais(X1, X2, X3, J);
    iguais(X4, X5, X6, J);
    iguais(X7, X8, X9, J);
    iguais(X1, X4, X7, J);
    iguais(X2, X5, X8, J);
    iguais(X3, X6, X9, J);
    iguais(X1, X5, X9, J);
    iguais(X3, X5, X7, J)
    ).

iguais(X, X, X, X).

mudar_peca(_,[], _,_, []).
mudar_peca(J, [num(pos(Linha,Coluna), D , V)|Tab], Linha, Coluna, [num(pos(Linha,Coluna), D , J)|Tab1]):-
    V = n,
    mudar_peca(J, Tab, Linha, Coluna, Tab1).
mudar_peca(J, [X|Tab], Linha, Coluna, [X|Tab1]):-
    mudar_peca(J, Tab, Linha, Coluna, Tab1).

other_player(x,o).
other_player(o,x).

escreve(e(_,Tab)):-
    nl,t_print(Tab, 1),nl.

t_print([], _).
t_print([num(_, _, V)|Tab], C):-
    write(V),
    f_print(C, C1, Tab),
    t_print(Tab, C1).
f_print(C, C2, _):-
    C1 is C mod 3,
    C1 \= 0,
    C2 is C + 1,
    write(' | ').
f_print(_, _, []).
f_print(_, C1, _):-
    nl,writeln('--+---+--'),
    C1 is 1.
escreve_vencedor(e(jog(X), _,_)):-
    other_player(X,Y),
nl,nl,write("Vencedor Jogador: "), write(Y), nl.