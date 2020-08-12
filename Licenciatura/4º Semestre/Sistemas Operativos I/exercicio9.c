#include <stdio.h>

int baz(int n)
{
  int f, g;

  if (n = 0)
    return f;
  else
    n * baz(n - 1);
}

int main(void)
{
  printf("%d\n", baz(0));

  return 0;
}