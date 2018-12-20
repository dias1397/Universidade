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
typedef enum load_ {global_, local_, arg_} load_;
typedef enum store_ {global_, local_, arg_} store;
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
	enum {int_, bool_} kind;

	union
	{
		int int_literal;
		int bool_literal;
	}u;
};


struct functions
{
	ir_function ir_function;
	functions 	functions;
};

struct ir_function
{
	char *identifier;
	instructions instructions;
};

struct instructions
{
	instruction  instruction;
	instructions instructions;
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
			enum {iret_, ret_, void_} ret_type;

			char *temporarie1;
		}ret;
		struct 
		{
			char *temporarie1;
		}print;
		struct 
		{
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
	load_ kind;
};

struct store
{
	store_ kind;
};

struct arg
{
	char *temporarie1;
}

struct args
{
	arg arg;
	more_args more_args;
}

struct more_args
{
	arg arg;
	more_args more_args;
}
