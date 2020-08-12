#include <stdio.h>
#include <math.h>
#include <time.h>

#define MAX 1000000000
int main()
{  
  long double i;
  long double sum = 0;
  
  for (i = 1; i <= MAX; i++) {
    sum = sum + sqrtl(i);
    //printf("%Lf\n", sum);
  }
  
  printf("SUM: %Lf\n", sum);  
}

