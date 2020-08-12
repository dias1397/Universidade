#ifndef DIVISAO_H
#define DIVISAO_H

#define SIZE_DIVISAO 400
#define SIZE_REGIAO 1000

#include "divisao_regiao.h"

typedef struct
{
	int id;					// 4
	char nome[140];			// 140
	int lig[10];			// 40
	short n_ligacoes;		// 2
	int pos_x;				// 4
	int pos_y;				// 4
	int n_habitantes;		// 4
}divisao;					// 198

typedef struct
{
	int  id;				// 4
	char nome[39];			// 39
	int n_divisoes;			// 4
	int pos_regiao;			// 4
}header_regiao;				// 51

typedef struct
{
	int fd;					// 4
	int map[SIZE_REGIAO];	// 4000
}ficheiro;					// 4004

typedef struct
{
	header_regiao *regiao;
	divisao **divisao;
}memory;

header_regiao *global;
ficheiro *ficheiro_new();
ficheiro *ficheiro_open(char *name);

header_regiao *regiao_new(int id, char *nome);
divisao *divisao_new(int id, char *nome, int n_habitantes, int pos_x, int pos_y);

void write_regiao(ficheiro *file, header_regiao *regiao);
header_regiao *read_regiao(ficheiro *file, int id);

void write_divisao(ficheiro *file, table *tab, header_regiao *regiao, divisao *div, bool boolean);
divisao *read_divisao(ficheiro *file, table *tab, int id);

memory *memory_new(header_regiao *regiao);
memory *set_all_in_memory(ficheiro *file, header_regiao *regiao);

bool insert_ligacao(ficheiro *file, table *tab, int src, int dest);

void ficheiro_close(ficheiro *file);

#endif