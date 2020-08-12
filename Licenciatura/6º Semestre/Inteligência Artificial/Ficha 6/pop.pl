/*
    Processamento de grafos.

    É usado para:
    - Testar se a ordem dum plano é cíclica.
    - Linearizar as ações dum plano.
*/
:- use_module(library(ugraphs)).
/*
    Formulação de um problema de **planeamento parcialmente ordenado**
    como um **problema de pesquisa**:

    (É preciso definir o estado_inicial, o estado_final e as transições tr(E0, A, E1, C).)

    O **estado inicial** é simples de definir: 
        inclui um passo inicial, com os efeitos do inicio do plano e
        um passo final, com precondicoes iguais ao objetivo do plano.

    Um **estado final** é qualquer plano com todas as precondições satisfeitas.

    Só há uma **transição**, que consiste em **refinar** um plano. A acção refinar consistem em:
    
        0. Seja P = plano(Passos, Ordem, Arestas).
        1. Encontrar um passo A nos passos, com alguma pré-condição, P, insatisfeita.
        2. Encontrar um passo do plano ou uma ação do problema, B, que satisfaça P.
        3. Acrescentar:
            a) Um passo derivado de B aos passos do plano.
            b) As restricoes de ordem:  1 < B.Id, B.Id < 2, B.Id < A.Id
            c) Uma aresta B.Id -- P -> A.Id, a **proteger a pré-condição** P entre B e A.
        4. Testar se o passo anterior introduziu alguma **inconsistência**:
            a) A nova ordem é **cíclica** ou
            b) Existe alguma **aresta ameaçada**. Um passo C ameaça a aresta A -- P -> B SSE
                - C remove P.
                - P plano **permite** A < C < B. 
            Neste caso o plano poderá ser ajustado, promovendo ou despromovendo C: Forçar C < A ou B < C ou ambos.

        Diferentes sucessores de um estado resultam de

        - A escolha do passo + pré-condição insatisfeita.
        - A escolha do passo / ação para satisfazer a pré-condição.

*/

estado_inicial(
    plano(
        [
            passo(1, inicial, [], strips([], Inicial, [])),
            passo(2, final, Objetivo, strips(Objetivo, [], []))
        ], [
            1 - 2
        ], [
        ])) 
:-
    inicio(Inicial),
    objetivo(Objetivo).

estado_final(plano(Passos, _, _)) :-
    findall(Abertas,
        ( 
            member(passo(_, _, Abertas, _), Passos),
            Abertas \= []
        ),
        []).

tr(P0, r, P1, 1) :- 
    refinar(P0, P),
    resolver_inconsistencias(P, P1).

heuristica(P, X) :-
    contar_abertas(P, X).

contar_abertas(plano(Passos, _, _), N) :-
    contar_abertas(Passos, N).

contar_abertas([], 0).
contar_abertas([passo(_, _, Abertas, _) | R], C) :-
    contar_abertas(R, CR),
    length(Abertas, CA),
    C is CR + CA.

/*
    Refinar um plano:
    1. Encontrar um passo, A, com uma pre-condição insatisfeita.
    2. Selecionar um passo ou uma ação, B, que satisfaça essa pré-condição.
    3. Compor um plano que inclua B antes de A.
*/
refinar(plano(Passos, Ordem, Arestas), plano(Passos_1, Ordem_1, Arestas_1)) :-
    %
    % Escolher um passo ...
    %
    select(passo(A_Id, A_Nome, A_Abertas, A_Strips), Passos, Passos_restantes),
    %
    % ... com uma precondição insatisfeita, Prec
    %
    select(Prec, A_Abertas, A_Abertas_restantes),
    %
    % Modificar o passo escolhido, retirando aquela pré-condição
    %
    A = passo(A_Id, A_Nome, A_Abertas_restantes, A_Strips), 
    %
    % Fixar esta pré-condição neste passo do refinamento.
    %
    !,
    %
    % Escolher uma operação para satisfazer a pré-condição.
    %
    escolher_operacao(
        Prec, A_Id, Passos_restantes,
        Operacao, Novas_Ordens, Novas_Arestas),
    %
    % Atualizar Passos, Ordens e Arestas
    %
    append([A | Operacao], Passos_restantes, Passos_1),
    %
    append(Novas_Ordens, Ordem, Ordem_L),
    % remover ordens duplicadas...
    list_to_set(Ordem_L, Ordem_1),
    %
    append(Novas_Arestas, Arestas, Arestas_1).
