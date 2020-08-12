#include <stdio.h>

long fibonacci(int n)
{
	static long array[100];

	if (array[n] != 00)
		return array[n];

	if (n == 0)
		return 0;
	else if (n == 1)
		return 1;
	else{
		array[n] = fibonacci(n - 1) + fibonacci(n - 2);
		return array[n];
	}
}

int main(void)
{
	for (int i = 0; i < 500; ++i)
	{
		printf("%d --> %llu\n", i, fibonacci(i));
	}
}