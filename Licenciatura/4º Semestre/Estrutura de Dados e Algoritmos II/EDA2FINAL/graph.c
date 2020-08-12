#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>
#include <limits.h>
#include <math.h>

#include "queue.h"
#include "graph.h"
#include "divisao.h"

list *initialize_single_source(memory *mem, divisao *div)
{
	list *list = list_new(mem->regiao->n_divisoes+1);

	for (int i=0; i < mem->regiao->n_divisoes; i++)
	{
		if (mem->divisao[i]->id == div->id)
			enqueue(list, mem->divisao[i], 0);
		else
			enqueue(list,mem->divisao[i], INT_MAX);
	}
	sort_queue(list, list->ini, list->fim-1);

	return list;
}

void relax(list *list, node *u, int id, int p, node* to_change)
{
	if (u->peso == 0)
	{
		change(list, to_change, p);
		sort_queue(list, list->ini, list->fim-1);
	}
	if (to_change->peso > p + u->peso)
	{
		change(list, to_change, p + u->peso);
		sort_queue(list, list->ini, list->fim-1);
	}
}

int travel_weight(node *src, node *dest, bool ultima)
{
	long x = pow( ((dest->divisao->pos_x) - (src->divisao->pos_x)), 2);
	long y = pow( ((dest->divisao->pos_y) - (src->divisao->pos_y)), 2);

	int peso = sqrt( x + y );
	peso = (peso * 60) / 70000;

	if (src == dest)
		return 0;
	if (ultima)
		return peso;
	else
	{
		if (dest->divisao->n_habitantes < 5000)
		{
			peso += 1;
			return peso;
		}
		else
		{
			peso += dest->divisao->n_habitantes / 5000;
			return peso;
		}
	}
}

int dijkstra(memory *mem, divisao*src, divisao *end)
{
	list *list = initialize_single_source(mem, src);
	while (!empty(list) && list->array[list->ini]->divisao->id != end->id)
	{
		node *u = dequeue(list);

		for (int i=0; i < u->divisao->n_ligacoes; i++)
		{
			if (u->divisao->lig[i] == end->id)
			{
				node *v = search_queue(list, u->divisao->lig[i]);
				relax(list, u, u->divisao->id, travel_weight(u, v, true), v);
			}
			else if (search_queue(list, u->divisao->lig[i]) != NULL)
			{
				node *v = search_queue(list, u->divisao->lig[i]);
				relax(list, u, u->divisao->id, travel_weight(u, v, false), v);
			}
		}
	}

	node *no = search_queue(list, end->id);
	return no->peso;
}