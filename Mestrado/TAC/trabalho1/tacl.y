%{
#include <stdio.h>
#include "ir.h"

int yylex(void);
void yyerror(const char *);	// see below
%}

%union {
	char   *string;
	int    integer;
	double real;

	struct global_declarations *global_declarations;
	struct global_declaration *global_declaration;
	struct variable_declaration *variable_declaration;
	struct function_declaration *function_declaration;
	struct identifier *identifier;
	struct literal *literal;
	struct expressions *expressions;
	struct expression *expression;
	struct statements *statements;
	struct statement *statement;
	struct kind *kind;
	struct type *type;
	struct operator_one *operator_one;
	struct operator_two *operator_two;
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

%type <global_declarations> global_declarations
%type <global_declaration> global_declaration
%type <variable_declaration> variable_declaration
%type <function_declaration> function_declaration
%type <identifier> identifier
%type <literal> literal
%type <expressions> expressions
%type <expression> expression
%type <statements> statements
%type <statement> statement
%type <kind> kind
%type <type> type
%type <operator_one> operator_one
%type <operator_two> operator_two
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
		global_declarations 												{ir($1);}
	;

global_declarations : 
		global_declaration global_declarations								{$$ = new_global_declarations($1, $2);}
	|	/*empty*/															{}
	;

global_declaration :
		variable_declaration												{$$ = new_global_declaration($1, NULL);}
	|	function_declaration												{$$ = new_global_declaration(NULL, $1);}
	;

variable_declaration :
		OPPAR VAR identifier expression CLPAR 								{$$ = new_variable_declaration($3, $4);}
	;

function_declaration :
		OPPAR FUN IDENTIFIER OPRPAR formal_args CLRPAR body CLPAR 			{$$ = new_function_declaration($3, $5, $7);}
	; 

identifier :
		OPPAR ID IDENTIFIER kind type CLPAR 								{$$ = new_identifier($3, $4, $5);}
	;

kind :
		VAR 																{$$ = new_kind(VAR_);}
	| 	LOCAL 																{$$ = new_kind(LOCAL_);}
	|	ARG 																{$$ = new_kind(ARG_);}
	;

type : 
		INT 																{$$ = new_type(INT_);}
	| 	REAL 																{$$ = new_type(REAL_);}
	| 	BOOL 																{$$ = new_type(BOOL_);}
	;

formal_arg :
		OPPAR ARG IDENTIFIER type CLPAR 									{$$ = new_formal_arg($3, $4);}
	;

formal_args :
		formal_arg formal_args 												{$$ = new_formal_args($1, $2);}
	| 	/*empty*/ 															{}
	;

body :
		OPPAR BODY OPRPAR local_declarations CLRPAR statement expression CLPAR 			{$$ = new_body($4, $6, $7);}
	;

local_declaration :
		OPPAR LOCAL IDENTIFIER type expression CLPAR 						{$$ = new_local_declaration($3, $4, $5);}
	;

local_declarations :
		local_declaration local_declarations								{$$ = new_local_declarations($1, $2);}
	|	/*empty*/ 															{}
	;

statements :
		statement statements 												{$$ = new_statements($1, $2);}
	| 	/*empty*/ 															{}
	;

statement :
		NIL 																{}
	|	OPPAR ASSIGN identifier expression CLPAR 							{$$ = new_statement_assign($3, $4);}
	| 	OPPAR call_statement CLPAR 											{$$ = new_statement_call($2);}
	| 	OPPAR PRINT expression CLPAR 										{$$ = new_statement_print($3);}
	|	OPPAR if_statement CLPAR 											{$$ = new_statement_if($2);}
	| 	OPPAR WHILE expression statement CLPAR 								{$$ = new_statement_while($3, $4);}
	|	OPRPAR statements CLRPAR 											{$$ = new_statement_compound($2);}
	;

if_statement :
		IF expression statement statement 									{$$ = new_if_statement($2, $3, $4);}
	;

call_statement :
		CALL identifier OPRPAR expressions CLRPAR 							{$$ = new_call_statement(NULL, $2, $4);}
	|	CALL IDENTIFIER OPRPAR expressions CLRPAR 							{$$ = new_call_statement($2, NULL, $4);}
	;

expressions :
		expression expressions 												{$$ = new_expressions($1, $2);}
	|	/*empty*/ 															{}
	;

expression :
		OPPAR operator_two expression expression CLPAR COLON type 			{$$ = new_expression_operation($2, NULL, $3, $4, $7);}
	|	OPPAR operator_one expression CLPAR COLON type 						{$$ = new_expression_operation(NULL, $2, $3, NULL, $6);}
	|	OPPAR literal CLPAR COLON type 										{$$ = new_expression_literal($2, $5);}
	|	atomic_expression COLON type 										{$$ = new_expression_atomic($1, $3);}
	|	NIL 																{$$ = new_expression_empty();}
	;


fun_call :
		OPPAR CALL IDENTIFIER OPRPAR expressions CLRPAR CLPAR 				{$$ = new_fun_call($3, $5);}
	;

operator_two :
		OR 																	{$$ = new_operator_two(OR_);}
	|	AND 																{$$ = new_operator_two(AND_);}
	|	EQ 																	{$$ = new_operator_two(EQ_);}
	|	NE 																	{$$ = new_operator_two(NE_);}
	|	LT 																	{$$ = new_operator_two(LT_);}
	|	LE 																	{$$ = new_operator_two(LE_);}
	|	GT 																	{$$ = new_operator_two(GT_);}
	|	GE 																	{$$ = new_operator_two(GE_);}
	|	PLUS 																{$$ = new_operator_two(PLUS_);}
	|	MINUS 																{$$ = new_operator_two(MINUS_);}
	|	TIMES 																{$$ = new_operator_two(TIMES_);}
	|	DIV 																{$$ = new_operator_two(DIV_);}
	|	MOD 																{$$ = new_operator_two(MOD_);}
	;

operator_one :
		NOT 																{$$ = new_operator_one(NOT_);}
	|	INV 																{$$ = new_operator_one(INV_);}
	|	TOREAL 																{$$ = new_operator_one(TOREAL_);}
	;

atomic_expression :
		identifier 															{$$ = new_atomic_identifier($1);}
	|	fun_call 															{$$ = new_atomic_fun_call($1);}
	|	BOOL_LITERAL 														{$$ = new_atomic_boolean($1);}
	;

literal :
		INT_LITERAL INT_LITERAL_VALUE 										{$$ = new_literal_int($2);}
	| 	REAL_LITERAL REAL_LITERAL_VALUE 									{$$ = new_literal_real($2);}
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