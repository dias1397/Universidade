%{
	#include <stido.h>
	#include "ya.c"
	//#include "latex.h"

	int yylex (void);
	void yyerror (char const *);
%}


%union
{
	int f_int;
	float f_float;
	char *id;
	char *string;
	int boolean;
}

%token <f_int> LINT
%token <f_float> LFLOAT
%token <id> ID
%token <string> LSTRING
%token <boolean> LBOOL

%left ADD SUB
%left MUL DIV MOD
%right POW

%left AND OR NOT
%nonassoc EQ DIF LT GT LEQ GEQ

%token SEMI ASP DOT COMMA COLON ASSIGN
%token LPAR RPAR LRPAR RRPAR LCBRACE RCBRACE

%token INT FLOAT STRING BOOL VOID

%token IF THEN ELSE
%token WHILE DO

%token DEFINE RETURN BREAK NEXT
%token PRINT INPUT

%%

program: 	  /*empty*/
			| decls
			;

decls:		  decl 			{$$ = calc_decls_new_one($1); }
			| decl decls 	{$$ = calc_decls_new_multi($1,$2); }
			;

decl:		  ids COLON type SEMI {$$ = calc_decl_new_var($1,$3,null); }
			| ids COLON type ASSIGN exp SEMI {$$ = calc_decl_new_var($1, $3, $5); }
			| ID LPAR RPAR COLON type LCBRACE stms RCBRACE SEMI {$$ = calc_decl_new_func(null, $5, $7, $1); }
			| ID LPAR argdefs RPAR COLON type LCBRACE stms RCBRACE SEMI {$$ = calc_decl_new_func($3, $6, $8, $1); }
			| DEFINE ID type SEMI {$$ = calc_decl_new_define($3, $2); }
			;

ids:		  ID 					{$$ = calc_ids(null, $1); }
			| ID COMMA ids 			{$$ = calc_ids($3, $1); }
			;

type:		  INT 					{$$ = calc_type(0, null, null); }
			| FLOAT 				{$$ = calc_type(1, null, null); }
			| STRING 				{$$ = calc_type(2, null, null); }
			| BOOL 					{$$ = calc_type(3, null, null); }
			| VOID 					{$$ = calc_type(4, null, null); }
			| type RPAR LINT LRPAR 	{$$ = calc_type(5, $1, $3); }
			;

stms:		  stm 			{$$ = calc_stms_new_one($1); }
			| stm stms 		{$$ = calc_stms_new_multi($1,$2); }
			;

stm:		  decl 			{$$ = calc_stm_new_decl($1); }
			| ID exp SEMI 	{$$ = calc_stm_new_stm(1,$2,$1); }
			| ID ASSIGN exp SEMI {$$ = calc_stm_new_stm(2,$3,$1); }
			| RETURN exp SEMI {$$ = calc_stm_new_stm(3,$2,null); }
			| BREAK SEMI {$$ = calc_stm_new_stm(4,null,null); }
			| NEXT SEMI {$$ = calc_stm_new_stm(5,null,null); }
			| IF exp THEN LCBRACE stms RCBRACE SEMI {$$ = calc_stm_new_cycle(6, $2, $5, null); }
			| IF exp THEN LCBRACE stms RCBRACE ELSE LCBRACE stms RCBRACE SEMI {$$ = calc_stm_new_cycle(7, $2, $5, $9); }
			| WHILE exp DO LCBRACE stms RCBRACE SEMI {$$ = calc_stm_new_cycle(8, $2, $5, null); }
			| PRINT exp SEMI {$$ = calc_stm_new_stm(9,$2,null); }
			| INPUT exp SEMI {$$ = calc_stm_new_stm(10,$2,null); }
			;

exp: 		  ID 			{$$ = calc_exp_new_id($1); }
			| literal 		{$$ = calc_exp_new_literal($1); }
			| exp ADD exp	{$$ = calc_exp_new_binop("+",$1,$3); }
			| exp SUB exp 	{$$ = calc_exp_new_binop("-",$1,$3); }
			| exp MUL exp 	{$$ = calc_exp_new_binop("*",$1,$3); }
			| exp DIV exp 	{$$ = calc_exp_new_binop("/",$1,$3); }
			| exp MOD exp 	{$$ = calc_exp_new_binop("%",$1,$3); }
			| exp POW exp 	{$$ = calc_exp_new_binop("^",$1,$3); }

			| exp EQ exp 	{$$ = calc_exp_new_binop("==",$1,$3); }
			| exp DIF exp 	{$$ = calc_exp_new_binop("!=",$1,$3); }
			| exp LT exp 	{$$ = calc_exp_new_binop("<",$1,$3); }
			| exp GT exp 	{$$ = calc_exp_new_binop(">",$1,$3); }
			| exp LEQ exp 	{$$ = calc_exp_new_binop("<=",$1,$3); }
			| exp GEQ exp 	{$$ = calc_exp_new_binop(">=",$1,$3); }

			| exp AND exp 	{$$ = calc_exp_new_binop("&&",$1,$3); }
			| exp OR exp 	{$$ = calc_exp_new_binop("||",$1,$3); }
			| NOT exp 		{$$ = calc_exp_new_unop("no",$2); }
			| SUB exp 		{$$ = calc_exp_new_unop("-",$2); }

			| LPAR exp RPAR {$$ = calc_exp_new_par($2); }
			;

literal: 	  LINT 			{$$ = calc_literal(0, $1, null, null); }
			| LFLOAT 		{$$ = calc_literal(1, null, $1, null); }
			| LSTRING 		{$$ = calc_literal(2, null, null, $1); }
			| LBOOL 		{$$ = calc_literal(3, $1, null, null); }
			;

argdefs:	  argdef 				{$$ = calc_argdefs_new_one($1); }
			| argdef COMMA argdefs 	{$$ = calc_argdefs_new_multi($1,$3); }
			;

argdef: 	  ID COLON type 		{$$ = calc_argdef($3); }
			; 

%%

void yyerror (char const *s)
{
	fprintf (stderr, "%s\n", s);
}

int main (void)
{
	return yyparse();
}