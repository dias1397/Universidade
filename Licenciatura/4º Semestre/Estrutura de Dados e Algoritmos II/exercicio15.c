#include <stdio.h>

int posicao(char x[])
{
	for (int i = 0; i < 100; ++i)
	{
		if (x[i] == '\0')
			return i;
	}
}

int main(void)
{
	char string[] = {'a', 'b', 'c', '\0'};

	printf("%d\n", posicao(string) + 1);
}