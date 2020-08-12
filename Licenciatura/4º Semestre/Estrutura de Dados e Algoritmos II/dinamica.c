#include <stdio.h>
#include <stdlib.h>

#define MIN(X, Y) (((X) < (Y)) ? (X) : (Y));

int num_moedas(int quantia, int moedas_disp, int * m) {
    int dp[quantia+1];

    // caso base
    dp[0] = 0;

    // sub-problemas
    for(int i=1; i<=quantia; i++) 		//quantia a tratar
    {
        dp[i] = 1000000;

        for(int j=0; j<moedas_disp; j++) {
            if( i-m[j] >= 0) {
                dp[i] = MIN(dp[i], 1 + dp[ i-m[j] ]);
            }
        }
    }

    // solução
    return dp[quantia];
}

int main(void)
{
	int moedas[3] = {1,3,4};

	printf("%d\n", num_moedas(13,3, moedas));
}