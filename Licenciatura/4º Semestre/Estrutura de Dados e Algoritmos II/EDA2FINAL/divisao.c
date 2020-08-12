#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

#include "divisao.h"

ficheiro *ficheiro_new()
{
	ficheiro *file = malloc(sizeof(ficheiro));
	return file;
}

ficheiro *ficheiro_open(char *name)
{
	ficheiro *file = ficheiro_new();
	file->fd = open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);

	if (file->fd==-1)
	{
		perror("open");
	}

	int x = file->fd;
	switch (read(file->fd,file, sizeof(ficheiro)))
	{
		case -1:
			perror("read");
			return NULL;
		case 0:
			write(file->fd,&file, sizeof(ficheiro));
			return file;
		default:
			file->fd = x;
			return file;
	}
}

header_regiao *regiao_new(int id, char *nome)
{
 	header_regiao *regiao = malloc(sizeof(header_regiao));

 	strcpy(regiao->nome, nome);
 	regiao->id = id;

 	regiao->n_divisoes = 0;
 	regiao->pos_regiao = -1;

 	return regiao;
}

divisao *divisao_new(int id, char *nome, int n_habitantes, int pos_x, int pos_y)
{
	divisao *div = malloc(sizeof(divisao));
	strcpy(div->nome, nome);
	div->id = id;

	div->n_habitantes = n_habitantes;
	div->n_ligacoes = 0;
	div->pos_x = pos_x;
	div->pos_y = pos_y;

	return div;
}

void write_regiao(ficheiro *file, header_regiao *regiao)
{	
	int pos = regiao->id % SIZE_REGIAO;					
	
	while(file->map[pos]!=0 && file->map[pos]!=regiao->id && file->map[pos]!=-1)
		pos = (pos + 1) % SIZE_REGIAO;
	
	regiao->pos_regiao = pos;

	if (pos==-1)
		pos = 0;

	lseek(file->fd, (sizeof(ficheiro) + 
		(sizeof(header_regiao) + sizeof(divisao)*SIZE_DIVISAO) * pos), SEEK_SET);
	
	if (file->map[pos] == regiao->id)
	{
		header_regiao temp;
		read(file->fd, &temp, sizeof(header_regiao));
		regiao->n_divisoes = temp.n_divisoes;
		printf("+ regiao %04d renomeada\n", regiao->id);

		lseek(file->fd, (sizeof(ficheiro) + 
			(sizeof(header_regiao) + sizeof(divisao)*SIZE_DIVISAO) * pos), SEEK_SET);
	}
	else if (file->map[pos]==0)
		printf("+ regiao %04d criada\n", regiao->id);

	write(file->fd, regiao, sizeof(header_regiao));
	
	if (regiao->id==0)
		file->map[pos] = -1;
	else
		file->map[pos] = regiao->id;
}

header_regiao *read_regiao(ficheiro *file, int id)
{
	if (id == 0)
		id = -1;

	header_regiao *regiao = malloc(sizeof(header_regiao));
	
	int pos = id % SIZE_REGIAO;

	while(file->map[pos] != id )
	{
		pos = (pos + 1) % SIZE_REGIAO;
		if (file->map[pos] == 0)
			return NULL;
	}

	lseek(file->fd, (sizeof(ficheiro) +
		(sizeof(header_regiao) + sizeof(divisao)*SIZE_DIVISAO) * pos), SEEK_SET);
	read(file->fd, regiao, sizeof(header_regiao));

	return regiao;
}

