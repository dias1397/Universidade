#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

#include "divisao.h"
#include "divisao_regiao.h"
#include "input.h"
#include "graph.h"

void ir_regiao(ficheiro *file)
{
	char 	codigo[7] = "",
			nome[39] = "";
	scanf("%s %[^\t\n]", codigo, nome);

	header_regiao *regiao = regiao_new(atoi(codigo), nome);
	write_regiao(file, regiao);

	free(regiao);
}

void id_divisao(ficheiro *file, table *tab)
{
	char 	codigo[7] = "",
			nome[141] = "",
			cod_reg[7] = "",
			x[9] = "",
			y[9] = "",
			habit[9] = "";
	scanf("%s %[^\t\n] %s %s %s %s", codigo, nome, cod_reg, x,y, habit);

	if (read_regiao(file, atoi(cod_reg)) == NULL)
		printf("+ regiao %04d inexistente\n", atoi(cod_reg));
	else
	{
		divisao *div = divisao_new(atoi(codigo), nome, atoi(habit), atoi(x), atoi(y));
		position *pos = malloc(sizeof(position));
		pos = table_search(tab, atoi(codigo));

		header_regiao *regiao = malloc(sizeof(header_regiao));
		regiao = read_regiao(file, atoi(cod_reg));

		if (pos == NULL)
		{
			write_divisao(file, tab, regiao, div, false);
		}		
		else if (pos->p_regiao == atoi(cod_reg))	
		{
			if (file->map[pos->p_regiao] == atoi(cod_reg))
				write_divisao(file, tab, regiao, div, true);
			else
				write_divisao(file, tab, regiao, div, false);
		}	
		else
		{
			printf("+ divisao %06d pertence a outra regiao\n", atoi(codigo));
			free(div);
		}			

		free(pos);
		free(regiao);
	}
}

void il_ligacao(ficheiro *file, table *tab)
{
	char 	codigo1[7] ="",
			codigo2[7] ="";
	scanf("%s %s", codigo1, codigo2);
	
	divisao *div1 = malloc(sizeof(divisao));
	div1 = read_divisao(file, tab, atoi(codigo1));
	divisao *div2 = malloc(sizeof(divisao));
	div2 = read_divisao(file, tab, atoi(codigo2));

	bool exist = false;
	int n_existe = 0;

	if (div1 == NULL)
	{
		n_existe++;
		printf("+ divisao %06d inexistente\n", atoi(codigo1));
	}
	if (div2 == NULL && atoi(codigo2) != atoi(codigo1))
	{
		n_existe++;
		printf("+ divisao %06d inexistente\n", atoi(codigo2));
	}

	if (strcmp(codigo1, codigo2) == 0 && n_existe == 0)
		printf("+ ligacao de %06d a si propria\n", atoi(codigo1));
	else if (n_existe == 0)
	{
		for (int i=0; i < div1->n_ligacoes; i++)
		{
			if (div1->lig[i] == atoi(codigo2))
				exist = true;
		}

		if (table_search(tab, atoi(codigo1))->p_regiao != table_search(tab, atoi(codigo2))->p_regiao)
			printf("+ ligacao de divisoes de regioes distintas\n");
		else if (exist)
			printf("+ ligacao %06d - %06d existente\n",atoi(codigo1), atoi(codigo2) );
		else
		{
			insert_ligacao(file, tab, atoi(codigo1), atoi(codigo2));
			printf("+ ligacao %06d - %06d criada\n", atoi(codigo1), atoi(codigo2));
		}
	}
}

void vd_divisao(ficheiro *file, table *tab)
{
	char 	codigo[7] = "";
	scanf("%s", codigo);

	divisao *div = malloc(sizeof(divisao));
	div = read_divisao(file, tab, atoi(codigo));

	if (div == NULL)
		printf("+ divisao %06d inexistente\n", atoi(codigo));
	else
	{
		header_regiao *regiao = malloc(sizeof(header_regiao));
		int x = file->map[table_search(tab, atoi(codigo))->p_regiao];
		regiao = read_regiao(file, x);

		printf("VD %06d\n", atoi(codigo));
		printf("%s\n", div->nome);
		printf("%04d (%s)\n", regiao->id, regiao->nome);
		printf("%d %d\n",div->pos_x, div->pos_y );
		printf("%d\n",div->n_habitantes );

		for (int i=0; i < div->n_ligacoes; i++){
			if (i == (div->n_ligacoes)-1)
				printf("%06d",div->lig[i] );
			else
				printf("%06d ",div->lig[i] );
		}
		printf("\n");
	}
}

void tv_viagem(ficheiro *file, table *tab)
{
	char 	codigo1[7] ="",
			codigo2[7] ="";
	scanf("%s %s", codigo1, codigo2);

	position *pos1 = malloc(sizeof(position));
	pos1 = table_search(tab, atoi(codigo1));

	position *pos2 = malloc(sizeof(position));
	pos2 = table_search(tab, atoi(codigo2));

	if (pos1 == NULL)
		printf("+ divisao %06d inexistente\n", atoi(codigo1));
	if (pos2 == NULL && atoi(codigo1) != atoi(codigo2))
		printf("+ divisao %06d inexistente\n", atoi(codigo2));

	if (pos1 == NULL || pos2 == NULL)
		return;

	if (pos1->p_regiao != pos2->p_regiao)
	{
		printf("+ divisoes de regioes distintas\n");
		return;
	}

	if (strcmp(codigo1, codigo2)==0)
	{
		printf("+ viagem %06d a %06d demora 0 minutos\n",atoi(codigo1), atoi(codigo2) );
		return;
	}

	memory *mem;

	header_regiao *regiao = read_regiao(file, file->map[pos1->p_regiao]);
	mem = set_all_in_memory(file, regiao);
	
	divisao *div1 = mem->divisao[pos1->p_divisao];
	divisao *div2 = mem->divisao[pos2->p_divisao];

	int peso = dijkstra(mem, div1, div2);

	if (peso == INT_MAX)
		printf("+ sem caminho de %06d a %06d\n", atoi(codigo1), atoi(codigo2));
	else
		printf("+ viagem %06d a %06d demora %d minutos\n",atoi(codigo1), atoi(codigo2), peso);

	free(mem);
}

void choice()
{
	ficheiro *file = ficheiro_new();
	table *tab = table_new();

	file = ficheiro_open("regioes");
	tab  = table_open("div_reg");
	
	char 	input[3] = "";

	while (scanf(" %s",  input) != EOF)
	{
		if (strcmp("IR", input)==0)
			ir_regiao(file);
		else if (strcmp("ID", input) == 0)	
			id_divisao(file, tab);
		else if (strcmp("IL", input) == 0)	
			il_ligacao(file, tab);
		else if (strcmp("VD", input) == 0)
			vd_divisao(file, tab);
		else if (strcmp("TV", input) == 0)
			tv_viagem(file, tab);
		else if (strcmp("XX", input) == 0)
			break;
	}
	ficheiro_close(file);
	table_close(tab);
}

int main(void)
{
	choice();

	return 0;
}