%{
#include <stdio.h>
#include "ast.h"

int yylex(void);
void yyerror(const char *);	// see below
%}

%union {
	char   *string;
	int    integer;
	double real;

	struct tree *tree;
	struct global_declarations *global_declarations;
	struct global_declaration *global_declaration;
	struct variable_declaration *variable_declaration;
	struct function_declaration *function_declaration;
	struct identifier *identifier;
	struct expressions *expressions;
	struct expression *expression;
	struct statements *statements;
	struct statement *statement;
	struct kind *kind;
	struct type *type;
	struct operator *operator;
	struct formal_args *formal_args;
	struct formal_arg *formal_arg;
	struct body *body;
	struct local_declarations *local_declarations;
	struct local_declaration *local_declaration;
	struct if_statement *if_statement;
	struct call_statement *call_statement;
	struct fun_call *fun_call;
	struct atomic_expression *atomic_expression;
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

%type <tree> tree
%type <global_declarations> global_declarations
%type <global_declaration> global_declaration
%type <variable_declaration> variable_declaration
%type <function_declaration> function_declaration
%type <identifier> identifier
%type <expressions> expressions
%type <expression> expression
%type <statements> statements
%type <statement> statement
%type <kind> kind
%type <type> type
%type <operator> operator
%type <formal_args> formal_args
%type <formal_arg> formal_arg
%type <body> body
%type <local_declarations> local_declarations
%type <local_declaration> local_declaration
%type <if_statement> if_statement
%type <call_statement> call_statement
%type <fun_call> fun_call
%type <atomic_expression> atomic_expression

%%

program : 
		global_declarations
	;

global_declarations : 
		global_declaration global_declarations		{$$ = new_global_declarations($1, $2);}
	|	global_declarations 						{$$ = new_global_declarations($1, null);}
	;

global_declaration :
		variable_declaration						{$$ = new_global_declaration($1);}
	|	function_declaration						{$$ = new_global_declaration($1);}
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
		formal_arg formal_args
	| 	/*empty*/
	;

body :
		OPPAR BODY OPRPAR local_declarations CLRPAR statement expression CLPAR
	;

local_declaration :
		OPPAR LOCAL IDENTIFIER type expression CLPAR
	;

local_declarations :
		local_declaration local_declarations
	|	/*empty*/
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