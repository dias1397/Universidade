#ifndef QUEUE_H
#define QUEUE_H

#include "divisao.h"

typedef struct node1
{
	divisao *divisao;
	int peso;
}node;

typedef struct list1
{
	int ini;
	int fim;
	int tam;
	node **array;
}list;

node *node_new(divisao *div, int p);
list *list_new(int array_size);

int list_add(list *list, int i);	
int size(list *list);

void enqueue(list *list, divisao *div, int p);
node *dequeue(list *list);

int find_min(list *list, int i, int j);
void sort_queue(list *list, int i, int j);

void list_print(list *list);
bool empty(list*list);

void change(list *list, node *no, int p);
node *search_queue(list *list, int id);

#endif