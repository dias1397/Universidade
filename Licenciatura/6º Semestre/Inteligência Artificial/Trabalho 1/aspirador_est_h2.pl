% heuristica 2
% numero de salas sujas

heuristica(estado(robo(_, _), sala(_, sujas(Dirt), _)), Val):-
        length(Dirt, Val).
