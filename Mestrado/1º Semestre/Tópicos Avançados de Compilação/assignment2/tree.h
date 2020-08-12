#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct preamble *preamble;

typedef struct global_symbol *global_symbol;
typedef struct variable_declaration *variable_declaration;
typedef struct function_declaration *function_declaration;
typedef struct formal_args *formal_args;
typedef struct formal_arg *formal_arg;
typedef struct local_vars *local_vars;
typedef struct local_var *local_var;
typedef struct literal *literal;
typedef struct type *type;

typedef struct functions *functions;

typedef struct ir_function *ir_function;
typedef struct instructions *instructions;
typedef struct instruction *instruction;
typedef struct operation *operation;
typedef struct load *load;
typedef struct store *store;
typedef struct arg *arg;
typedef struct args *args;
typedef struct more_args *more_args;

typedef enum type_ {int_, bool_, void_} type_;
typedef enum load_ {gload_, lload_, aload_} load_type_;
typedef enum store_ {gstore_, lstore_, astore_} store_type_;
typedef enum operation_ {
	i_add, i_sub, i_mul, i_div,
	i_inv, mod, i_eq, i_lt, i_ne, 
	i_le, itor, _not, i_copy
}operation_;

struct preamble
{
	enum {single, multi} kind;

	union
	{
		struct
		{
			global_symbol 	global_symbol;
		}single;
		struct
		{
			global_symbol 	global_symbol;
			preamble 		preamble;
		}multi;
	}u;
};

struct global_symbol
{
	enum {var, fun} kind;

	union
	{
		variable_declaration variable_declaration;
		function_declaration function_declaration;
	}u;
};

struct variable_declaration
{
	enum {empty, init} kind;

	char *identifier;
	
	union
	{
		struct 
		{
			type type;
		}empty;
		struct 
		{
			type type;
			literal literal;
		}init;
	}u;
};

struct function_declaration
{
	char *identifier;

	type 		type;
	formal_args formal_args;
	local_vars 	local_vars;
};

struct formal_args 
{
	enum {empty_fa, full_fa} kind;

	formal_arg 	formal_arg;
	formal_args	formal_args;
};

struct formal_arg
{
	type type;
	char *identifier;	
};

struct local_vars
{
	enum {empty_lv, full_lv} kind;

	local_var  local_var;
	local_vars local_vars;
};

struct local_var
{
	type type;
	char *identifier;	
};

struct type
{
	type_ kind;
};

struct literal
{
	enum {intlit_, boollit_} kind;

	union
	{
		int int_literal;
		int bool_literal;
	}u;
};


struct functions
{
	enum {single_fun, multi_fun} kind;

	union
	{
		struct
		{
			ir_function ir_function;
		}single;
		struct
		{
			ir_function ir_function;
			functions 	functions;
		}multi;
	}u;
};

struct ir_function
{
	char *identifier;
	instructions instructions;
};

struct instructions
{
	enum {single_inst, multi_inst} kind;

	union
	{
		struct
		{
			instruction  instruction;
		}single;
		struct
		{
			instruction  instruction;
			instructions instructions;
		}multi;
	}u;
};

struct instruction
{	
	enum {binop_, unop_, value_, load_, store_, jump_, cjump_, icall_, call_, return_, print_, label_} kind;

	union
	{
		struct 
		{
			char *temporarie1;
			operation operation;
			char *temporarie2;
			char *temporarie3;
		}binop;
		struct 
		{
			char *temporarie1;
			operation operation;
			char *temporarie2;
		}unop;
		struct 
		{
			char *temporarie1;
			literal literal;
		}value;
		struct
		{
			char *temporarie1;
			load load;
			char *identifier;
		}load;
		struct
		{
			char *identifier;
			store store;
			char *temporarie1;
		}store;
		struct
		{
			char *label;
		}jump;
		struct
		{
			char *temporarie1;
			char *label1;
			char *label2;
		}cjump;
		struct 
		{
			char *temporarie1;
			char *identifier;
			args args;
		}icall;
		struct
		{
			char *identifier;
			args args;
		}call;
		struct
		{
			enum {iret_, ret_, voidret_} ret_type;

			char *temporarie1;
		}ret;
		struct 
		{
			enum {i, b} kind;
			char *temporarie1;
		}print;
		struct 
		{
			char *label1;
			instruction instruction;
		}label;
	}u;
};

struct operation
{
	operation_ kind;
};

struct load
{
	load_type_ kind;
};

struct store
{
	store_type_ kind;
};

struct arg
{
	char *temporarie1;
};

struct args
{
	enum {empty_args, full_args} kind;

	arg arg;
	more_args more_args;
};

struct more_args
{
	enum {empty_margs, full_margs} kind;

	arg arg;
	more_args more_args;
};

preamble new_preamble(global_symbol arg0, preamble arg1);

global_symbol new_global_symbol(variable_declaration arg0, function_declaration arg1);
variable_declaration new_variable_declaration(char *arg0, type arg1, literal arg2);
function_declaration new_function_declaration(char *arg0, type arg1, formal_args arg2, local_vars arg3);
formal_args new_formal_args(formal_arg arg0, formal_args arg1);
formal_args no_formal_args();
formal_arg new_formal_arg(type arg0, char *arg1);
local_vars new_local_vars(local_var arg0, local_vars arg1);
local_vars no_local_vars();
local_var new_local_var(type arg0, char *arg1);
type new_type(type_ arg0);
literal new_int_literal(int arg0);
literal new_bool_literal(int arg0);

functions new_functions(ir_function arg0, functions arg1);

ir_function new_ir_function(char *arg0, instructions arg1);
instructions new_instructions(instruction arg0, instructions arg1);
instruction new_binop_instruction(char *arg0, operation arg1, char *arg2, char *arg3);
instruction new_unop_instruction(char *arg0, operation arg1, char *arg2);
instruction new_value_instruction(char *arg0, literal arg1);
instruction new_load_instruction(char *arg0, load arg1, char *arg2);
instruction new_store_instruction(char *arg0, store arg1, char *arg2);
instruction new_jump_instruction(char *arg0);
instruction new_cjump_instruction(char *arg0, char *arg1, char *arg2);
instruction new_icall_instruction(char *arg0, char *arg1, args arg2);
instruction new_call_instruction(char *arg0, args arg1);
instruction new_return_instruction(int type, char *arg0);
instruction new_print_instruction(int type, char *arg0);
instruction new_label_instruction(char *arg0, instruction arg1);
operation new_operation(operation_ arg0);
load new_load(load_type_ arg0);
store new_store(store_type_ arg0);
arg new_arg(char *arg0);
args new_args(arg arg0, more_args arg1);
args no_args();
more_args new_more_args(arg arg0, more_args arg1);
more_args no_more_args();