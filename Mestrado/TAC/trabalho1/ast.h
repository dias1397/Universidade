#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct global_declarations *global_declarations;
typedef struct global_declaration *global_declaration;

typedef struct variable_declaration *variable_declaration;
typedef struct function_declaration *function_declaration;

typedef struct identifier *identifier;
typedef struct literal *literal;

typedef struct expression *expression;
typedef struct expressions *expressions;

typedef struct statement *statement;
typedef struct statements *statements;

typedef struct kind *kind;
typedef struct type *type;
typedef struct operator_one *operator_one;
typedef struct operator_two *operator_two;

typedef struct formal_arg  *formal_arg;
typedef struct formal_args *formal_args;

typedef struct body *body;
typedef struct local_declarations *local_declarations;
typedef struct local_declaration *local_declaration;

typedef struct if_statement *if_statement;
typedef struct call_statement *call_statement;

typedef struct fun_call *fun_call;
typedef struct atomic_expression *atomic_expression;

typedef enum kind_ {VAR_, LOCAL_, ARG_} kind_;
typedef enum type_ {INT_, REAL_, BOOL_} type_;
typedef enum op2_ {OR_, AND_, EQ_, NE_, 
		LT_, LE_, GT_, GE_,
		PLUS_, MINUS_, TIMES_, DIV_, MOD_} op2_;
typedef enum op1_{INV_, TOREAL_, NOT_} op1_;

struct global_declarations
{
	enum{single, multi} kind;

	union {
		struct
		{
			global_declaration arg0;			
		}single_decl;
		struct
		{
			global_declaration arg0;
			global_declarations arg1;		
		}multi_decl;
	}u;
};

struct global_declaration
{
	enum{var, fun} kind;

	union 
	{
		struct
		{
			variable_declaration arg0;
		}var_decl;
		struct
		{
			function_declaration arg1;	
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

struct literal
{
	enum{integer, real} kind;

	union
	{
		struct
		{
			int arg0;
		}int_;
		struct
		{
			double arg1;
		}real_;
	}u;
};

struct expression
{
	enum{BINOP, UNOP, LITERAL, ATOMIC} kind;

	union
	{
		struct
		{
			operator_two arg0;
			expression arg1;
			expression arg2;
			type arg3;
		}binop;
		struct
		{
			operator_one arg0;
			expression arg1;	
			type arg2;
		}unop;
		struct
		{
			literal arg0;
			type arg1;
		}literal;
		struct
		{
			atomic_expression arg0;
			type arg1;
		}atomic;
	}u;
};

struct expressions
{
	expression arg0;
	expressions arg1;
};

struct statement
{
	enum{ASSIGN_, CALL_, PRINT_, IF_, WHILE_, STMTS_} kind;
	
	union{
		struct
		{
			identifier arg0;
			expression arg1;
		}assign_;
		struct
		{
			call_statement arg0;
		}call_;
		struct
		{
			expression arg0;
		}print_;
		struct
		{
			if_statement arg0;
		}if_;
		struct
		{
			expression arg0;
			statement arg1;
		}while_;
		struct
		{
			statements arg0;
		}compound_;
	}u;
};

struct statements
{
	statement arg0;
	statements arg1;
};

struct kind
{
	kind_ kind;
};

struct type
{
	type_ type;
};

struct operator_one
{
	op1_ op1;
};

struct operator_two
{
	op2_ op2;
};

struct formal_arg
{
	char *arg0;
	type arg1;
};

struct formal_args
{
	formal_arg arg0;
	formal_args arg1;
};

struct body
{
	local_declarations arg0;
	statement arg1;
	expression arg2;
};

struct local_declarations
{
	local_declaration arg0;
	local_declarations arg1;
};

struct local_declaration
{
	char *arg0;
	type arg1;
	expression arg2;
};

struct if_statement
{
	expression arg0;
	statement arg1;
	statement arg2;
};

struct call_statement
{
	union{
		char *arg0;
		identifier arg1;
	}u;
	
	expressions arg2;
};

struct fun_call
{
	char *arg0;
	expressions arg1;
};

struct atomic_expression
{
	identifier arg0;
	fun_call arg1;
	int arg2;
};

global_declarations new_global_declarations(global_declaration arg0, global_declarations arg1);
global_declaration new_global_declaration(variable_declaration arg0, function_declaration arg1);

variable_declaration new_variable_declaration(identifier arg0, expression arg1);
function_declaration new_function_declaration(char *arg0, formal_args arg1, body arg2);

identifier new_identifier(char *arg0, kind arg1, type arg2);
literal new_literal_int(int arg0);
literal new_literal_real(double arg0);

expressions new_expressions(expression arg0, expressions arg1);
expression new_expression_operation(operator_two arg0, operator_one arg1, expression arg2, expression arg3, type arg4);
expression new_expression_literal(literal arg0, type arg1);
expression new_expression_atomic(atomic_expression arg0, type arg1);
expression new_expression_empty();

statements new_statements(statement arg0, statements arg1);
statement new_statement_assign(identifier arg0, expression arg1);
statement new_statement_call(call_statement arg0);
statement new_statement_print(expression arg0);
statement new_statement_if(if_statement arg0);
statement new_statement_while(expression arg0, statement arg1);
statement new_statement_compound(statements arg0);

kind new_kind(kind_ arg0);
type new_type(type_ arg0);
operator_one new_operator_one(op1_ arg0);
operator_two new_operator_two(op2_ arg0);

formal_arg new_formal_arg(char *arg0, type arg1);
formal_args new_formal_args(formal_arg arg0, formal_args arg1);
body new_body(local_declarations arg0, statement arg1, expression arg2);
local_declarations new_local_declarations(local_declaration arg0, local_declarations arg1);
local_declaration new_local_declaration(char *arg0, type arg1, expression arg2);

if_statement new_if_statement(expression arg0, statement arg1, statement arg2);
call_statement new_call_statement(char *arg0, identifier arg1, expressions arg2);

fun_call new_fun_call(char *arg0, expressions arg1);
atomic_expression new_atomic_identifier(identifier arg0);
atomic_expression new_atomic_fun_call(fun_call arg0);
atomic_expression new_atomic_boolean(int arg0);