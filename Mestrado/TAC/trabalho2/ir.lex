%{
	#include "ir.tab.h"
%}

/* avoid `input' and `yyunput' not used warnings */
%option noinput
%option nounput

%%

"var"		printf("var");return VAR;
"fun" 		printf("fun");return FUN;

"id" 		printf("id");return ID;
"@"			printf("@");return AT;

"void"		printf("void");return VOID;
"int"		printf("int");return INT;
"bool"		printf("bool");return BOOL;

"("			printf("(");return OPPAR;
")"			printf(")");return CLPAR;
"["			printf("[");return OPRPAR;
"]"			printf("]");return CLRPAR;
":"			printf(":");return COLON;
","			printf(",");return COMMA;

"<-"		printf("<-");return ARROW;

"function"	printf("function");return IR_FUN;

"i_add"		printf("i_add");return I_ADD;
"i_sub"		printf("i_sub");return I_SUB;
"i_mul"		printf("i_mul");return I_MUL;
"i_div"		printf("i_div");return I_DIV;
"i_inv"		printf("i_inv");return I_INV;
"mod"		printf("mod");return MOD;

"i_eq"		printf("i_eq");return I_EQ;
"i_lt"		printf("i_lt");return I_LT;
"i_ne"		printf("i_ne");return I_NE;
"i_le"		printf("i_le");return I_LE;

"itor"		printf("itor");return ITOR;
"not"		printf("not");return NOT;
"i_copy"	printf("i_copy");return I_COPY;

"i_value"	printf("i_value");return I_VALUE;

"i_gload"	printf("i_gload");return I_GLOAD;
"i_lload"	printf("i_lload");return I_LLOAD;
"i_aload"	printf("i_aload");return I_ALOAD;

"i_gstore"	printf("i_gstore");return I_GSTORE;
"i_lstore"	printf("i_lstore");return I_LSTORE;
"i_astore"	printf("i_astore");return I_ASTORE;

"jump"		printf("jump");return JUMP;
"cjump"		printf("cjump");return CJUMP;

"i_call"	printf("i_call");return I_CALL;
"call"		printf("call");return CALL;

"i_return"	printf("i_return");return I_RETURN;
"return"	printf("return");return RETURN;

"i_print"	printf("i_print");return I_PRINT;
"b_print" 	printf("b_print");return B_PRINT;

(t|fp)[0-9]+ {
	yylval.temporarie = strdup(yytext);
	printf("temporarie");
	return TEMPORARIE;
}

l[0-9]+ {
	yylval.label = strdup(yytext);
	printf("label");
	return LABEL;
}

"true" {
	yylval.integer = 1;
	printf("%d", 1);
	return BOOL_LITERAL;
}

"false" {
	yylval.integer = 0;
	printf("%d", 0);
	return BOOL_LITERAL;
}

[0-9]+		{
	yylval.integer = atoi(yytext);
	printf("%d", yylval.integer);
	return INT_LITERAL;
}

[_a-zA-Z][_a-zA-Z0-9]*	{
	yylval.string = strdup(yytext);
	printf("%s", yylval.string);
	return IDENTIFIER;
}

#.*			; /* ignore comments */

[\n]+ 		printf("\n");

[\t]+	 	printf("\t");

[ ]+	 	printf(" ");

.		{
	fprintf(stderr, "unrecognised character: `%c'\n", *yytext);
	return ERROR;
}
