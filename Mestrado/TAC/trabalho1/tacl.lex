%{
#include "tacl.tab.h"
%}

/* avoid `input' and `yyunput' not used warnings */
%option noinput
%option nounput

%%

"var" 		return VAR;
"fun" 		return FUN;

"arg"		return ARG;
"body"		return BODY;
"local"		return LOCAL;
"id"		return ID;

"assign"	return ASSIGN;
"call"		return CALL;
"print"		return PRINT;

"if"		return IF;
"while"		return WHILE;

"or"		return OR;
"and"		return AND;
"eq"		return EQ;
"ne"		return NE;
"lt"		return LT;
"le"		return LE;
"gt"		return GT;
"ge"		return GE;

"plus"		return PLUS;
"minus"		return MINUS;
"times"		return TIMES;
"div"		return DIV;
"mod"		return MOD;
"not"		return NOT;
"inv"		return INV;

"int"		return INT;
"real"		return REAL;
"bool"		return BOOL;

"int_literal"	return INT_LITERAL;
"real_literal"	return REAL_LITERAL;

"toreal"	return TOREAL;

"nil"		return NIL;

"("			return OPPAR;
")"			return CLPAR;
"["			return OPRPAR;
"]"			return CLRPAR;
":"			return COLON;

\"[_a-zA-Z][_a-zA-Z0-9]*\"	{
	yylval.string = strdup(yytext);
	return IDENTIFIER;
}

[0-9]+		{
	yylval.integer = atoi(yytext);
	return INT_LITERAL_VALUE;
}

[0-9]+\.[0-9]+ {
	yylval.real = atof(yytext);
	return REAL_LITERAL_VALUE;  
}

"true" {
	yylval.integer = 1;
	return BOOL_LITERAL;
}

"false" {
	yylval.integer = 0;
	return BOOL_LITERAL;
}

#.*			; /* ignore comments */

[ \t\n]+	; /* and whitespace */

.		{
	fprintf(stderr, "unrecognised character: `%c'\n", *yytext);
	return ERROR;
}
