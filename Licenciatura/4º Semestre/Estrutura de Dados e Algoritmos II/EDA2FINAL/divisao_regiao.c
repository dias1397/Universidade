#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "divisao_regiao.h"

table *table_new()
{
	table *table = malloc(sizeof(table));
	return table;
}

table *table_open(char *name)
{
	table *tab = table_new();
	tab->fd = open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);

	if (tab->fd == -1)
	{
		perror("open");
	}
	int x = tab->fd;
	switch(read(tab->fd,tab, sizeof(table)))
	{
		case -1:
			perror("read");
			return NULL;
		case 0:
			write(tab->fd,&tab, sizeof(table));
			lseek(tab->fd, (sizeof(table)+sizeof(position)*999999), SEEK_SET);
			
			position pos;
			pos.p_regiao  = 0;
			pos.p_divisao = 0;
			
			write(tab->fd, &pos, sizeof(position));
			return tab;
		default:
			tab->fd = x;
			return tab;
	}
}

void table_write(table *tab, int id_divisao, int p_regiao, int p_divisao)
{
	lseek(tab->fd, (sizeof(table)+sizeof(position)*id_divisao), SEEK_SET);

	position temp;

	if (p_regiao == 0)
		p_regiao = -1;
	if (p_divisao == 0)
		p_divisao = -1;

	temp.p_regiao  = p_regiao;
	temp.p_divisao = p_divisao;

	write(tab->fd, &temp, sizeof(position));
}

position *table_search(table *tab, int id_divisao)
{
	lseek(tab->fd, (sizeof(table)+sizeof(position)*id_divisao), SEEK_SET);

	position *temp = malloc(sizeof(position));

	read(tab->fd, temp, sizeof(position));

	if (temp->p_regiao == 0 && temp->p_divisao == 0)
		return NULL;

	if (temp->p_divisao == -1)
		temp->p_divisao = 0;
	if (temp->p_regiao == -1)
		temp->p_regiao = 0;

	return temp;
}

void table_close(table *tab)
{
	close(tab->fd);
	free(tab);
}

