%{
	#include <stdlib.h>
	#include <string.h>
	#include <stdio.h>

	#include "yatypes.h"
	#include "latex.h"

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

	t_decl      decl;
	t_decls     decls;
	t_ids       ids;
	t_type      type;
	t_argdefs   argdefs;
	t_argdef    argdef;
	t_literais  literais;
	t_stmts     stmts;
	t_stmt      stmt;
	t_exp       exp;
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

%type <decl>		decl
%type <decls>		decls
%type <ids>			ids
%type <type>		type
%type <argdefs>		argdefs
%type <argdef>		argdef
%type <literais>	literais
%type <stmts>		stmts
%type <stmt>		stmt
%type <exp>			exp

%%
program:    decls {	print_prologue();
            				print_decls($1);
                  	print_epilogue();}
            ;

decls:		decl {$$ = T_decls_declaration($1, NULL);}
      |     decl decls {$$ = T_decls_declaration($1, $2);}
            ;

decl:       ids DPOINT type SEMI {$$ = T_decl_variable($1,$3,NULL);}
      |     ids DPOINT type ASSIGN exp SEMI {$$ = T_decl_variable($1,$3,$5);}
      |     ID LPAR RPAR DPOINT type LCBRACE stmts RCBRACE SEMI {$$ = T_decl_func_def($1,NULL,$5,$7);}
      |     ID LPAR argdefs RPAR DPOINT type LCBRACE stmts RCBRACE SEMI {$$ = T_decl_func_def($1,$3,$6,$8);}
      |     DEFINE ID type SEMI {$$ = T_decl_func_def($2,NULL,$3,NULL);}
            ;

ids:		ID {$$ = T_ids_id(NULL, $1);}
		| 	ID COMMA ids {$$ = T_ids_id($3, $1);}
			;

type:		INT {$$ = T_type_def(NULL,0,-1);}
		|	FLOAT {$$ = T_type_def(NULL,1,-1);}
		|	STRING {$$ = T_type_def(NULL,2,-1);}
		|	BOOL {$$ = T_type_def(NULL,3,-1);}
		|	VOID {$$ = T_type_def(NULL,4,-1);}
		| 	type RRPAR LINT LRPAR {$$ = T_type_def($1,-1,$3);}
			;

argdefs:	argdef {$$ = T_argdefs_def($1, NULL);}
		|	argdef COMMA argdefs {$$ = T_argdefs_def($1,$3);}
			;

argdef:		ID DPOINT type {$$ = T_argdef_def($3, $1);}
			;

literais:	LINT {$$ = T_literais_int_bool(0,$1);}
		|	LFLOAT {$$ = T_literais_float($1);}
		|	LSTRING {$$ = T_literais_string($1);}
		|	LBOOL {$$ = T_literais_int_bool(3,$1);}
			;

stmts:		stmt {$$ = T_stmts_def($1, NULL);}
		| 	stmt stmts {$$ = T_stmts_def($1,$2);}
			;

stmt:		decl {$$ = T_stmt_decl($1);}
		|	ID exp SEMI {$$ = T_stmt_id($1, $2, 1);}
		| 	ID ASSIGN exp SEMI {$$ = T_stmt_id($1, $3, 2);}
		|	IF exp THEN LCBRACE stmts RCBRACE SEMI {$$ = T_stmt_all($2,$5,NULL,3);}
		|	IF exp THEN LCBRACE stmts RCBRACE ELSE LCBRACE stmts RCBRACE SEMI {$$ = T_stmt_all($2,$5,$9,4);}

		|	WHILE exp DO LCBRACE stmts RCBRACE SEMI {$$ = T_stmt_all($2,$5,NULL,5);}

		|	RETURN exp	SEMI {$$ = T_stmt_all($2,NULL,NULL,6);}
		|	BREAK SEMI {$$ = T_stmt_empty(7);}
		| 	NEXT SEMI {$$ = T_stmt_empty(8);}

		| 	PRINT exp SEMI {$$ = T_stmt_all($2,NULL,NULL,9);}

		| 	INPUT exp SEMI {$$ = T_stmt_all($2,NULL,NULL,10);}
			;


exp:		ID {$$ = T_exp_one_id($1);}
	//	| 	ID exp
		| 	literais {$$ = T_exp_one_literais($1);}

		|	exp ADD exp {$$ = T_exp_exp($1,$3,2);}
		| 	exp SUB exp {$$ = T_exp_exp($1,$3,3);}
		| 	exp MUL exp {$$ = T_exp_exp($1,$3,4);}
		|	exp DIV exp {$$ = T_exp_exp($1,$3,5);}

		|	MOD exp {$$ = T_exp_exp(0,$2,6);}
		|	exp POT exp {$$ = T_exp_exp($1,$3,7);}

		| 	exp EQU exp {$$ = T_exp_exp($1,$3,8);}
		| 	exp DIF exp {$$ = T_exp_exp($1,$3,9);}

		|	exp LESS exp {$$ = T_exp_exp($1,$3,10);}
		|	exp BIGG exp {$$ = T_exp_exp($1,$3,11);}
		|	exp LEQU exp {$$ = T_exp_exp($1,$3,12);}
		|	exp BEQU exp {$$ = T_exp_exp($1,$3,13);}

		|	exp AND exp {$$ = T_exp_exp($1,$3,14);}
		|	exp	OR	exp {$$ = T_exp_exp($1,$3,15);}

		|	NOT exp {$$ = T_exp_exp(0,$2,16);}
		| 	SUB exp {$$ = T_exp_exp(0,$2,17);}

		| 	LPAR exp RPAR {$$ = T_exp_exp(0,$2,18);}
		| 	ID LPAR exp RPAR {$$ = T_exp_id($1,$3);}
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