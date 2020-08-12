 #include <stdio.h>

int main()  {
	//	& significa “endereço de”
	//	* significa “conteúdo do endereço para onde aponta”
	
	int a = 33;
	int b = 55;
	int *ap=&a; // &a, devolve o endereço de memória de uma variável	
	
	//int *ap;    /* declara um ponteiro para um inteiro */
	//*ap = 33;  /* atribui o valor 33 à variável que está contida no ponteiro */	
	
	
	printf("Valor a: %d\n", a);
	printf("Endereço a: %d\n", &a);
	printf("Valor apontador: %d\n", ap);
	printf("Endereço apontador: %d\n", &ap);
	printf("Valor na memória apontada pelo apontador: %d\n", *ap);
	
	
	//Incrementar a variavel a por via do apontador?		
		
	//ap++;
	//(*ap)++;
	//printf("\nValor na memória apontada pelo apontador: %d\n", *ap);
	
	puts("\n##############");
	
	int *ap1 = &a;
	int *ap2 = &b;
	
	printf("Valores dos apontadores: ap1 %d   ap2 %d \n", ap1, ap2);
	printf("Endereço dos apontadores: ap1 %d   ap2 %d \n", &ap1, &ap2);
	printf("Valor na memória apontada pelos apontadores: ap1 %d   ap2 %d\n", *ap1, *ap2);	
	
	
	//Qual é diferença entre as seguintes operações?
	//ap2=ap1;
	//*ap2=*ap1;	
	
	
	puts("\n\n");
	printf("Valores dos apontadores: ap1 %d   ap2 %d \n", ap1, ap2);
	printf("Endereço dos apontadores: ap1 %d   ap2 %d \n", &ap1, &ap2);
	printf("Valor na memória apontada pelos apontadores: ap1 %d   ap2 %d\n", *ap1, *ap2);	
	
	
	return 1;
}