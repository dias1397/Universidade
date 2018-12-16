%{
	#include "ir.tab.h"
%}

/* avoid `input' and `yyunput' not used warnings */
%option noinput
%option nounput

%%

"var"		return VAR;
"fun" 		return FUN;

"id" 		return ID;
"@"			return AT;

"("			return OPPAR;
")"			return CLPAR;
"["			return OPRPAR;
"]"			return CLRPAR;

"void"		return VOID;
"int"		return INT;

"function"	return IRFUN;

""

\"[_a-zA-Z][_a-zA-Z0-9]*\"	{
	yylval.string = strdup(yytext);
	return IDENTIFIER;
}