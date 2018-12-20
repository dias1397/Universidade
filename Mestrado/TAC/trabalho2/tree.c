#include "tree.h"

preamble new_preamble(global_symbol arg0, preamble arg1)
{
	preamble ret = (preamble) malloc(sizeof(*ret));

	if (arg1 == NULL)
	{
		ret->kind = single;
		ret->u.single.global_symbol = arg0;
	}
	else
	{
		ret->kind = multi;
		ret->u.multi.global_symbol = arg0;
		ret->u.multi.preamble arg1;
	}

	return ret;
}

global_symbol new_global_symbol(variable_declaration arg0, function_declaration arg1)
{
	global_symbol ret = (global_symbol) malloc(sizeof(*ret));

	if (arg0 == NULL)
	{
		ret->kind = fun;
		ret->u.function_declaration = arg1;
	}
	else
	{
		ret->kind = var;
		ret->u.variable_declaration = arg0;
	}

	return ret;
}

variable_declaration new_variable_declaration(char *arg0, type arg1, literal arg2)
{
	variable_declaration ret = (variable_declaration) malloc(sizeof(*ret));

	ret->identifier = arg0;

	if (arg2 == NULL)
	{
		ret->kind = empty;
		ret->u.empty.type = arg1;
	}
	else
	{
		ret->kind = init;
		ret->u.init.type = arg1;
		ret->u.init.literal = arg2;
	}

	return ret;
}

function_declaration new_function_declaration(char *arg0, type arg1, formal_args arg2, local_vars arg3)
{
	function_declaration ret = (function_declaration) malloc(sizeof(*ret));

	ret->identifier = arg0;
	ret->type = arg1;
	ret->formal_args = arg2;
	ret->local_vars = arg3;

	return ret;
}

formal_args new_formal_args(formal_arg arg0, formal_args arg1)
{
	formal_args ret = (formal_args) malloc(sizeof(*ret));

	ret->formal_arg arg0;
	ret->formal_args arg1;

	return ret;
}

formal_arg new_formal_arg(type arg0, char *arg1)
{
	formal_arg ret = (formal_arg) malloc(sizeof(*ret));

	ret->type = arg0;
	ret->identifier = arg1;

	return ret;
}

local_vars new_local_vars(local_var arg0, local_vars arg1)
{
	local_vars ret = (local_vars) malloc(sizeof(*ret));

	ret->local_var arg0;
	ret->local_vars arg1;

	return ret;
}

local_var new_local_var(type arg0, char *arg1)
{
	local_var ret = (local_var) malloc(sizeof(*ret));

	ret->type = arg0;
	ret->identifier = arg1;

	return ret;
}

type new_type(type_ arg0)
{
	type ret = (type) malloc(sizeof(*ret));

	ret->kind = arg0;

	return ret;
}

