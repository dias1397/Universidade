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

"void"		return VOID;
"int"		return INT;
"bool"		return BOOL;

"("			return OPPAR;
")"			return CLPAR;
"["			return OPRPAR;
"]"			return CLRPAR;
":"			return COLON;
","			return COMMA;

"<-"		return ARROW;

"function"	return IR_FUN;

"i_add"		return I_ADD;
"i_sub"		return I_SUB;
"i_mul"		return I_MUL;
"i_div"		return I_DIV;
"i_inv"		return I_INV;
"mod"		return MOD;

"i_eq"		return I_EQ;
"i_lt"		return I_LT;
"i_ne"		return I_NE;
"i_le"		return I_LE;

"itor"		return ITOR;
"not"		return NOT;
"i_copy"	return I_COPY;

"i_value"	return I_VALUE;

"i_gload"	return I_GLOAD;
"i_lload"	return I_LLOAD;
"i_aload"	return I_ALOAD;

"i_gstore"	return I_GSTORE;
"i_lstore"	return I_LSTORE;
"i_astore"	return I_ASTORE;

"jump"		return JUMP;
"cjump"		return CJUMP;

"i_call"	return I_CALL;
"call"		return CALL;

"i_return"	return I_RETURN;
"return"	return RETURN;

"i_print"	return I_PRINT;
"b_print" 	return B_PRINT;

(t|fp)[0-9]+ {
	yylval.temporarie = strdup(yytext);
	return TEMPORARIE;
}

l[0-9]+ {
	yylval.label = strdup(yytext);
	return LABEL;
}

"true" {
	yylval.integer = 1;
	return BOOL_LITERAL;
}

"false" {
	yylval.integer = 0;
	return BOOL_LITERAL;
}

[0-9]+		{
	yylval.integer = atoi(yytext);
	return INT_LITERAL;
}

\"[_a-zA-Z][_a-zA-Z0-9]*\"	{
	yylval.string = strdup(yytext);
	return IDENTIFIER;
}

#.*			; /* ignore comments */

[ \t\n]+	; /* and whitespace */

.		{
	fprintf(stderr, "unrecognised character: `%c'\n", *yytext);
	return ERROR;
}
