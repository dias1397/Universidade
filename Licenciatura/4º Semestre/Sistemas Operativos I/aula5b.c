#include <stdio.h>
#include <stdlib.h>

int main()
{
/*	FILE* ficheiro;
	char* linha = NULL;
	size_t len = 0;
	ssize_t read;

	ficheiro = fopen("texto.txt", "r");
	if (ficheiro == NULL)
	{
		printf("\nFicheiro nao encontrado!");
	}
	else
	{
		while ((read = getline(&linha, &len, ficheiro)) != -1)
		{
			printf("Linha lida: %s\n", linha);
		}
	}

	fclose(ficheiro);
*/

	FILE *ficheiro;
	ficheiro = fopen("texto.txt", "a");

	char* texto = "A escrita em ficheiros e bastante simples \n";
	fprintf(ficheiro, "%s", texto);
	printf("Foi escrito: %s", texto);

	fclose(ficheiro);

	return 0;
}