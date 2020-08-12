#include <stdio.h>

#define TAMANHO 50000

int array[TAMANHO];
int upperBound;
int lowerBound;

void create()
{
	int contador = 2;

	for (int i = 0; i < TAMANHO; i++)
	{
		array[i] = contador;
		contador += 2;
	}
}

int procurar(int x[], int numero)
{
	int midpoint = ((lowerBound + upperBound) / 2);

	if (x[midpoint] == numero){
		printf("%d\n", midpoint);

		return midpoint;
	}

	else if (x[midpoint] > numero)
	{
		upperBound = midpoint;
		procurar(array, numero);
	}
	else /*if (x[midpoint] < numero)*/
	{
		lowerBound = midpoint;
		procurar(array, numero);
	}

	if (upperBound == lowerBound)
		return -1;
}

int main(void)
{
	create();

	for (int i = 1; i <= TAMANHO; i++)
	{
		upperBound = TAMANHO - 1;
		lowerBound = 0;

		if (procurar(array, i * 2) == -1)
			printf("ERRO \n");
	}

	return 0;
}