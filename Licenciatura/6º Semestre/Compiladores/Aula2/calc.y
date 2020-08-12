%{
#include <stdio.h>
#include <string.h>
int yylex (void);
void yyerror (char const *);

void set_value(char *id, double value);
double get_value(char *id);

struct
{
	char *id;
	double value;
}map[256];

int size = 0;

%}

%union {
	double val;
	char *id;
}

/* Bison declarations */
%token <val>			NUM
%token <id>				ID 

%token 					NL /* newline */

%right					ASSIGN
%left					SUB ADD
%left					MUL DIV
%left					NEG		/* negation--unary minus */

%token					LPAR RPAR

%type  <val>			line exp
%%


input: 	/* empty */
		|		input line
;

line:			NL 		{ $$ = 0; }
		|		exp NL 	{ $$ = $1; printf ("%.2lf\n", $$); }
;

exp:			NUM					{ $$ = $1; }
		|		ID 					{ $$ = get_value($1); }
		| 		exp ADD exp			{ $$ = $1 + $3; }
		|		exp SUB exp			{ $$ = $1 - $3; }
		| 		exp MUL exp			{ $$ = $1 * $3; }
		|		exp DIV exp			{ $$ = $1 / $3; }
		|		SUB exp %prec NEG 	{ $$ = (0 - $2); }
		|		LPAR exp RPAR		{ $$ = $2; }
		|		ID ASSIGN exp		{ set_value($1, $3); $$ = $3; }
;
%%

/* Called by yyparse on error. */
void yyerror (char const *s)
{
	fprintf (stderr, "%s\n", s);
}

int main (void)
{
	return yyparse();
}

void set_value(char *id, double value)
{
	for (int i=0; i<size; i++)
	{
		if (strcmp(id, map[i].id) == 0)
		{
			map[i].value = value;
			return;
		}
	}
	
	map[size].id = id;
	map[size].value = value;
	size++;
}

double get_value(char *id)
{
	for (int i=0; i<size; i++)
	{
		if (strcmp(id, map[i].id) == 0)
		{
			return map[i].value;
		}
	}

	return 0;
}