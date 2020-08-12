%option noyywrap
%option yylineno
%option noinput

%{
#include <stdlib.h>
#include <string.h>
#include "parser.h"

int line = 0;
int column = 0;

#define INC_RET(x,y) column += x; return (y)
#define INC_COL(x)	 column += x
#define INC_LINE	 line++;	  column = 0
%}

INTEGER		[0-9]+
FLOATER		[0-9]*\.[0-9]+
STRING 		\"[^\"]*\"
ID [a-zA-Z][a-zA-Z_0-9]*

%%

"+" 	{INC_RET(1,ADD);}
"-"		{INC_RET(1,SUB);}
"*"		{INC_RET(1,MUL);}
"/"		{INC_RET(1,DIV);}
"^"		{INC_RET(1,POW);}

";"		{INC_RET(1,SEMICOLON);}
"\""	{INC_RET(1,ASP);}
"(" 	{INC_RET(1,LPAR);}
")"		{INC_RET(1,RPAR);}
"["		{INC_RET(1,LBRACE);}
"]"		{INC_RET(1,RBRACE);}
"{"		{INC_RET(1,LCURLY);}
"}"		{INC_RET(1,RCURLY);}
"."		{INC_RET(1,DOT);}
","		{INC_RET(1,COLON);}
":"		{INC_RET(1,DPOINTS);}
"="		{INC_RET(1,ASSIGN);}

"=="	{INC_RET(2,EQUALS);}
"<"		{INC_RET(1,LESS);}
">"		{INC_RET(1,MORE);}
"<="	{INC_RET(2,LEQUALS);}
">=" 	{INC_RET(2,REQUALS);}
"!="	{INC_RET(2,DIFF);}

"mod"	{INC_RET(3,MOD);}
"and"	{INC_RET(3,AND);}
"or"	{INC_RET(2,OR);}
"not"	{INC_RET(3,NOT);}

"int" 		{INC_RET(3,INT);}
"float"		{INC_RET(4,FLOAT);}
"string" 	{INC_RET(5,STRING);}
"bool"		{INC_RET(4,BOOL);}
"void"		{INC_RET(4,VOID);}

"define"	{INC_RET(6,DEFINE);}
"if"		{INC_RET(2,IF);}
"then"		{INC_RET(4,THEN);}
"else"		{INC_RET(4,ELSE);}
"while"		{INC_RET(5,WHILE);}
"do"		{INC_RET(2,DO);}

"return"	{INC_RET(6,RETURN);}
"break"		{INC_RET(5,BREAK);}
"next"		{INC_RET(4,NEXT);}
"print"		{INC_RET(5,PRINT);}
"input"		{INC_RET(5,INPUT);}

INTEGER {yylval.integer = atoi(yytext); return INTEGER;}
FLOATER {yylval.floater = atof(yytext); return FLOATER;}
STRING 	{yylval.string = strdup(yytext); return STRNG;}
"true"	{yylval.boolean = 1; return BOOLEAN;}
"false"	{yylval.boolean = 0; return BOOLEAN;}
ID 		{yylval.id = strdup(yytext); return ID;}
[\t \n]+
#.*

%%
