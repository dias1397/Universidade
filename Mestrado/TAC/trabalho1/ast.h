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

typedef struct formal_args *formal_args;
typedef struct body *body;

typedef struct kind *kind;
typedef struct type *type;


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
		struct {
			global_declaration arg0;
		}single_decl;
		struct {
			global_declaration arg0;
			global_declarations arg1;
		}multi_decl;
	}u;
};

struct global_declaration
{
	enum{var, fun} kind;

	union {
		struct {
			variable_declaration arg0;
		}var_decl;
		struct {
			function_declaration arg0;
		}fun_decl;
	}u;
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
	enum{binop, unop, lit, iden, call} kind;
	union{
		operator arg0;
		expression arg
	}u;
};
