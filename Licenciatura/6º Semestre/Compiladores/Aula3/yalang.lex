%option noyywrap
%option yylineno

%{
#include <stdlib.h>
#include <string.h>
#include "parser.h"

int line = 0;
int column = 0;

#define INC_RET(x, y) 	column += x; return (y)
#define INC_COL(x)		column += x
#define INC_LINE		line++;		 column = 0

%}

INT 	[0-9]+
FLOAT	[0-9]*\.[0-9]+
ID 		[a-zA-Z][a-zA-Z0-9_]*
STRING 	\"[^\"]*\"
WHITESP [\t ]+


%%
{INT}	{ yylval.val = atof(yytext); return INTLIT; }
{FLOAT} { yylval.val = atof(yytext); return FLOATLIT; }

"+"		{ INC_RET(1, ADD);}	
"-"		{ INC_RET(1, SUB); }		
"*"		{ INC_RET(1, MUL); }	
"/"		{ INC_RET(1, DIV); }
"^" 	{ INC_RET(1, POW);}		

"mod" 	{ INC_RET(3, MOD);}
"and" 	{ INC_RET(3, AND);}
"or" 	{ INC_RET(2, OR);}
"not" 	{ INC_RET(3, NOT);}

"==" 	{ INC_RET(2, EQ);}
"!=" 	{ INC_RET(2, NEQ);}
"<" 	{ INC_RET(1, LT);}
">" 	{ INC_RET(1, GT);}
"<=" 	{ INC_RET(2, LEQ);}
">=" 	{ INC_RET(2, GEQ);}

";" 	{ INC_RET(1, SEMI);}
"\"" 	{ INC_RET(1, ASP);}
"("		{ INC_RET(1, LPAR);}
")"		{ INC_RET(1, RPAR);}
"["		{ INC_RET(1, LSBRACE);}
"]" 	{ INC_RET(1, RSBRACE);}
"{" 	{ INC_RET(1, LCBRACE);}
"}" 	{ INC_RET(1, RCBRACE);}
"," 	{ INC_RET(1, COMMA);}
":" 	{ INC_RET(1, COLON);}
"=" 	{ INC_RET(1, ASSIGN);}

{INTLIT}	{ yylval.f_int = atof(yytext); return INTLIT;}
{FLOATLIT}	{ yylval.f_float = atof(yytext); return FLOATLIT;}
{STRLIT}	{ yylval.string = strdup(yytext); return STRLIT;}
"true" 	{ yylval.val = 1; INC_RET(4, BOOLLIT);}
"false" { yylval.val = 0; INC_RET(5, BOOLLIT);}



"define" { INC_RET(6, DEFINE);}
"if" 	{ INC_RET(2, IF);}
"then" 	{ INC_RET(4, THEN);}
"else" 	{ INC_RET(4, ELSE);}
"while" { INC_RET(5, WHILE);}
"do" 	{ INC_RET(2, DO);}

"return" { }
"break" { }
"next" 	{ }

