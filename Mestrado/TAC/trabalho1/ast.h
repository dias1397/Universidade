#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct tree *tree;
typedef struct global_declarations *global_declarations;
typedef struct global_declaration *global_declaration;

typedef struct variable_declaration *variable_declaration;
typedef struct function_declaration *function_declaration;

typedef struct identifier *identifier;

typedef struct expression *expression;
typedef struct expressions *expressions;

typedef struct formal_arg * formal_arg;
typedef struct formal_args *formal_args;
typedef struct more_formal_args *more_formal_args;
typedef struct body *body;

typedef struct kind *kind;
typedef struct type *type;

typedef struct statement *statement;
typedef struct statements *statements;
typedef struct if_statement *if_statement;
typedef struct call_statement *call_statement;

typedef struct fun_call *fun_call;
typedef struct atomic_expression *atomic_expression;

enum kind_ {VAR_, LOCAL_, ARG_};
enum type_ {INT_, REAL_, BOOL_};
enum op_ {OR, AND, EQ, NE, 
		LT, LE, GT, GE,
		PLUS, MINUS, TIMES, DIV, MOD,
		INV, TOREAL};

struct tree
{
	global_declarations root;	
};

struct global_declarations
{
	enum{one, multi} kind;

	union {
		global_declaration arg0;
	}single_decl;

	union {
		global_declaration arg0;
		global_declarations arg1;
	}multi_decl;
};

struct global_declaration
{
	enum{var, fun} kind;

	union {
		variable_declaration arg0;
	}var_decl;

	union {
		function_declaration arg0;
	}fun_decl;
};

struct variable_declaration
{
	identifier arg0;
	expression arg1;
};

struct function_declaration
{
	char *arg0;
	formal_args arg1;
	body arg2;
};

struct identifier
{
	char *arg0;
	kind arg1;
	type arg2;
};

struct expression
{
	enum{binop, unop, literal, atomic} kind;

	union{
		operator arg0;
		expression arg1;
		expression arg2;
	}binop;

	union{
		operator arg0;
		expression arg1;
	}unop;

	union{
		literal arg0;
		type arg1;
	}literal;

	union{
		atomic_expression arg0;
		type arg1;
	}atomic;
};

struct formal_arg
{
	char *arg0;
	type arg1;
};

struct formal_args
{
	formal_arg arg0;
	more_formal_args arg1;
};

struct more_formal_args
{
	formal_arg arg0;
	more_formal_args arg1;
};

struct body
{
	local_declarations arg0;
	statement arg1;
	expression arg2;
};

struct kind{
};

struct type{
};

struct statement{
	enum{assign_, call_, print_, if_, while_, stmts_} kind;
	
	union{
		identifier arg0;
		expression arg1;
	}assign_;
	union{
		call_statement arg0;
	}call_;
	union{
		expression arg0;
	}print_;
	union{
		if_statement arg0;
	}if_;
	union{
		expression arg0;
		statement arg1;
	}while_;
	union{
		statements arg0;
	}stmts_;
};

struct statements{
	statement arg0;
	statements arg1;
};

struct call_statement{
	union{
		char *arg0;
	}u1;
	union{
		identifier arg0;
	}u2;
	
	expressions arg1;
};

struct if_statement{
	expression arg0;
	statement arg1;
	statement arg2;
};

struct expressions{
	expression arg0;
	expressions arg1;
};

struct atomic_expression{
	identifier arg0;
	fun_call arg1;
	int arg2;
};

struct fun_call{
	char *arg0;
	expressions arg1;
};




