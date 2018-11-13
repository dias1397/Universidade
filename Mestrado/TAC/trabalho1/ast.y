%{
	#include <string.h>
	#include <stdio.h>
	#include "tacl_ir.h"

	int yylex(void);
	void yyerror(const char *); // see below	
%}

%token VAR FUN
%token BODY ARG LOCAL

%token ASSIGN
%token CALL PRINT
%token IF WHILE

%token OPPAR CLPAR OPRPAR CLRPAR COLON

%token ID
%token INT_LITERAL REAL_LITERAL
%token INT REAL BOOL
%token TOREAL
%token NIL

%token <integer> INT_LITERAL_VALUE
%token <real> REAL_LITERAL_VALUE
%token <integer> BOOL_LITERAL
%token <string> IDENTIFIER

%left OR AND
%left EQ NE LT LE GT GE
%left PLUS MINUS
%left TIMES DIV MOD

%nonassoc NOT INV

%token ERROR

%%

program : 
		global_declarations
	;

global_declarations : 
		global_declaration global_declarations
	|	global_declaration
	;

global_declaration :
		variable_declaration
	|	function_declaration
	;

variable_declaration :
		OPPAR VAR OPPAR id_ CLPAR expression CLPAR
	;

function_declaration :
		OPPAR FUN IDENTIFIER OPRPAR formal_args CLRPAR body CLPAR
	; 