/*
    Escolher a operação para resolver pré-condição insatisfeita.

    escolher_operacao(Prec, A_Id, Passos, Novos_Passos, Novas_Ordens, Novas_Arestas)

    Argumentos

    Prec:           A pré-condição.
    A_Id:           A (identificação do) passo onde está a pré-condição.
    Passos:         O conjunto dos passos candidatos a resolver a pré-condição.
    --
    Novos_Passos:   Passos a acrescentar ao plano, para resolver a pré-condição.
    Novas_Ordens:   Prioridades a acrescentar ao plano.
    Novas_Arestas:  Proteções a acrescentar ao plano.

    Se a resolução for um passo, B, já presente no plano:
        Novos_Passos: [].
        Novas_Ordens: [ B_Id < A_Id ].
        Novas_Arestas: [ Prec @ B_Id - A_Id ].

    Se a resolução for uma nova ação, B:
        Novos_Passos: [ B ].
        Novas_Ordens: [ 1 < B_Id, B_Id < 2, B_Id < A_Id ].
        Novas_Arestas: [ Prec @ B_Id - A_Id ].
*/
escolher_operacao(Prec, A_Id, Passos, [], [B_Id - A_Id], [aresta(B_Id, Prec, A_Id)]) :-
    %
    % Escolher **um passo no plano**...
    %
    member(passo(B_Id, _, _, strips(_, B_Acr, _)), Passos), 
    %
    % ... que satisfaz Prec.
    %
    member(Prec, B_Acr).

escolher_operacao(Prec, A_Id, Passos_restantes, [B], [1 - B_Id, B_Id - 2, B_Id - A_Id], [aresta(B_Id, Prec, A_Id)]) :-
    %
    % Escolher **uma ação no enunciado do problema**...
    %
    acao(B_Nome, B_Prec, B_Acr, B_Rem),
    %
    % ... que satisfaz Prec.
    %
    member(Prec, B_Acr),
    %
    % Compor o novo passo B.
    %
    length(Passos_restantes, N),
    B_Id is N + 2,
    B = passo(B_Id, B_Nome, B_Prec, strips(B_Prec, B_Acr, B_Rem)).
/*
    Resolver inconsistências:
    
    0. Planos consistentes **não** têm inconsistências.

    1. Confirmar que a ordem **não** é cíclica.
    2. Detetar e Resolver ameaças.
*/
resolver_inconsistencias(P, P) :-
    consistente(P), !.

resolver_inconsistencias(plano(Passos, Ordem, Arestas), P) :-
    aciclica(Ordem),
    detetar_ameacas(plano(Passos, Ordem, Arestas), Ameacas), !,
    resolver_ameacas(Ameacas, plano(Passos, Ordem, Arestas), P).
/*
    Uma ameaça é um passo C e a uma aresta P @ A - B tais que:

    1. C remove P.
    2. A ordem parcial **permite** A < C < B.

    A condição "A < C < B" é difícil de detetar. Uma estratégia possível é:
    - Determinar o "fecho transitivo" de cada elemento X: fecho(X)
        O fecho transitivo de X são todos os Y tais que X < Y.
        O problema é que nem todos esses Y podem estar **explicitamente** 
        presentes na Ordem!
    - Com o fecho transitivo calculado, a condição A < C < B é equivalente a
        ft(A) contém C e ft(C) contém B.
*/
detetar_ameacas(plano(Passos, Ordem, Arestas), Ameacas) :-
    %
    %   Obter o fecho transitivo de cada elemento na ordem.
    %
    vertices_edges_to_ugraph([], Ordem, Grafo),
    transitive_closure(Grafo, Fechos),
    %
    %   Encontrar todos as ameaças (C, P @ A - B)
    %
    findall(
        i(C_Id, A_Id, B_Id),
        (
            % Escolher um passo, C
            member(passo(C_Id, _, _, strips(_, _, C_Rem)), Passos),
            % Escolher uma aresta, P @ A - B
            member(aresta(A_Id, P, B_Id), Arestas),
            % C não é nenhum dos extremos da aresta.
            A_Id \= C_Id, B_Id \= C_Id,
            % O passo C remove a condição P...
            member(P, C_Rem),
            % ... e C pode estar entre A e B (os Fechos são usados aqui).
            ameaca_intervalo(C_Id, A_Id, B_Id, Fechos)
        ), 
        Ameacas).
