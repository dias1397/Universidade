#include <stdio.h>

int is_primo(int x){
	for(int i=2; i<=x/2; i++){
		if(x%i==0){
			return 0;	//falso
		}
	}
	return 1;
}

int main(void){
	for(int i=555; i<=777; i++){
		if(is_primo(i)==1){
			printf("%4d", i );
		}
	}
}