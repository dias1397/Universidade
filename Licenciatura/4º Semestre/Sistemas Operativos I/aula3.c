#include <stdio.h>
#include <math.h>
#include <pthread.h>

#define N 100000000

double soma = 0;



void* raiz1(void* unused)
{
	for (int i=1; i<(N/4); i++)
		soma += sqrt(i);

	return NULL;
}

void* raiz2(void* unused)
{
	for (int j=(N/4); j<(N/2); j++)
		soma += sqrt(j);

	return NULL;
}

void* raiz3(void* unused)
{
	for (int k=(N/2); k<(3*(N/4)); k++)
		soma += sqrt(k);

	return NULL;
}

void* raiz4(void* unused)
{
	for (int l=(3*(N/4)); l<=N; l++)
		soma += sqrt(l);

	return NULL;
}


int main()
{
//	printf("%f\n", raizes(20));

	pthread_t thread_id1, thread_id2, thread_id3, thread_id4;

	/*Create a new thread. The new thread will run the print_xs() function */
	pthread_create(&thread_id1, NULL, &raiz1, NULL);


	pthread_create(&thread_id2, NULL, &raiz2, NULL);


	pthread_create(&thread_id3, NULL, &raiz3, NULL);


	pthread_create(&thread_id4, NULL, &raiz4, NULL);


	pthread_join(thread_id1, NULL);
	pthread_join(thread_id2, NULL);
	pthread_join(thread_id3, NULL);
	pthread_join(thread_id4, NULL);

	printf("%f\n" , soma);

	return 0;
}


/*void* raiz1(void* unused)
{
	for (int i=1; i<=(N/2); i++)
		soma += sqrt(i);

	return NULL;
}

void* raiz2(void* unused)
{
	for (int i=((N/2)+1); i<=N; i++)
		soma += sqrt(i);

	return NULL;
}
*/