/*
    Detetar se C pode estar entre A e B.

    Os elementos da lista Fechos são da forma X-Fecho_X.
*/
ameaca_intervalo(C, A, B, Fechos) :-
    \+ (
        member(B-Fecho_B, Fechos),
        member(C-Fecho_C, Fechos),
        (
            member(A, Fecho_C) ;
            member(C, Fecho_B)
        )
    ).
/*
    Resolver todas as ameacas.

    resolver_ameacas(Ameacas, Plano_Inicial, Plano_OK).

    0. Os planos consistentes não têm ameaças.
    1. Uma ameaça C, A, B é resolvida:
        a) Forçando C < A, se o plano final for consistente ou ...
        b) Forçando B < C, se o plano final for consistente.
*/
resolver_ameacas([], P, P) :-
    consistente(P), !.

resolver_ameacas([i(C, A, B) | R], plano(P, O, Ar), Final) :-
    resolve(C, A, B, O, O1), 
    resolver_ameacas(R, plano(P, O1, Ar), Final).

consistente(plano(P, O, A)) :-
    aciclica(O),
    detetar_ameacas(plano(P, O, A), []).
/*
    Resolver uma ameaça.
*/
resolve(C, A, _, Ordem, [C - A | Ordem]) :-
    %
    % Acrescentar C < A, se A > 1.
    %
    A \= 1, C \= A.

resolve(C, _, B, Ordem, [B - C | Ordem]) :-
    %
    % Acrescentar B < C, se B < 2.
    %
    B \= 2, C \= B.   

/*
    Escrita de planos, nos, etc
*/

escreve(no(E, _, _)) :- escreve(E).
escreve(no(E, _, _, _)) :- escreve(E).

escreve(plano(P, O, A)) :-nl,
    write(' ** =========================== **'), nl, 
    nl, write(' ** Passos **'), nl, nl,
    escreve(P),
    nl, write(' ** Ordem **'), nl, nl,
    escreve(O),
    nl, write(' ** Arestas **'), nl, nl,
    escreve(A),
    lineariza(plano(P, O, A), Seq),
    assoc_idn(P, Seq, L),
    nl, write(' ** Possível Sequência **'), nl, nl,
    write(L), nl,
    escreve(Seq, P), nl,
    nl, write(' ** =========================== **'), nl.

escreve([]).
escreve([X | L]) :-
    escreve(X), nl, escreve(L).

escreve(A - B) :- write(A), write(' - '), write(B).
escreve(passo(Id, Nome, _, _)) :- write(Id), write(': '), write(Nome).
escreve(aresta(A, P, B)) :- write(P), write(': '), write(A - B).

escreve(Seq, Passos) :-
    member(passo(1, _, _, strips(E, _, _)), Passos),
    escreve(Seq, E, Passos).

escreve([], _, _).
escreve([Id | Resto], E, Passos) :-
    member(passo(Id, P, _, strips(_, A, R)), Passos),
    subtract(E, R, E1),
    append(E1, A, E2),
    nl, write(P), nl, write(' '), write(E2),
    escreve(Resto, E2, Passos).
    

/*
    Linearização de um plano.
    Usa a biblioteca ugraphs do swi prolog.
*/

lineariza(no(P, _, _), L) :-
    lineariza(P, L).

lineariza(plano(_, O, _), S) :-
    vertices_edges_to_ugraph([], O, G),
    top_sort(G, S).

/*
    Testa se uma ordem é acíclica.
    Uma ordem é acíclica sse é possível construir a ordem topológica.
*/

aciclica(O) :-
    vertices_edges_to_ugraph([], O, G),
    top_sort(G, _).

conv_arestas([], []).
conv_arestas([aresta(A, _, B) | R], [A - B | S]) :-
    conv_arestas(R, S).

assoc_idn(_, [], []).
assoc_idn(A, [X | S], [N | L]) :-
    member(passo(X, N, _, _), A),
    assoc_idn(A, S, L).

/*

POP com pesquisa integrada

*/
pop(Plano, Plano, _) :-
    estado_final(Plano).

pop(Plano, Solucao, N) :-
    N >= 0, N1 is N - 1,
    refinar(Plano, P),
    resolver_inconsistencias(P, P1),
    pop(P1, Solucao, N1).

