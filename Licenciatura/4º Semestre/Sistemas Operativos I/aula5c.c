#include <stdio.h>
#include <stdlib.h>

int main()
{
	FILE* ficheiro;
	char* linha = NULL;
	size_t len = 0;
	ssize_t read;
	int i = 0;

	char* array[10];

	ficheiro = fopen("texto.txt", "r");
	if (ficheiro == NULL)
	{
		printf("\nFicheiro nao encontrado!");
	}
	else
	{
		while ((read = getline(&linha, &len, ficheiro)) != -1)
		{
			array[i] = linha;
			printf("%s\n", array[i]);
			i++;
		}
	}
	i--;

	fclose(ficheiro);

	FILE *ficheiro2;
	ficheiro2 = fopen("ficheiro.txt", "a");

	for (int i; i<=0; i--)
	{
		//char* texto = &array[i];
		fprintf(ficheiro2, "%s", &array[i]);
		printf("Foi escrito: %s", &array[i]);
	}

	fclose(ficheiro2);


	return 0;

}