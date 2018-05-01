:-include('lib_ficha2.pl').
:-include('lib_ficha3.pl').

estado_inicial(estado(
    robo(pos((2,0)), bateria(7)),
    sala(dim(5,3), sujas([(0,0),(4,0),(0,2),(4,2)]), carregador([(2,1)])
))).

estado_final(estado(
    robo(pos(A), bateria(_)),
    sala(_, sujas([]), carregador(B))
)):-
    member(A,B).
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

min(X, Y, X) :-
	X < Y , !.
min(_, Y, Y).

max(X, Y, X) :-
	X > Y, !.
max(_, Y, Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

comandos(no(_, _, nenhuma, _, _)):- writeln(''),write('INICIO').
comandos(no(_, Pai, Op, _, _)):-
    Op \= nenhuma,
    comandos(Pai),
    write(' -> '),
    write(Op).

comandos_stat(stat(X,Y)):-
    writeln(''),
    write('Nós expandidos: '), writeln(X),
    write('Nós em memória: '), writeln(Y),
    writeln('').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

exercicio_1(Algoritmo):-pesquisa('aspirador_op.pl',Algoritmo).

exercicio_2_h1(Algoritmo):-pesquisa_h('aspirador_op.pl',Algoritmo,'aspirador_est_h1.pl').
exercicio_2_h2(Algoritmo):-pesquisa_h('aspirador_op.pl',Algoritmo,'aspirador_est_h2.pl').
