#include<stdio.h>
int fib_rec(int x){
	if (x==1){
		return 0;
	}
	if (x==2 || x==3){
		return 1;
	}else{
		return fib_rec(x-1) + fib_rec(x-2);
	}
}


int fib_ite(int y){
	int a = 0;		// n-2
	int b = 1;		// n-1
	int t = b + a;	// n
	if (y == 1){
		return 0;
	}
	for (int i = 2; i < y+1; i++)
	{
		t = b+a;
		b = a;
		a = t;
	}
	return t;
}

int main(){
	for (int i=1; i<21; i++){
		printf("%5d", fib_rec(i));
	}
	printf("\n");
	for (int i = 1; i < 21; i++){
		printf("%5d", fib_ite(i));
	}
}