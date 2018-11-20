%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *);	// see below
%}

%union {
  char   *string;
  int    integer;
  double real;
}

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

%token INT_LITERAL_VALUE
%token REAL_LITERAL_VALUE
%token BOOL_LITERAL
%token IDENTIFIER

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
		OPPAR VAR identifier expression CLPAR
	;

function_declaration :
		OPPAR FUN IDENTIFIER OPRPAR formal_args CLRPAR body CLPAR
	; 

identifier :
		OPPAR ID IDENTIFIER kind type CLPAR
	;

kind :
		VAR
	| 	LOCAL
	|	ARG
	;

type : 
		INT
	| 	REAL
	| 	BOOL
	;

formal_arg :
		OPPAR ARG IDENTIFIER type CLPAR
	;

formal_args :
		formal_arg more_formal_args
	| 	/*empty*/
	;

more_formal_args :
		formal_arg more_formal_args
	| 	/*empty*/
	;

body :
		OPPAR BODY OPRPAR local_declarations CLRPAR statement expression CLPAR
	;

local_declaration :
		OPPAR LOCAL IDENTIFIER type expression CLPAR
	;

local_declarations :
		local_declaration more_local_declarations
	|	/*empty*/
	;

more_local_declarations :
		local_declaration more_local_declarations
	| 	/*empty*/
	;

statements :
		statement statements
	| 	/*empty*/
	;

statement :
		NIL
	|	OPPAR ASSIGN identifier expression CLPAR
	| 	OPPAR call_statement CLPAR
	| 	OPPAR PRINT expression CLPAR
	|	OPPAR if_statement CLPAR
	| 	OPPAR WHILE expression statement CLPAR
	|	OPRPAR statements CLRPAR
	;

if_statement :
		IF expression statement statement
	;

call_statement :
		CALL identifier OPRPAR expressions CLRPAR
	|	CALL IDENTIFIER OPRPAR expressions CLRPAR
	;

expressions :
		expression expressions
	|	/*empty*/
	;

expression :
		OPPAR operator_two expression expression CLPAR COLON type
	|	OPPAR operator_one expression CLPAR COLON type
	|	OPPAR literal CLPAR COLON type
	|	atomic_expression COLON type
	|	NIL
	;


fun_call :
		OPPAR CALL IDENTIFIER OPRPAR expressions CLRPAR CLPAR
	;

operator_two :
		OR
	|	AND
	|	EQ
	|	NE
	|	LT
	|	LE
	|	GT
	|	GE
	|	PLUS
	|	MINUS
	|	TIMES
	|	DIV
	|	MOD
	;

operator_one :
		NOT
	|	INV
	|	TOREAL
	;

atomic_expression :
		identifier
	|	fun_call
	|	BOOL_LITERAL
	;

literal :
		INT_LITERAL INT_LITERAL_VALUE
	| 	REAL_LITERAL REAL_LITERAL_VALUE
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