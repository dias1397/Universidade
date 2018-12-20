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
		preamble functions
	;

preamble: 	
		global_symbol preamble 									{$$ = new_preamble($1, $2);}
	| 	global_symbol 											{$$ = new_preamble($1, NULL);}
	;

global_symbol: 	
		variable_declaration 									{$$ = new_global_symbol($1, NULL):}
	| 	function_declaration 									{$$ = new_global_symbol(NULL, $1):}
	;

variable_declaration:
		OPPAR ID AT IDENTIFIER VAR type CLPAR 					{$$ = new_variable_declaration($4, $6, NULL):}
	| 	OPPAR ID AT IDENTIFIER VAR type literal CLPAR 			{$$ = new_variable_declaration($4, $6, $7):}
	;

function_declaration:
		OPPAR ID AT IDENTIFIER FUN type OPRPAR formal_args CLRPAR OPRPAR local_vars CLRPAR CLPAR  {$$ = new_function_declaration($4, $6, $8, $11):}
	;

formal_args:
		formal_arg formal_args 									{$$ = new_formal_args($1, $2):}
	|	/*empty*/ 												{}
	;	

formal_arg:
		OPPAR type AT IDENTIFIER CLPAR 							{$$ = new_formal_arg($2, $4):}
	;

local_vars:
		local_var local_vars 									{$$ = new_local_vars($1, $2):}
	|	/*empty*/
	;

local_var:
		OPPAR type AT IDENTIFIER CLPAR 							{$$ = new_local_var($2, $4):}
	;

type:
		INT 													{$$ = new_type(int_):}
	|	BOOL 													{$$ = new_type(bool_):}
	| 	VOID 													{$$ = new_type(void_):}
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
	|	RETURN

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