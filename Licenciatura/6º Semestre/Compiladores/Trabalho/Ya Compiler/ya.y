%{
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int yylex (void);
void yyerror (char const *);
%}

%union
{
	char *id;
	int ival;
	float fval;
	int bval;
	char *sval;
}
%token <id> ID
%token <ival> LINT
%token <fval> LFLOAT
%token <sval> LSTRING
%token <bval> LBOOL

%token INT FLOAT STRING BOOL VOID

%left AND OR NOT
%nonassoc EQU DIF LEQU BEQU LESS BIGG

%left ADD SUB
%left MUL DIV MOD
%right POT

%token LPAR RPAR LRPAR RRPAR LCBRACE RCBRACE
%token ASP SEMI DOT

%token DPOINT COMMA ASSIGN

%token DEFINE
%token IF THEN ELSE WHILE DO RETURN
%token BREAK NEXT
%token PRINT INPUT

%%
program:    decls
            ;

decls:		decl {$$ = T_decl_declaration($1, null);}
      	|   decl decls {$$ = T_decl_declaration($1, $2);}
            ;

decl:       ids DPOINT type SEMI {$$ = T_decls_variable($1,$3,null);}
      	|   ids DPOINT type ASSIGN exp SEMI {$$ = T_decls_variable($1,$3,$5);}
      	|   ID LPAR RPAR DPOINT type LCBRACE stmts RCBRACE SEMI {$$ = T_decls_func_def(null,$5,$7, $1);}
      	|   ID LPAR argdefs RPAR DPOINT type LCBRACE stmts RCBRACE SEMI {$$ = T_decls_func_def($3,$5,$7,$1);}
   		|   DEFINE ID type SEMI {$$ = T_decls_func_def(null,$3,null,$2);}
            ;

ids:		ID {$$ = T_ids($1, null);}
		| 	ID COMMA ids {$$ = T_ids($1, $3);}
			;

type:		INT {$$ = T_type(0, null, null);}
		|	FLOAT {$$ = T_type(1, null, null);}
		|	STRING {$$ = T_type(2, null, null);}
		|	BOOL {$$ = T_type(3, null, null);}
		|	VOID {$$ = T_type(4, null, null);}
		| 	type RRPAR LINT LRPAR {$$ = T_type(5, $1, $3);}
			;

argdefs:	argdef {$$ = T_argdefs($1, null);}
		|	argdef COMMA argdefs {$$ = T_argdefs($1, $3);}
			;

argdef:		ID DPOINT type {$$ = T_argdef($3, $1);}
			;

literais:	LINT 	{$$ = T_literais($1	 , null , null);}
		|	LFLOAT 	{$$ = T_literais(null, $1	, null);}
		|	LSTRING {$$ = T_literais(null, null , $1  );}
		|	LBOOL 	{$$ = T_literais($1  , null , null);}
			;

stmts:		stmt 	{$$ = T_stmts($1, null);}
		| 	stmt stmts {$$ = T_stmts($1, $2);}
			;

stmt:		decl
		|	ID exp SEMI
		| 	ID ASSIGN exp SEMI
		|	IF exp THEN LCBRACE stmts RCBRACE SEMI
		|	IF exp THEN LCBRACE stmts RCBRACE ELSE LCBRACE stmts RCBRACE SEMI

		|	WHILE exp DO LCBRACE stmts RCBRACE SEMI

		|	RETURN exp	SEMI
		|	BREAK SEMI
		| 	NEXT SEMI

		| 	PRINT exp SEMI

		| 	INPUT exp SEMI
			;


exp:		ID
	//	| 	ID exp
		| 	literais

		|	exp ADD exp
		| 	exp SUB exp
		| 	exp MUL exp
		|	exp DIV exp

		|	MOD exp
		|	exp POT exp

		| 	exp EQU exp
		| 	exp DIF exp

		|	exp LESS exp
		|	exp BIGG exp
		|	exp LEQU exp
		|	exp BEQU exp

		|	exp AND exp
		|	exp	OR	exp

		|	NOT exp
		| 	SUB exp

		| 	LPAR exp RPAR
		| 	ID LPAR exp RPAR
	//	|	exp DPOINT exp
			;
%%
/* Caller by yyparse on error */
void yyerror(const char *msg)
{
	extern int yylineno;
	extern int line;
	extern int column;
	fprintf(stderr, "Error: %s\n", msg);
	fprintf(stderr, "ERRO NA LINHA: %d   \n\tCOLUNA:%d\n", yylineno,column);
}

int main (void)
{
	return yyparse();
}
