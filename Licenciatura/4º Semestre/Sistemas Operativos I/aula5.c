#include <stdio.h>

void funcaoTeste(char* array)
{
	printf("\nTeste a fazer print de dentro da funcao: %s\n", array);
}

int main()
{
	char* string = "";
	printf("\nInsira o texto para a string\n");
	scanf("%[0-9a-zA-Z]s ", &string); //diferente que apenas &s
	printf("\nTexto inserido: %s \n", &string);

	printf("\n################## \n");

	//chamada da funcao q recebe a string para testar
	funcaoTeste(&string);

	return 0;
}