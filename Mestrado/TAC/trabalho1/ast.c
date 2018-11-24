#include "ast.h"

global_declarations new_global_declarations(global_declaration arg0, global_declarations arg1)
{
	global_declarations ret = (global_declarations) malloc(sizeof(*ret));

	if (arg1 == NULL)
	{
		ret->kind = single;
		ret->u.single_decl.arg0 = arg0;
	}
	else
	{
		ret->kind = multi;
		ret->u.multi_decl.arg0 = arg0;
		ret->u.multi_decl.arg1 = arg1;
	}

	return ret;
}

global_declaration new_global_declaration(variable_declaration arg0, function_declaration arg1)
{
	global_declaration ret = (global_declaration) malloc(sizeof(*ret));

	if (arg0 != NULL)
	{
		ret->kind = var;
		ret->u.var_decl.arg0 = arg0;
	}
	else
	{
		ret->kind = fun;
		ret->u.fun_decl.arg1 = arg1;
	}

	return ret;
}

variable_declaration new_variable_declaration(identifier arg0, expression arg1)
{
	variable_declaration ret = (variable_declaration) malloc(sizeof(*ret));

	ret->arg0 = arg0;
	ret->arg1 = arg1;

	return ret;
}

function_declaration new_function_declaration(char *arg0, formal_args arg1, body arg2)
{
	function_declaration ret = (function_declaration) malloc(sizeof(*ret));

	ret->arg0 = strdup(arg0);
	ret->arg1 = arg1;
	ret->arg2 = arg2;

	return ret;
}

identifier new_identifier(char *arg0, kind arg1, type arg2)
{
	identifier ret = (identifier) malloc(sizeof(*ret));

	ret->arg0 = strdup(arg0);
	ret->arg1 = arg1;
	ret->arg2 = arg2;

	return ret;
}

literal new_literal_int(int arg0)
{
	literal ret = (literal) malloc(sizeof(*ret));

	ret->kind = integer;
	ret->u.int_.arg0 = arg0;

	return ret;
}

literal new_literal_real(double arg0)
{
	literal ret = (literal) malloc(sizeof(*ret));

	ret->kind = real;
	ret->u.real_.arg1 = arg0;

	return ret;
}

expressions new_expressions(expression arg0, expressions arg1)
{
	expressions ret = (expressions) malloc(sizeof(*ret));

	ret->arg0 = arg0;
	ret->arg1 = arg1;

	return ret;
}

expression new_expression_operation(operator_two arg0, operator_one arg1, expression arg2, expression arg3, type arg4)
{
	expression ret = (expression) malloc(sizeof(*ret));

	if (arg3 == NULL)
	{
		ret->kind = UNOP;
		ret->u.unop.arg0 = arg1;
		ret->u.unop.arg1 = arg2;
		ret->u.unop.arg2 = arg4;
	}
	else
	{
		ret->kind = BINOP;
		ret->u.binop.arg0 = arg0;
		ret->u.binop.arg1 = arg2;
		ret->u.binop.arg2 = arg3;
		ret->u.binop.arg3 = arg4;
	}

	return ret;
}

expression new_expression_literal(literal arg0, type arg1)
{
	expression ret = (expression) malloc(sizeof(*ret));

	ret->kind = LITERAL;
	ret->u.literal.arg0 = arg0;
	ret->u.literal.arg1 = arg1;

	return ret;
}

expression new_expression_atomic(atomic_expression arg0, type arg1)
{
	expression ret = (expression) malloc(sizeof(*ret));

	ret->kind = ATOMIC;
	ret->u.atomic.arg0 = arg0;
	ret->u.atomic.arg1 = arg1;

	return ret;
}

expression new_expression_empty()
{
	return NULL;
}

statements new_statements(statement arg0, statements arg1)
{
	statements ret = (statements) malloc(sizeof(*ret));

	ret->arg0 = arg0;
	ret->arg1 = arg1;

	return ret;
}

statement new_statement_assign(identifier arg0, expression arg1)
{
	statement ret = (statement) malloc(sizeof(*ret));

	ret->kind = ASSIGN_;
	ret->u.assign_.arg0 = arg0;
	ret->u.assign_.arg1 = arg1;

	return ret;
}

statement new_statement_call(call_statement arg0)
{
	statement ret = (statement) malloc(sizeof(*ret));

	ret->kind = CALL_;
	ret->u.call_.arg0 = arg0;

	return ret;
}

