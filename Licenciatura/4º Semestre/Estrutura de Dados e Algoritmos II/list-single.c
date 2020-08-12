#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "list.h"

#define NIL 0

struct header 
{
  int head;              // cabeça da lista
  int used,              // número de nós já usados
      free;              // cabeça da lista dos nós livres
};

struct node 
{
  int element;           // elemento
  int next;              // próximo nó da lista
};

struct list 
{
  int fd;                // descritor do ficheiro onde a lista reside
  
  struct header header;  // cabeçalho da lista
};



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


struct list *list_open(char *name)
{
	int fd;

	fd = open(name, O_CREAT | O_RDWR);

	if (fd == -1)
	{
		perror("open");

		return NULL;
	}

	
}

int list_close(struct list *list)
{

}