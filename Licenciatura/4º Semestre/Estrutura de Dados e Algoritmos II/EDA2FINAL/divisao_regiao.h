#ifndef DIVISAO_REGIAO_H
#define DIVISAO_REGIAO_H

typedef struct
{
	int p_regiao;		// 4
	int p_divisao;		// 4
}position;				// 8

typedef struct
{
	int fd;
}table;

table *table_new();
table *table_open(char *name);

void table_write(table *tab, int id_divisao, int p_regiao, int p_divisao);

position *table_search(table *tab, int id_divisao);

void table_close(table *tab);

#endif