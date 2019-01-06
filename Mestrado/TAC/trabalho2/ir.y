%{
#include <stdio.h>
#include "mips.h"

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

	struct preamble *preamble;

	struct global_symbol *global_symbol;
	struct variable_declaration *variable_declaration;
	struct function_declaration *function_declaration;
	struct formal_args *formal_args;
	struct formal_arg *formal_arg;
	struct local_vars *local_vars;
	struct local_var *local_var;
	struct literal *literal;
	struct type *type;

	struct functions *functions;

	struct ir_function *ir_function;
	struct instructions *instructions;
	struct instruction *instruction;
	struct operation *operation;
	struct load *load;
	struct store *store;
	struct arg *arg;
	struct args *args;
	struct more_args *more_args;
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

%token <string> TEMPORARIE
%token <string> LABEL
%token <integer> BOOL_LITERAL
%token <integer> INT_LITERAL
%token <string> IDENTIFIER

%token ERROR

%left I_ADD I_SUB
%left I_MUL I_DIV MOD
%left I_EQ I_LT I_NE I_LE

%nonassoc NOT I_INV ITOR

%type <preamble> preamble
%type <global_symbol> global_symbol
%type <variable_declaration> variable_declaration
%type <function_declaration> function_declaration
%type <formal_args> formal_args
%type <formal_arg> formal_arg
%type <local_vars> local_vars
%type <local_var> local_var
%type <literal> literal
%type <type> type
%type <functions> functions
%type <ir_function> ir_function
%type <instructions> instructions
%type <instruction> instruction
%type <operation> operation
%type <load> load
%type <store> store
%type <arg> arg
%type <args> args
%type <more_args> more_args

%%

program: 
		preamble functions 										{mips($1, $2);}
	;

preamble: 	
		global_symbol preamble 									{$$ = new_preamble($1, $2);}
	| 	global_symbol 											{$$ = new_preamble($1, NULL);}
	;

global_symbol: 	
		variable_declaration 									{$$ = new_global_symbol($1, NULL);}
	| 	function_declaration 									{$$ = new_global_symbol(NULL, $1);}
	;

variable_declaration:
		OPPAR ID AT IDENTIFIER VAR type CLPAR 					{$$ = new_variable_declaration($4, $6, NULL);}
	| 	OPPAR ID AT IDENTIFIER VAR type literal CLPAR 			{$$ = new_variable_declaration($4, $6, $7);}
	;

function_declaration:
		OPPAR ID AT IDENTIFIER FUN type OPRPAR formal_args CLRPAR OPRPAR local_vars CLRPAR CLPAR  {$$ = new_function_declaration($4, $6, $8, $11);}
	;

formal_args:
		formal_arg formal_args 									{$$ = new_formal_args($1, $2);}
	|	/*empty*/ 												{$$ = no_formal_args();}
	;	

formal_arg:
		OPPAR type AT IDENTIFIER CLPAR 							{$$ = new_formal_arg($2, $4);}
	;

local_vars:
		local_var local_vars 									{$$ = new_local_vars($1, $2);}
	|	/*empty*/ 												{$$ = no_local_vars();}
	;

local_var:
		OPPAR type AT IDENTIFIER CLPAR 							{$$ = new_local_var($2, $4);}
	;

type:
		INT 													{$$ = new_type(int_);}
	|	BOOL 													{$$ = new_type(bool_);}
	| 	VOID 													{$$ = new_type(void_);}
	;

literal:
		INT_LITERAL 											{$$ = new_int_literal($1);}
	| 	BOOL_LITERAL 											{$$ = new_bool_literal($1);}
	;

functions:
		ir_function functions 									{$$ = new_functions($1, $2);}
	|	ir_function 											{$$ = new_functions($1, NULL);}
	;

ir_function:
		IR_FUN AT IDENTIFIER instructions 						{$$ = new_ir_function($3, $4);}
	;

instructions:
		instruction instructions 								{$$ = new_instructions($1, $2);}
	| 	instruction 											{$$ = new_instructions($1, NULL);}
	;

instruction:
		TEMPORARIE ARROW operation TEMPORARIE COMMA TEMPORARIE 	{$$ = new_binop_instruction($1, $3, $4, $6);}
	|	TEMPORARIE ARROW operation TEMPORARIE 					{$$ = new_unop_instruction($1, $3, $4);}

	|	TEMPORARIE ARROW I_VALUE literal 						{$$ = new_value_instruction($1, $4);}
	|	TEMPORARIE ARROW load AT IDENTIFIER 					{$$ = new_load_instruction($1, $3, $5);}
	|	AT IDENTIFIER ARROW store TEMPORARIE 					{$$ = new_store_instruction($2, $4, $5);}

	|	JUMP LABEL 												{$$ = new_jump_instruction($2);}
	|	CJUMP TEMPORARIE COMMA LABEL COMMA LABEL 				{$$ = new_cjump_instruction($2, $4, $6);}

	|	TEMPORARIE ARROW I_CALL AT IDENTIFIER COMMA OPRPAR args CLRPAR 	{$$ = new_icall_instruction($1, $5, $8);}
	|	CALL AT IDENTIFIER COMMA OPRPAR args CLRPAR 			{$$ = new_call_instruction($3, $6);}

	|	I_RETURN TEMPORARIE 									{$$ = new_return_instruction(0, $2);}
	|	RETURN TEMPORARIE 										{$$ = new_return_instruction(1, $2);}
	| 	RETURN 													{$$ = new_return_instruction(2, NULL);}

	|	I_PRINT TEMPORARIE 										{$$ = new_print_instruction(0, $2);}
	|	B_PRINT TEMPORARIE 										{$$ = new_print_instruction(1, $2);}

	| 	LABEL COLON instruction 								{$$ = new_label_instruction($1, $3);}
	;

operation:
		I_ADD 													{$$ = new_operation(i_add);}
	|	I_SUB 													{$$ = new_operation(i_sub);}
	|	I_MUL 													{$$ = new_operation(i_mul);}
	|	I_DIV 													{$$ = new_operation(i_div);}
	|	I_INV 													{$$ = new_operation(i_inv);}
	|	MOD 													{$$ = new_operation(mod);}
	|	I_EQ 													{$$ = new_operation(i_eq);}
	|	I_LT 													{$$ = new_operation(i_lt);}
	|	I_NE 													{$$ = new_operation(i_ne);}
	|	I_LE 													{$$ = new_operation(i_le);}
	|	ITOR 													{$$ = new_operation(itor);}
	|	NOT 													{$$ = new_operation(_not);}
	|	I_COPY 													{$$ = new_operation(i_copy);}
	;

load:
		I_GLOAD 												{$$ = new_load(gload_);}
	|	I_LLOAD 												{$$ = new_load(lload_);}
	|	I_ALOAD 												{$$ = new_load(aload_);}
	;

store:
		I_GSTORE 												{$$ = new_store(gstore_);}
	|	I_LSTORE 												{$$ = new_store(lstore_);}
	|	I_ASTORE 												{$$ = new_store(astore_);}
	;

arg:
		TEMPORARIE 												{$$ = new_arg($1);}
	;

args:
		arg more_args 											{$$ = new_args($1, $2);}
	|	/*empty*/ 												{$$ = no_args();}
	;

more_args:
		COMMA arg more_args 									{$$ = new_more_args($2, $3);}
	|	/*empty*/ 												{$$ = no_more_args();}
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