estado(me(NME, NCE), b(NMB, NCB), md(NMD, NCD), MARGEM).

estado_inicial(estado(me(3,3), b(0,0), md(0,0), esq)).
estado_final(estado(me(0,0), b(0,0), md(3,3), dir)).

tr(
	estado(ME, b(M, C), MD, dir), 
	rema(esquerda), 
	estado(ME, b(M, C), MD, esq)
):- M + C > 0, M + C <= 2.

tr(
	estado(ME, b(M, C), MD, esq), 
	rema(direita), 
	estado(ME, b(M, C), MD, dir)
):- M + C > 0, M + C <= 2.


tr(
	estado(ME, b(MB ,CB ), md(MD ,CD), direita),
	embarca(missionarios)
) 
