#include<stdio.h>
int main(){
	for(int i=1; i<11; i++ ){
		for (int j=1; j<i+1; j++){
			printf("%5d", j*i);
		}
		printf("\n");
	}
}