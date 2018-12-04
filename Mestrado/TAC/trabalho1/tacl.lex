%{
#include "tacl.tab.h"
%}

/* avoid `input' and `yyunput' not used warnings */
%option noinput
%option nounput

%%

"var" 		printf("var ");return VAR;
"fun" 		printf("fun ");return FUN;

"arg"		printf("arg ");return ARG;
"body"		printf("body ");return BODY;
"local"		printf("local ");return LOCAL;
"id"		printf("id ");return ID;

"assign"	printf("assign ");return ASSIGN;
"call"		printf("call ");return CALL;
"print"		printf("print ");return PRINT;

"if"		printf("if ");return IF;
"while"		printf("while ");return WHILE;

"or"		printf("or ");return OR;
"and"		printf("and ");return AND;
"eq"		printf("eq ");return EQ;
"ne"		printf("ne ");return NE;
"lt"		printf("lt ");return LT;
"le"		printf("le ");return LE;
"gt"		printf("gt ");return GT;
"ge"		printf("ge ");return GE;

"plus"		printf("+ ");return PLUS;
"minus"		printf("- ");return MINUS;
"times"		printf("* ");return TIMES;
"div"		printf("/ ");return DIV;
"mod"		printf("mod ");return MOD;
"not"		printf("! ");return NOT;
"inv"		printf("inv ");return INV;

"int"		printf("int ");return INT;
"real"		printf("real ");return REAL;
"bool"		printf("bool ");return BOOL;

"int_literal"	printf("int_literal ");return INT_LITERAL;
"real_literal"	printf("real_literal ");return REAL_LITERAL;

"toreal"	printf("toreal ");return TOREAL;

"nil"		printf("nil ");return NIL;

"("			printf("( ");return OPPAR;
")"			printf(") ");return CLPAR;
"["			printf("[ ");return OPRPAR;
"]"			printf("] ");return CLRPAR;
":"			printf(": ");return COLON;

\"[_a-zA-Z][_a-zA-Z0-9]*\"	{
	yylval.string = strdup(yytext);
	printf("%s ", yylval.string);
	return IDENTIFIER;
}

[0-9]+		{
	yylval.integer = atoi(yytext);
	printf("%d ", yylval.integer);
	return INT_LITERAL_VALUE;
}

[0-9]+\.[0-9]+ {
	yylval.real = atof(yytext);
	printf("%f ", yylval.real);
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
