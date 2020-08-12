#include <stdio.h>

int binario(int x){
	int resultado = 0;
	int resto, i = 1;

    while (x!=0)
    {
        resto = x%2;
        x /= 2;
        resultado += resto*i;
        i *= 10;
    }
    return resultado;
}

int main(void){
	printf("%d\n", binario(100));
}