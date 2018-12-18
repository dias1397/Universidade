%{
	#include <stdio.h>

	int yylex(void);
	void yyerror(const char *);	// see below
%}

%error-verbose

%union 
{
	char 	*temporarie;
	char 	*label;
	char 	*string;
	int 	integer;
}

%token VAR FUN

%token ID AT
%token VOID INT BOOL

%token OPPAR CLPAR OPRPAR CLRPAR
%token COMMA COLON ARROW

%token IR_FUN

%token I_COPY
%token I_VALUE
%token I_GLOAD I_LLOAD I_ALOAD
%token I_GSTORE I_LSTORE I_ASTORE

%token JUMP CJUMP

%token I_CALL CALL
%token I_RETURN RETURN
%token I_PRINT B_PRINT

%token TEMPORARIE
%token LABEL
%token BOOL_LITERAL
%token INT_LITERAL
%token IDENTIFIER

%token ERROR

%left I_ADD I_SUB
%left I_MUL I_DIV MOD
%left I_EQ I_LT I_NE I_LE

%nonassoc NOT I_INV ITOR

%%

program: 
		preamble functions
	;

preamble: 	
		global_symbol preamble
	| 	global_symbol
	;

global_symbol: 	
		variable_declaration
	| 	function_declaration
	;

variable_declaration:
		OPPAR ID AT IDENTIFIER VAR type CLPAR
	| 	OPPAR ID AT IDENTIFIER VAR type literal CLPAR
	;

function_declaration:
		OPPAR ID AT IDENTIFIER FUN type OPRPAR formal_args CLRPAR OPRPAR local_vars CLRPAR CLPAR
	;

formal_args:
		formal_arg formal_args
	|	/*empty*/
	;	

formal_arg:
		OPPAR type AT IDENTIFIER CLPAR
	;

local_vars:
		local_var local_vars
	|	/*empty*/
	;

local_var:
		OPPAR type AT IDENTIFIER CLPAR
	;

type:
		INT
	|	BOOL
	| 	VOID
	;

literal:
		INT_LITERAL
	| 	BOOL_LITERAL
	;

functions:
		ir_function functions
	|	ir_function
	;

ir_function:
		IR_FUN AT IDENTIFIER instructions
	;

instructions:
		instruction instructions
	| 	instruction
	;

instruction:
		TEMPORARIE ARROW operation TEMPORARIE COMMA TEMPORARIE
	|	TEMPORARIE ARROW operation TEMPORARIE

	|	TEMPORARIE ARROW I_VALUE literal
	|	TEMPORARIE ARROW load AT IDENTIFIER
	|	AT IDENTIFIER ARROW store TEMPORARIE

	|	JUMP LABEL
	|	CJUMP TEMPORARIE COMMA LABEL COMMA LABEL

	|	TEMPORARIE ARROW I_CALL AT IDENTIFIER COMMA OPRPAR args CLRPAR
	|	CALL AT IDENTIFIER COMMA OPRPAR args CLRPAR

	|	I_RETURN TEMPORARIE
	|	RETURN TEMPORARIE

	|	I_PRINT TEMPORARIE
	|	B_PRINT TEMPORARIE

	| 	LABEL COLON instruction
	;

operation:
		I_ADD
	|	I_SUB
	|	I_MUL
	|	I_DIV
	|	I_INV
	|	MOD
	|	I_EQ
	|	I_LT
	|	I_NE
	|	I_LE
	|	ITOR
	|	NOT
	|	I_COPY
	;

load:
		I_GLOAD
	|	I_LLOAD
	|	I_ALOAD
	;

store:
		I_GSTORE
	|	I_LSTORE
	|	I_ASTORE
	;

arg:
		TEMPORARIE
	;

args:
		arg more_args
	|	/*empty*/
	;

more_args:
		COMMA arg more_args
	|	/*empty*/
	;

%%

/* called when there is a syntax error */
void yyerror(const char *msg)
{
  fprintf(stderr, "error: %s\n", msg);
}

int main()
{
  return yyparse();
}