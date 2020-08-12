%option noyywrap

%{
#include <stdio.h>

int result;
int temp;

int stack[20];
int sp = 0;

int pop();
void push(int val);

%}

NUM	[0-9]+

%%

{NUM}		{push(atoi(yytext)); }
"+"			{result = pop() + pop(); push(result);}
"-"			{temp = pop(); result = pop() - temp; push(result);}
"*"			{result = pop() * pop(); push(result);}
"/"			{temp = pop(); result = pop() / temp; push(result);}
[\n\t ]+ 	{/* ignore whitespace*/}

"show"		{ printf("(%d)\n", pop()); }
.			{ printf("Syntax error.\n"); }

%%

int main(int argc, char *argv[])
{
	while(1)
	{
		yylex();
	}
}

int pop()
{
	if(sp > 0)
		return stack[--sp];
	else
		return 0;
}

void push(int val)
{
	stack[sp++] = val;
}