pop_iterativa(Plano, Solucao) :-
    pop_iterativa(Plano, Solucao, 0).

pop_iterativa(Plano, Solucao, N) :-
    time(pop(Plano, Solucao, N)).

pop_iterativa(Plano, Solucao, N) :-
    N1 is N + 1,
    write('** iPOP '), write(N1), write(' **'), nl,
    pop_iterativa(Plano, Solucao, N1).

/*
    Pesquisas adaptados.
*/

teste(Problema) :-
    teste(iterativa, Problema).

teste(pop(N), Problema) :-
    !,
    consult(Problema),
    estado_inicial(E),
    time(pop(E, Solucao, N)),
    escreve(Solucao).

teste(pop, Problema) :-
    !,
    consult(Problema),
    estado_inicial(E),
    time(pop_iterativa(E, Solucao)),
    escreve(Solucao).

teste(aestrela, Problema) :-
    !,
    consult(Problema),
    estado_inicial(E),
    time(aestrela([no(E, 0, 0, 0)], Solucao)),
    escreve(Solucao).

teste(Algoritmo, Problema) :-
    consult(Problema),
    time(pesquisar(Algoritmo, Plano)),
    escreve(Plano).

pesquisar(Algoritmo, Plano) :-
    estado_inicial(E0),
    pesquisa_por(Algoritmo, [no(E0, 0, 0)], Plano).

pesquisa_por(limitada(N), Inicio, Solucao) :-
    limitada(Inicio, Solucao, N, []).


pesquisa_por(iterativa, Inicio, Solucao) :-
    iterativa(Inicio, Solucao, 0).
/*
    Pesquisa Iterativa em Profundidade.
    (Usa a Pesquisa em Profundidade Limitada)
*/
iterativa(Abertas, Solucao, P) :-
    limitada(Abertas, Solucao, P, []).

iterativa(Abertas, Solucao, P) :-
    P1 is P + 1,
    nl, write('** iterativa '), write(P1), write(' **'), nl,
    iterativa(Abertas, Solucao, P1).
/*
    Pesquisa em Profundidade Limitada.
*/
%
% Terminar com um estado final.
%
limitada([no(E, C, P) | _], no(E, C, P), _, _) :-
    estado_final(E), !.
%
% Espandir topo dos candidatos...
%
limitada([No | Resto], S, P, V) :-
    No = no(E, _, _),
    member(E, V), !, % Não expandir em estados visitados
    limitada(Resto, S, P, V).

limitada([No | R], S, P, V) :-
    No = no(E, _, _),
    expande_plim(No, Filhos, P),
    append(Filhos, R, Seguintes),
    limitada(Seguintes, S, P, [E | V]).
%
% Cortar a espansão de nós demasiado profundos.
%
expande_plim(no(_, _, P), [], Plim) :- 
    Plim =< P, !.
%
% Desenvolver os filhos de um nó.
%
expande_plim(no(E, C, P), Filhos, _) :-
    findall(
        no(E1, C1, P1),
        (   tr(E, _, E1, Ctr),
            C1 is C + Ctr,
            P1 is P + 1
        ),
        Filhos).

aestrela([no(E, C, P, H) | _], no(E, C, P, H)) :-
    estado_final(E), !.

aestrela([No | Restantes], Solucao) :-
    expande(No, Filhos),
    append(Filhos, Restantes, Seguintes),
    ordena(Seguintes, Ordenados),
    aestrela(Ordenados, Solucao).

expande(no(E, C, P, H), Filhos) :-
    findall(
        no(E1, C1, P1, H1),
        (
            tr(E, _, E1, CT),
            C1 is C + CT,
            heuristica(E1, HE),
            H1 is H + HE,
            P1 is P + 1
        ),
        Filhos
    ).

ordena(A, B) :-
    assoc(A, HA),
    keysort(HA, AS),
    proj(AS, B).

assoc([], []).
assoc([no(E, C, P, H) | R], [H-no(E, C, P, H) | S]) :-
    assoc(R, S).

proj([], []).
proj([_-V | R], [V | S]) :-
    proj(R, S).
ordem_heuristica(<, no(_, _, _, H1), no(_, _, _, H2)) :- H1 < H2.
ordem_heuristica(=, no(_, _, _, H1), no(_, _, _, H2)) :- H1 = H2.
ordem_heuristica(>, no(_, _, _, H1), no(_, _, _, H2)) :- H1 > H2.