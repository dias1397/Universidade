%{
#include "tacl.tab.h"
%}

/* avoid `input' and `yyunput' not used warnings */
%option noinput
%option nounput

%%

fun			return FUN;
var			return VAR;
proc		return PROC;

print		return PRINT;

if 			return IF;
else		return ELSE;
while		return WHILE;

int			return INT;
real		return REAL;
bool		return BOOL;

id			return ID;

int_literal return INT_LITERAL;
real_literal return REAL_LITERAL;

"="		return EQSIGN;
","		return COMMA;
";"		return SEMICOLON;
"("		return OPPAR;
")"		return CLPAR;
"["		return LRPAR;
"]"		return RRPAR;
"*"		return POT;
"||"	return OR;

[_a-zA-Z][_a-zA-Z0-9]*	
{
	yylval.string = strdup(yytext);

	return ID;
}

[0-9]+		
{
	yylval.integer = atoi(yytext);

	return INT_LITERAL;
}

[0-9]+\.[0-9]+ 
{
	yylval.real = atof(yytext);

	return REAL_LITERAL;  
}

#.*			; /* ignore comments */

[ \t\n]+	; /* and whitespace */

.		
{
	fprintf(stderr, "unrecognised character: `%c'\n", *yytext);

	return ERROR;
}
