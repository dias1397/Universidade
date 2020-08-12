 #include <stdio.h>

int compara(char *x, char *y)
{
	while (*x != '\0')
	{
		if (*y == '\0')
		{
			return 1;
		}

		if (*y > *x)
		{
			return -1;
		}

		if (*x > *y)
		{
			return 1;
		}

		x++;
		y++;
	}

	if (*y != '\0')
	{
		return -1;
	}	
}

int my_strcmp(char *x, char *y)
{
	if (*x == '\0' && *y == '\0'){
		return 1;
	}

	if (*x == *y){
		x++;
		y++;

		return my_strcmp(x, y);
	}

	if (*y > *x)
		{
			return -1;
		}

	if (*x > *y)
		{
			return 1;
		}

	return -1;
}

int main(void)
{
	printf("%d\n", my_strcmp("abc","abcde"));


	return 0;
}