#include "ast.c"

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
	function_declaration ret = (variable_declaration) malloc(sizeof(*ret));

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

expressions new_expressions(expression arg0, expressions arg1);
expression new_expression_operation(operator arg0, expression arg1, expression arg2);
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
operator new_operator(op_ arg0);

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
body new_body(local_declarations arg0, statement arg1, expression arg2);
local_declarations new_local_declarations(local_declaration arg0, local_declarations arg1);
local_declaration new_local_declaration(char *arg0, type arg1, expression arg2);

if_statement new_if_statement(expression arg0, statement arg1, statement arg2);
call_statement new_call_statement(char *arg0, identifier arg1, expressions arg2);

fun_call new_fun_call(char *arg0, expressions arg1);
atomic_expression new_atomic_identifier(identifier arg0);
atomic_expression new_atomic_fun_call(fun_call arg0);
atomic_expression new_atomic_boolean(int arg0);