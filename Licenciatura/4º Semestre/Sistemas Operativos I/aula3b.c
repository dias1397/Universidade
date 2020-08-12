#include <stdio.h>
#include <math.h>


double raizes(int n)
{
	double soma = 0;

	for (int i=1; i<=n; i++)
		soma += sqrt(i);

	return soma;
}


int main()
{
	printf("%f\n", raizes(1000000000));

	return 0;
}