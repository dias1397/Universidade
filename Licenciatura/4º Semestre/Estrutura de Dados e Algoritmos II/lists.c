#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <unistd.h>
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
	
}

bool list_remove(struct list *list, int element)
{
	
}

void list_print(struct list *list)
{
	
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

	switch (read(fd))
		{
			case -1:
				perror("read");
				close(fd);

			default:
				return 

		}

	
}

int list_close(struct list *list)
{

}