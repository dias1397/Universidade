%{
#include "tacl.tab.h"
%}

/* avoid `input' and `yyunput' not used warnings */
%option noinput
%option nounput

%%

","		printf(", ");return COMMA;
";"		printf(";\n");return SEMICOLON;

"("		printf("( ");return OPPAR;
")"		printf(") ");return CLPAR;
"["		printf("[ ");return LRPAR;
"]"		printf("] ");return RRPAR;

fun			printf("fun ");return FUN;
var			printf("var ");return VAR;
proc		printf("proc ");return PROC;

print		printf("print ");return PRINT;

if 			printf("if ");return IF;
else		printf("else ");return ELSE;
while		printf("while ");return WHILE;

int			printf("int ");return INT;
real		printf("real ");return REAL;
bool		printf("bool ");return BOOL;

id			printf("idmal ");return ID;

int_literal printf("int_lit ");return INT_LITERAL;
real_literal printf("real_lit ");return REAL_LITERAL;

"="		printf("= ");return EQSIGN;
"^"			printf("^ ");return POT;
"||"			printf("|| ");return OR;
"&&"			printf("&& ");return AND;
"=="			printf("== ");return EQ;
"!="			printf("!= ");return NE;
"<"			printf("< ");return LT;
"<="			printf("<= ");return LE;
">"			printf("> ");return GT;
">="			printf(">= ");return GE;

"+"		printf("+ ");return PLUS;
"-"		printf("- ");return MINUS;
"*"		printf("* ");return TIMES;
"/"			printf("/ ");return DIV;
"%"			printf("mod ");return MOD;
"!"			printf("! ");return NOT;

[_a-zA-Z][_a-zA-Z0-9]*	{
	yylval.string = strdup(yytext);
	printf("%s", yylval.string);
	return ID;
}

[0-9]+		{
	yylval.integer = atoi(yytext);
	printf("%d", yylval.integer);
	return INT_LITERAL;
}

[0-9]+\.[0-9]+ {
	yylval.real = atof(yytext);
	printf("%f", yylval.real);
	return REAL_LITERAL;  
}

#.*			; /* ignore comments */

[ \t\n]+	; /* and whitespace */

.		{
	fprintf(stderr, "unrecognised character: `%c'\n", *yytext);
printf(" ");
	return ERROR;
}
