%{
#include <stdio.h>
#include <string.h>

int yylex(void);
void yyerror(const char *);

%}

%union {

	int integer;
	float floater;
	char *string;
	char *id;
	int boolean;
}

%token <integer> 	INTEGER
%token <floater> 	FLOATER
%token <string> 	STRING
%token <id>			ID
%token <boolean>	BOOLEAN

%token INT FLOAT STRING BOOL

%left AND OR NOT
%nonassoc EQUALS LESS MORE LEQUALS REQUALS DIFF


%left ADD SUB
%left MUL DIV MOD
%right POW

%token SEMICOLON ASP LPAR RPAR LBRACE RBRACE LCURLY RCURLY DOT
%token COLON DPOINTS ASSIGN

%token VOID

%token DEFINE IF THEN ELSE WHILE DO

%token RETURN BREAK NEXT PRINT INPUT

%%

program:		decls
				;

decls:			decl
		|		decl delcs
				;

decl: 			ids DPOINTS type SEMICOLON
		|		ids DPOINTS type ASSIGN exp SEMICOLON
		|		ID LPAR ROAR DPOINTS type LCBRACE stms RCBRACE SEMICOLON
		|		ID LPAR argdefs RPAR DPOINTS type LCBRACE stms RCBRACE SEMICOLON
		| 		DEFINE ID type SEMICOLON
				;

type: 			INT
		|		FLOAT
		|		STRING
		|		BOOL
		|		type LBRACE exp RBRACE
		|		VOID
				;

ids:			ID
		|		ID COLON ids
				;

stms:			stm
		| 		stm stms
				;

stm:			decls
		|		ID exp SEMICOLON
		|		IF exp THEN LCURLY stms RCURLY SEMICOLON
		|		IF exp THEN LCURLY stms RCURLY ELSE LCURLY stms RCURLY SEMICOLON
		|		WHILE exp DO LCURLY stms RCURLY SEMICOLON
		|		RETURN exp SEMICOLON
		|		NEXT SEMICOLON
		| 		BREAK SEMICOLON
		|		PRINT LPAR ids RPAR SEMICOLON
		| 		PRINT LPAR STRING RPAR SEMICOLON
		| 		PRINT LPAR ID  exp RPAR SEMICOLON
		| 		INPUT LPAR ID RPAR SEMICOLON
				;

argdefs: 		argdef
		|		argdef COLON argdefs
				;

argdef:			ID DPOINTS type
				;

exp:		ID

		|	INTEGER
		|	FLOATER
		|	STRING
		|	BOOLEAN

		|	exp ADD exp
		|	exp SUB exp
		|	exp MUL exp
		|	exp DIV exp
		|	exp POW exp
		|	MOD exp

		|	exp AND exp
		|	exp OR exp

		| 	exp EQUALS exp
		|	exp DIFF exp

		|	exp LESS exp
		|	exp MORE exp
		|	exp LEQUALS exp
		|	exp REQUALS exp

		|	NOT exp
		| 	SUB exp

		|	LPAR exp RPAR
		|   exp DPOINTS exp
		| 	ID ASSIGN exp

			;

%%

void yyerror(const char *msg)
{
	extern int yylineno;
	fprintf(stderr, "Error: %s\n", msg);
	fprintf(stderr, "ERRO NA LINHA: %d\n", yylineno);
}

int main(void)
{
	return yyparse();
}
