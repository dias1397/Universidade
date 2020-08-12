%option noyywrap
%option yylineno
%option noinput

%{
	#include <stdlib.h>
	#include <string.h>
	#include <stdio.h>

	#include "latex.h"
	#include "yatypes.h"

	#include "parser.h"

	int line = 0;
	int column = 0;

	#define INC_RET(x, y) column += x; return(y)
	#define INC_COL(x) column += x
	#define INC_LINE() line++; column = 0
%}

LINT [0-9]+
ID [a-zA-Z][a-zA-Z0-9_]*
LSTRING \"[^\"]+\"
LFLOAT [0-9]*\.[0-9]+([eE]([\-\+])?[0-9]+)?
COMMENT #[ˆ#]*#

%%
"+"		{ INC_RET(1, ADD); }
"-"		{ INC_RET(1, SUB); }
"/"		{ INC_RET(1, DIV); }
"*"		{ INC_RET(1, MUL); }
"^"		{ INC_RET(1, POT); }

"("		{ INC_RET(1, LPAR); }
")" 	{ INC_RET(1, RPAR); }
"["		{ INC_RET(1, LRPAR); }
"]" 	{ INC_RET(1, RRPAR); }
"{"		{ INC_RET(1, LCBRACE); }
"}" 	{ INC_RET(1, RCBRACE); }
"\""    { INC_RET(1, ASP); }
";"     { INC_RET(1, SEMI); }
":"		{ INC_RET(1, DPOINT); }
"."		{ INC_RET(1, DOT); }
","		{ INC_RET(1, COMMA); }

"=="    { INC_RET(2, EQU); }
"!="    { INC_RET(2, DIF); }

"="     { INC_RET(1, ASSIGN); }
"<="    { INC_RET(2, LEQU); }
">="    { INC_RET(2, BEQU); }
"<"		{ INC_RET(1, LESS); }
">"		{ INC_RET(1, BIGG); }

"mod"   { INC_RET(3, MOD); }
"and"   { INC_RET(3, AND); }
"or"    { INC_RET(2, OR); }
"not"   { INC_RET(3, NOT); }

"int"  	    { INC_RET(3, INT); }
"float"     { INC_RET(5, FLOAT); }
"string"    { INC_RET(6, STRING); }
"bool"      { INC_RET(4, BOOL); }
"void"      { INC_RET(4, VOID); }

"define"    { INC_RET(6, DEFINE); }

"if"        { INC_RET(2, IF); }
"then"      { INC_RET(4, THEN); }
"else"      { INC_RET(4, ELSE); }

"while"     { INC_RET(5, WHILE); }
"do"        { INC_RET(2, DO); }

"return"    { INC_RET(6, RETURN); }
"break"     { INC_RET(5, BREAK); }
"next"      { INC_RET(4, NEXT); }

"print"     { INC_RET(5, PRINT); }
"input"     { INC_RET(5, INPUT); }

{LINT}	     { yylval.ival = atof(yytext); INC_RET(strlen(yytext), LINT); }
{LFLOAT}     { yylval.fval = atof(yytext); INC_RET(strlen(yytext), LFLOAT); }
{LSTRING}    { yylval.sval = strdup(yytext); INC_RET(strlen(yytext), LSTRING); }
"true"	     { yylval.bval = 1; INC_RET(4, LBOOL); }
"false"      { yylval.bval = 0; INC_RET(5, LBOOL); }

{ID}        { yylval.id = strdup(yytext); INC_RET(strlen(yytext),ID); }

[ \t]+      { INC_COL(strlen(yytext)); }
\n 		    { INC_LINE(); }

{COMMENT}   { INC_COL(strlen(yytext)); }   /*Ignorar comentarios # ... # */
%%