void write_divisao(ficheiro *file, table *tab, header_regiao *regiao, divisao *div, bool boolean)
{
	position *pos = table_search(tab, div->id);

	int temp_a, temp_b;

	if (pos == NULL)
	{
		temp_a = regiao->pos_regiao;
		temp_b = regiao->n_divisoes;
		regiao->n_divisoes = regiao->n_divisoes + 1;

		table_write(tab, div->id, temp_a, temp_b);
		printf("+ divisao %06d criada\n", div->id);
	}
	else
	{
		temp_a = pos->p_regiao;
		temp_b = pos->p_divisao;
	}

	lseek(file->fd, (sizeof(ficheiro) + 
		(sizeof(header_regiao) + sizeof(divisao) * SIZE_DIVISAO) * temp_a), SEEK_SET);

	if (pos == NULL)
	{		
		write(file->fd, regiao, sizeof(header_regiao));
		lseek(file->fd, (sizeof(divisao) * temp_b), SEEK_CUR);
	}
	else
	{		
		lseek(file->fd, (sizeof(header_regiao)) + (sizeof(divisao) * temp_b), SEEK_CUR);
		
		if (boolean)
		{
			divisao temp;
			read(file->fd, &temp, sizeof(divisao));
			for (int i =0; i < temp.n_ligacoes; i++)
				div->lig[i] = temp.lig[i];
			
			div->n_ligacoes = temp.n_ligacoes;

			lseek(file->fd, (sizeof(ficheiro) + 
				(sizeof(header_regiao) + sizeof(divisao)*SIZE_DIVISAO) * temp_a), SEEK_SET);
			lseek(file->fd, (sizeof(header_regiao)) + (sizeof(divisao) * temp_b), SEEK_CUR);

			printf("+ divisao %06d alterada\n", div->id);
		}
	}
	write(file->fd, div, sizeof(divisao));

	free(div);
	free(pos);
}

divisao *read_divisao(ficheiro *file, table *tab, int id)
{
	position *pos = table_search(tab, id);

	if (pos == NULL)
		return NULL;

	lseek(file->fd, (sizeof(ficheiro) +
		(sizeof(header_regiao) + sizeof(divisao)*SIZE_DIVISAO) * pos->p_regiao), SEEK_SET);
	lseek(file->fd, (sizeof(header_regiao) + sizeof(divisao) * pos->p_divisao), SEEK_CUR);

	divisao *div = malloc(sizeof(divisao));

	read(file->fd, div, sizeof(divisao));

	free(pos);

	return div;
}	

memory *memory_new(header_regiao *regiao)
{
	memory *mem = malloc(sizeof(memory));
	mem->regiao = regiao;
	mem->divisao = malloc(sizeof(divisao) * regiao->n_divisoes);
	return mem;
}

memory *set_all_in_memory(ficheiro *file, header_regiao *regiao)
{
	memory *mem = memory_new(regiao);

	lseek(file->fd, (sizeof(ficheiro) +
		(sizeof(header_regiao) + sizeof(divisao)*SIZE_DIVISAO) * regiao->pos_regiao) 
			+ sizeof(header_regiao) , SEEK_SET);

	for (int i=0; i<regiao->n_divisoes; i++)
	{
		divisao *div = malloc(sizeof(divisao));
		read(file->fd, div, sizeof(divisao));
		mem->divisao[i] = div;
	}

	return mem;
}

bool insert_ligacao(ficheiro *file, table *tab, int src, int dest)
{
	divisao *source = malloc(sizeof(divisao));
	source = read_divisao(file, tab, src);
	if (source==NULL)
		return false;

	divisao *destiny = malloc(sizeof(divisao));
	destiny = read_divisao(file, tab, dest);
	if (destiny==NULL)
		return false;

	position *pos = table_search(tab, source->id);
	header_regiao *regiao = malloc(sizeof(regiao));
	regiao = read_regiao(file, pos->p_regiao);


	int i=0;
	for (; i<=10; i++)
		if (source->lig[i]==0)
			break;

	int j=0;
	for (; j<=10; j++)
		if (destiny->lig[j]==0)
			break;

	source ->lig[i] = destiny->id;
	destiny->lig[j] = source->id;

	source->n_ligacoes += 1;
	destiny->n_ligacoes += 1;

	write_divisao(file, tab, regiao, source, false);
	write_divisao(file, tab, regiao, destiny, false);

	return true;
}

void ficheiro_close(ficheiro *file)
{
	lseek(file ->fd, 0, SEEK_SET);
	write(file -> fd, file, sizeof(ficheiro));

	close(file->fd);
	free(file);
}