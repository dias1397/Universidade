#include <stdio.h>

long recursiva(int x)
{
	if(x==1)
		return 1;
	else
		return x*recursiva(x-1);
}

long iterativa(int y)
{
	long resultado=y;

	for(int i=y; i>1; i--)
		resultado *= (i-1);

	return resultado;
}

int main(){
	printf("10! -recursiva --> %llu\n", recursiva(10));
	printf("20! -recursiva --> %llu\n", recursiva(20));
	printf("10! -iterativa --> %llu\n", iterativa(10));
	printf("20! -iterativa --> %llu\n", iterativa(20));
}