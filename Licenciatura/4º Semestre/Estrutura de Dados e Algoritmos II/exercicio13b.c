#include <stdio.h>

#define TAMANHO 50000

int array[TAMANHO];

void create(int n)
{
	for (int i = 0; i < n; i++)
		array[i] = ((i + 1) * 2);
}

int procurar(int n, int x[], int numero)
{
	for (int i = 0; x[i] > numero; i++)
	{
		if (x[i] == numero)
			return i;
	}
	return -1;
}

int main(void)
{
	create(TAMANHO);

	for (int i = 1; i < TAMANHO; ++i)
	{
		if (procurar(TAMANHO, array, i * 2) == -1)
			printf("ERRO N0 NUMERO : %d\n", i * 2);
	}

	return 0;
}