statement new_statement_print(expression arg0)
{
	statement ret = (statement) malloc(sizeof(*ret));

	ret->kind = PRINT_;
	ret->u.print_.arg0 = arg0;

	return ret;
}

statement new_statement_if(if_statement arg0)
{
	statement ret = (statement) malloc(sizeof(*ret));

	ret->kind = IF_;
	ret->u.if_.arg0 = arg0;

	return ret;
}

statement new_statement_while(expression arg0, statement arg1)
{
	statement ret = (statement) malloc(sizeof(*ret));

	ret->kind = WHILE_;
	ret->u.while_.arg0 = arg0;
	ret->u.while_.arg1 = arg1;

	return ret;
}

statement new_statement_compound(statements arg0)
{
	statement ret = (statement) malloc(sizeof(*ret));

	ret->kind = STMTS_;
	ret->u.compound_.arg0 = arg0;

	return ret;
}

kind new_kind(kind_ arg0)
{
	kind ret = (kind) malloc(sizeof(*ret));

	ret->kind = arg0;

	return ret;
}

type new_type(type_ arg0)
{
	type ret = (type) malloc(sizeof(*ret));

	ret->type = arg0;

	return ret;
}

operator_one new_operator_one(op1_ arg0)
{
	operator_one ret =(operator_one) malloc(sizeof(*ret));

	ret->op1 = arg0;

	return ret;
}

operator_two new_operator_two(op2_ arg0)
{
	operator_two ret =(operator_two) malloc(sizeof(*ret));

	ret->op2 = arg0;

	return ret;
}

formal_arg new_formal_arg(char *arg0, type arg1)
{
	formal_arg ret = (formal_arg) malloc(sizeof(*ret));

	ret->arg0 = strdup(arg0);
	ret->arg1 = arg1;

	return ret;	
}

formal_args new_formal_args(formal_arg arg0, formal_args arg1)
{
	formal_args ret = (formal_args) malloc(sizeof(*ret));

	ret->arg0 = arg0;
	ret->arg1 = arg1;

	return ret;
}

body new_body(local_declarations arg0, statement arg1, expression arg2)
{
	body ret = (body) malloc(sizeof(*ret));

	ret->arg0 = arg0;
	ret->arg1 = arg1;
	ret->arg2 = arg2;

	return ret;
}

local_declarations new_local_declarations(local_declaration arg0, local_declarations arg1)
{
	local_declarations ret = (local_declarations) malloc(sizeof(*ret));

	ret->arg0 = arg0;
	ret->arg1 = arg1;

	return ret;
}

local_declaration new_local_declaration(char *arg0, type arg1, expression arg2)
{
	local_declaration ret = (local_declaration) malloc(sizeof(*ret));

	ret->arg0 = strdup(arg0);
	ret->arg1 = arg1;
	ret->arg2 = arg2;

	return ret;
}

if_statement new_if_statement(expression arg0, statement arg1, statement arg2)
{
	if_statement ret = (if_statement) malloc(sizeof(*ret));

	ret->arg0 = arg0;
	ret->arg1 = arg1;
	ret->arg2 = arg2;

	return ret;
}

call_statement new_call_statement(char *arg0, identifier arg1, expressions arg2)
{
	call_statement ret = (call_statement) malloc(sizeof(*ret));

	if (arg1 == NULL)
	{
		ret->u.arg0 = strdup(arg0);
	}
	else
	{
		ret->u.arg1 = arg1;
	}

	ret->arg2 = arg2;

	return ret;
}

fun_call new_fun_call(char *arg0, expressions arg1)
{
	fun_call ret = (fun_call) malloc(sizeof(*ret));

	ret->arg0 = strdup(arg0);
	ret->arg1 = arg1;

	return ret;
}

atomic_expression new_atomic_identifier(identifier arg0)
{
	atomic_expression ret = (atomic_expression) malloc(sizeof(*ret));

	ret->arg0 = arg0;

	return ret;
}

atomic_expression new_atomic_fun_call(fun_call arg0)
{
	atomic_expression ret = (atomic_expression) malloc(sizeof(*ret));

	ret->arg1 = arg0;

	return ret;
}

atomic_expression new_atomic_boolean(int arg0)
{
	atomic_expression ret = (atomic_expression) malloc(sizeof(*ret));

	ret->arg2 = arg0;

	return ret;
}