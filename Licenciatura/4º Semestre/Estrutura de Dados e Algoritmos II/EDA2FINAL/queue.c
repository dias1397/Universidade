#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>
#include <limits.h>

#include "queue.h"
#include "divisao.h"


node *node_new(divisao *div, int p)
{
	node *node = malloc(sizeof(node));
	node->divisao = div;
	node->peso = p;

	return node;
}

list *list_new(int array_size)
{
	list *list = malloc(sizeof(list));
	list->array = malloc(sizeof(node) * array_size);
	list->ini = 0;
	list->fim = 0;
	list->tam = array_size;

	return list;
}

int list_add(list *list, int i)		
{
	return (i + 1) % list->tam;
}

int size(list *list)				
{
	return (list->tam - list->ini + list->fim) % list->tam;
}

void enqueue(list *list, divisao *div, int p)
{
	list->array[list->fim] = node_new(div, p);
	list->fim = list_add(list, list->fim);
}

node *dequeue(list *list)
{
	if (list->fim == list->ini)
		return NULL;

	node *node = list->array[list->ini];
	list->ini = list_add(list, list->ini);

	return node;
}

int find_min(list *list, int i, int j)
{
	int temp = j;
	for (int a=i; a != j; a = list_add(list, a))
	{
		if (list->array[temp]->peso > list->array[a]->peso)
		{
			temp = a;
		}
	}
	return temp;
}

void sort_queue(list *list, int i, int j)
{
	if (i == j)
		return;

	int temp = find_min(list, i, j);
	
	node *node = list->array[i];
	list->array[i] = list->array[temp];
	list->array[temp] = node;

	sort_queue(list, list_add(list, i), j);
}

void list_print(list *list)
{
	printf("+ lista: ");
	for (int i=list->ini; i != list->fim; i = list_add(list, i))
		printf("%d ", list->array[i]->divisao->id);
	printf("\n");
}

bool empty(list *list)			
{
	return list->fim == list->ini;
}

void change(list *list, node *no, int p)
{
	no->peso = p;
	sort_queue(list, list->ini, list->fim-1);
}

node *search_queue(list *list, int id)
{
	int i=list->ini;
	for (; i < list->fim; i = list_add(list, i))
		if (list->array[i]->divisao->id == id)
		{
			return list->array[i];
		}

	return NULL;
}