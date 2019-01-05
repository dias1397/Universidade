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
		ret->u.multi.preamble = arg1;
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

	ret->kind = full_fa;

	ret->formal_arg = arg0;
	ret->formal_args = arg1;

	return ret;
}

formal_args no_formal_args()
{
	formal_args ret = (formal_args) malloc(sizeof(*ret));

	ret->kind = empty_fa;

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

	ret->kind = full_lv;

	ret->local_var = arg0;
	ret->local_vars = arg1;

	return ret;
}

local_vars no_local_vars()
{
	local_vars ret = (local_vars) malloc(sizeof(*ret));

	ret->kind = empty_lv;

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

literal new_int_literal(int arg0)
{
	literal ret = (literal) malloc(sizeof(*ret));

	ret->kind = intlit_;
	ret->u.int_literal = arg0;

	return ret;
}

literal new_bool_literal(int arg0)
{
	literal ret = (literal) malloc(sizeof(*ret));

	ret->kind = boollit_;
	ret->u.bool_literal = arg0;

	return ret;
}

functions new_functions(ir_function arg0, functions arg1)
{
	functions ret = (functions) malloc(sizeof(*ret));

	if (arg1 == NULL)
	{
		ret->kind = single_fun;
		ret->u.single.ir_function = arg0;
	}
	else
	{
		ret->kind = multi_fun;
		ret->u.multi.ir_function = arg0;
		ret->u.multi.functions = arg1;
	}

	return ret;
}

ir_function new_ir_function(char *arg0, instructions arg1)
{
	ir_function ret = (ir_function) malloc(sizeof(*ret));

	ret->identifier = arg0;
	ret->instructions = arg1;

	return ret;
}

instructions new_instructions(instruction arg0, instructions arg1)
{
	instructions ret = (instructions) malloc(sizeof(*ret));

	if (arg1 == NULL)
	{
		ret->kind = single_inst;
		ret->u.single.instruction = arg0;
	}
	else
	{
		ret->kind = multi_inst;
		ret->u.multi.instruction = arg0;
		ret->u.multi.instructions = arg1;
	}

	return ret;
}

instruction new_binop_instruction(char *arg0, operation arg1, char *arg2, char *arg3)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = binop_;
	ret->u.binop.temporarie1 = arg0;
	ret->u.binop.operation = arg1;
	ret->u.binop.temporarie2 = arg2;
	ret->u.binop.temporarie3 = arg3;

	return ret;
}

instruction new_unop_instruction(char *arg0, operation arg1, char *arg2)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = unop_;
	ret->u.unop.temporarie1 = arg0;
	ret->u.unop.operation = arg1;
	ret->u.unop.temporarie2 = arg2;

	return ret;
}

instruction new_value_instruction(char *arg0, literal arg1)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = value_;
	ret->u.value.temporarie1 = arg0;
	ret->u.value.literal = arg1;

	return ret;
}

instruction new_load_instruction(char *arg0, load arg1, char *arg2)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = load_;
	ret->u.load.temporarie1 = arg0;
	ret->u.load.load = arg1;
	ret->u.load.identifier = arg2;

	return ret;
}

instruction new_store_instruction(char *arg0, store arg1, char *arg2)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = store_;
	ret->u.store.identifier = arg0;
	ret->u.store.store = arg1;
	ret->u.store.temporarie1 = arg2;
	
	return ret;
}

instruction new_jump_instruction(char *arg0)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = jump_;
	ret->u.jump.label = arg0;
	
	return ret;
}

instruction new_cjump_instruction(char *arg0, char *arg1, char *arg2)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = cjump_;
	ret->u.cjump.temporarie1 = arg0;
	ret->u.cjump.label1 = arg1;
	ret->u.cjump.label2 = arg2;
	
	return ret;
}

instruction new_icall_instruction(char *arg0, char *arg1, args arg2)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = icall_;
	ret->u.icall.temporarie1 = arg0;
	ret->u.icall.identifier = arg1;
	ret->u.icall.args = arg2;
	
	return ret;
}

instruction new_call_instruction(char *arg0, args arg1)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = call_;
	ret->u.call.identifier = arg0;
	ret->u.call.args = arg1;
	
	return ret;
}

instruction new_return_instruction(int type, char *arg0)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = return_;

	if (type == 0)
	{
		ret->u.ret.ret_type = iret_;
		ret->u.ret.temporarie1 = arg0;
	}
	else if (type == 1)
	{
		ret->u.ret.ret_type = ret_;
		ret->u.ret.temporarie1 = arg0;
	}
	else
	{
		ret->u.ret.ret_type = voidret_;
		ret->u.ret.temporarie1 = NULL;
	}
	
	return ret;
}

instruction new_print_instruction(char *arg0)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = print_;
	ret->u.print.temporarie1 = arg0;
	
	return ret;
}

instruction new_label_instruction(char *arg0, instruction arg1)
{
	instruction ret = (instruction) malloc(sizeof(*ret));

	ret->kind = label_;
	ret->u.label.label1 = arg0;
	ret->u.label.instruction = arg1;
	
	return ret;
}

operation new_operation(operation_ arg0)
{
	operation ret = (operation) malloc(sizeof(*ret));

	ret->kind = arg0;

	return ret;
}

load new_load(load_type_ arg0)
{
	load ret = (load) malloc(sizeof(*ret));

	ret->kind = arg0;

	return ret;
}

store new_store(store_type_ arg0)
{
	store ret = (store) malloc(sizeof(*ret));

	ret->kind = arg0;

	return ret;
}

arg new_arg(char *arg0)
{
	arg ret = (arg) malloc(sizeof(*ret));

	ret->temporarie1 = arg0;

	return ret;
}

args new_args(arg arg0, more_args arg1)
{
	args ret = (args) malloc(sizeof(*ret));

	ret->kind = full_args;

	ret->arg = arg0;
	ret->more_args = arg1;

	return ret;
}

args no_args()
{
	args ret = (args) malloc(sizeof(*ret));

	ret->kind = empty_args;

	return ret;
}

more_args new_more_args(arg arg0, more_args arg1)
{
	more_args ret = (more_args) malloc(sizeof(*ret));

	ret->kind = full_margs;

	ret->arg = arg0;
	ret->more_args = arg1;

	return ret;
}

more_args no_more_args()
{
	more_args ret = (more_args) malloc(sizeof(*ret));

	ret->kind = empty_margs;

	return ret;
}