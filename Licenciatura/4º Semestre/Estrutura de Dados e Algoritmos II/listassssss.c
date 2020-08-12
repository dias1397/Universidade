#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "list.h"

struct node
{
	int element;

	struct node *next;
};

struct node *node_new()
{
  struct node *node = malloc(sizeof(struct node));
  
  node->next = NULL;

  return node;
}

// cabeçalho da lista
struct list
{
	struct node *head;

	int size;
};

struct list *list_new()		//nova lista
{
	struct list *list = malloc(sizeof(struct node));

	list->head = node_new();

	list->size = 0;

	return list;
}


bool list_empty(struct list *list)
{
	return list->size == 0;
}

bool list_insert(struct list *list, int element)
{
	struct node *node = node_new();

	if(node == NULL)
		return false;

	node->element = element;

	node->next = list->head;

	list->head = node;										

	list->size++;

	return true;
}

void list_print(struct list *list)
{
	struct node *pointer = node_new();

	pointer = list->head;

	printf("[ ");
	while(pointer->next!=NULL)
	{
		printf("%d ", pointer->element);
		pointer = pointer->next;
	}
	printf("]\n");
}

int list_find(struct list * list, int element)
{
	struct node *pointer = node_new();

	pointer = list->head;

	for (int i=0; i<list->size; i++)
	{
		if(pointer->element==element)
			return i;
		pointer = pointer->next;
	}

	return -1;
}

bool list_remove(struct list *list, int element)
{
	struct node *pointer = node_new();
	struct node *pointer2 = node_new();

	pointer = list->head;

	int pos = list_find(list, element);

	if(pos==-1)
		return false;

	for(int i=0; i<pos-1; i++)
		pointer = pointer->next;

	pointer2 = pointer->next;

	pointer->next = pointer->next->next;

	pointer = pointer->next;

	list->size--;
	
	free(pointer2);

	return true;
}

void node_destroy(struct node *node)					
{
	if(node->next!=NULL)
		node_destroy(node->next);

	free(node);
}

void list_destroy(struct list *list)
{
	node_destroy(list->head);

	free(list);
}

int list_length(struct list *list)
{
	return list->size;
}

int list_nth(struct list *list, int n)
{
  struct node *node = list->head;

  for (; n > 0; --n)
    node = node->next;

  return node->element;
}



struct list *list_open(char *name)
{
	
}

int list_close(struct list *list)
{

}