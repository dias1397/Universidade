#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "mips.h"

list stack_frame;
function current;

list new_list()
{
	list lista = (list) malloc(sizeof(*lista));

	lista->size = 0;
	lista->current = 0;

	return lista;
}

void insert(list list, function function)
{
	if (list->size == 0)
	{
		list->header = function;
		list->header->next = list->header;
	}
	else
	{
		function->next = list->header->next;
		list->header->next = function;
	}

	list->size++;
	list->current++;
}

function get_function(list list, int position)
{
	function ret = list->header->next;

	int i = 0;
	while (ret != NULL)
	{
		if (i == position)
			return ret;
		ret = ret->next;
		i++;
	}

	return NULL;
}

function new_function(formal_args f_args, local_vars l_vars)
{
	function fun = (function) malloc(sizeof(*fun));

	int args = 0;
	int vars = 0;

	if (f_args->kind != empty_fa)
	{

		fun->formal_args[args] = f_args->formal_arg->identifier;
		formal_args more_args = f_args->formal_args; 
		args++;

		while (more_args->kind != empty_fa)
		{
			fun->formal_args[args] = more_args->formal_arg->identifier;
			more_args = more_args->formal_args;
			args++;
		}

	}

	if (l_vars->kind != empty_lv)
	{
		fun->local_vars[vars] = l_vars->local_var->identifier;
		local_vars more_vars = l_vars->local_vars;
		vars++;

		while (more_vars->kind != empty_lv)
		{
			fun->local_vars[args] = more_vars->local_var->identifier;
			more_vars = more_vars->local_vars;
			args++;
		}
	}

	fun->nr_args = args;
	fun->nr_vars = vars;

	return fun;
}

void mips(preamble preamble, functions functions)
{
	printf("\n::MIPS start::\n");

	if (preamble != NULL)
	{
		if (preamble->kind == single)
		{
			if (preamble->u.single.global_symbol->kind == var)
			{
				printf("\t.data\n");
			}
		}
		else if (preamble->kind == multi)
		{
			if (preamble->u.multi.global_symbol->kind == var)
			{
				printf("\t.data\n");
			}
		}
		mips_preamble(preamble);
	}

	if (functions != NULL)
	{
		mips_functions(functions);
	}
	printf("\n::MIPS end::\n");
}

void mips_preamble(preamble preamble)
{
	//printf("::Preamble start::\n");

	if (preamble->kind == single)
	{
		mips_global_symbol(preamble->u.single.global_symbol);
	}
	else if (preamble->kind == multi)
	{
		mips_global_symbol(preamble->u.multi.global_symbol);
		mips_preamble(preamble->u.multi.preamble);
	}

	//printf("::Preamble end::\n");
}

void mips_global_symbol(global_symbol global_symbol)
{
	//printf("::Global Symbol start::\n");
	if (global_symbol->kind == var)
	{
		mips_variable_decl(global_symbol->u.variable_declaration);
	}
	else if (global_symbol->kind == fun)
	{
		mips_function_decl(global_symbol->u.function_declaration);
	}
	//printf("::Global Symbol end::\n");
}

void mips_variable_decl(variable_declaration variable_declaration)
{
	//printf("::Variable Declaration start::\n");

	printf("%s:\t", variable_declaration->identifier);

	if (variable_declaration->kind == empty)
	{
		printf(".space 4\n");
	}
	else if (variable_declaration->kind == init)
	{
		literal temp = variable_declaration->u.init.literal;
		if (temp->kind == intlit_)
		{
			printf(".word %d\n", temp->u.int_literal);
		}
		else if (temp->kind == boollit_)
		{
			printf(".word %d\n", temp->u.bool_literal);
		}
	}

	//printf("::Variable Declaration end::\n");
}

void mips_function_decl(function_declaration function_declaration)
{
	//printf("::Function Declaration start::\n");

	if (stack_frame == NULL)
	{
		stack_frame = new_list();
	}

	function fun = new_function(function_declaration->formal_args, function_declaration->local_vars);
	insert(stack_frame, fun);

	//printf("::Function Declaration end::\n");
}


void mips_functions(functions functions)
{
	//printf("::Functions start::\n");

	printf("\n\t.text\n");

	if (functions->kind == single_fun)
	{
		mips_function(functions->u.single.ir_function);
	}
	else if (functions->kind == multi_fun)
	{
		mips_function(functions->u.multi.ir_function);
		mips_functions(functions->u.multi.functions);
	}

	//printf("::Functions end::\n");
}

void mips_function(ir_function ir_function)
{
	printf("%s:\n", ir_function->identifier);

	current = get_function(stack_frame, stack_frame->current-1);
	stack_frame->current--;

	mips_prologue();
	mips_instructions(ir_function->instructions);
	mips_epilogue();
}

void mips_prologue()
{
	printf("\tsw\t $fp, -4($sp)\n");
	printf("\taddiu\t $fp, $sp, -4\n");
	printf("\tsw\t $ra, -4($fp)\n");
	printf("\taddiu\t $sp, $fp, -%d\n", ((current->nr_args)+(current->nr_vars))*4);
}

void mips_epilogue()
{
	printf("\tlw\t$ra, -4($fp)\n");
	printf("\taddiu\t$sp, $fp, %d\n", (current->nr_args)*4+4);
	printf("\tlw\t$fp, 0($fp)\n");
	printf("\tjr\t$ra\n");
}

void mips_instructions(instructions instructions)
{
	if (instructions->kind == single_inst)
	{
		mips_instruction(instructions->u.single.instruction);
	}
	else if (instructions->kind == multi_inst)
	{
		mips_instruction(instructions->u.multi.instruction);
		mips_instructions(instructions->u.multi.instructions);
	}
}

void mips_instruction(instruction instruction)
{
	if (instruction->kind == binop_)
	{
		operation temp = instruction->u.binop.operation;

		char *temp1 = instruction->u.binop.temporarie1;
		char *temp2 = instruction->u.binop.temporarie2;
		char *temp3 = instruction->u.binop.temporarie3;

		if (temp->kind == i_add)
		{
			printf("\taddu\t %s, %s, %s\n", temp1 ,temp2 ,temp3 );
		}
		else if (temp->kind == i_sub)
		{
			printf("\tsubu\t %s, %s, %s\n", temp1, temp2, temp3 );
		}
		else if (temp->kind == i_mul)
		{
			printf("\tmult\t %s, %s\n", temp2, temp3);
			printf("\tmflo\t %s\n", temp1 );
		}
		else if (temp->kind == i_div)
		{
			printf("\tdiv\t %s, %s\n", temp2, temp3);
			printf("\tmflo\t %s\n", temp1 );
		}
		else if (temp->kind == mod)
		{
			printf("\tdiv\t %s, %s\n", temp2, temp3);
			printf("\tmfhi\t %s\n", temp1 );
		}
		else if (temp->kind == i_eq)
		{
			printf("\tsubu\t %s, %s, %s\n", temp1, temp2, temp3);
			printf("\tsltiu\t %s, %s, 1\n", temp1, temp1);
		}
		else if (temp->kind == i_lt)
		{
			printf("\tslt\t %s, %s, %s\n", temp1, temp2, temp3);
		}
		else if (temp->kind == i_ne)
		{
			printf("\tsubu\t %s, %s, %s\n", temp1, temp2, temp3);
			printf("\tsltu\t %s, $0, %s\n", temp1, temp1);
		}
		else if (temp->kind == i_le)
		{
			printf("\tslt\t %s, %s, %s\n", temp1, temp2, temp3);
			printf("\txori\t %s, %s, 1\n", temp1, temp1);
		}
	}
	else if (instruction->kind == unop_)
	{
		operation temp = instruction->u.unop.operation;

		char *temp1 = instruction->u.binop.temporarie1;
		char *temp2 = instruction->u.binop.temporarie2;

		if (temp->kind == i_inv)
		{
			printf("\tsubu\t %s, $0, %s\n", temp1, temp2);
		}
		else if (temp->kind == _not)
		{
			printf("\txori\t %s, %s, 1\n", temp1, temp2);
		}
		else if (temp->kind == i_copy)
		{
			printf("\tadd\t %s, %s, $0\n", temp1, temp2);
		}
	}
	else if (instruction->kind == value_)
	{
		literal temp = instruction->u.value.literal;
		if (temp->kind == intlit_)
		{
			printf("\tori\t %s, $0, %d\n", instruction->u.value.temporarie1, temp->u.int_literal);
		}
		else if (temp->kind == boollit_)
		{
			printf("\tori\t %s, $0, %d\n", instruction->u.value.temporarie1, temp->u.bool_literal);
		}
	}
	else if (instruction->kind == load_)
	{
		load temp = instruction->u.load.load;

		char *temp1 = instruction->u.load.temporarie1;
		char *identifier = instruction->u.load.identifier;

		if (temp->kind == gload_)
		{
			
		}
		else if (temp->kind == lload_)
		{
			int i = 0;
			while (strcmp(identifier, current->local_vars[i]) != 0)
				i++;

			printf("\tlw\t %s, %d($fp)\n", temp1, (i+2)*-4);
		}
		else if (temp->kind == aload_)
		{
			int i = 0;
			while (strcmp(identifier, current->formal_args[i]) != 0)
				i++;

			printf("\tlw\t %s, %d($fp)\n", temp1, (i+1)*4);
		}
	}
	else if (instruction->kind == store_)
	{
		store temp = instruction->u.store.store;

		char *temp1 = instruction->u.store.temporarie1;
		char *identifier = instruction->u.store.identifier;

		if (temp->kind == gstore_)
		{
			
		}
		else if (temp->kind == lstore_)
		{
			int i = 0;
			while (strcmp(identifier, current->local_vars[i]) != 0)
				i++;

			printf("\tsw\t %s, %d($fp)\n", temp1, (i+2)*-4);
		}
		else if (temp->kind == astore_)
		{
			int i = 0;
			while (strcmp(identifier, current->formal_args[i]) != 0)
				i++;

			printf("\tsw\t %s, %d($fp)\n", temp1, (i+1)*4);
		}
	}
	else if (instruction->kind == jump_)
	{
		printf("\tj\tl$%s\n", instruction->u.jump.label);
	}
	else if (instruction->kind == cjump_)
	{
		char *temp1 = instruction->u.cjump.temporarie1;
		char *label1 = instruction->u.cjump.label1;
		char *label2 = instruction->u.cjump.label2;

		printf("\tbeq\t%s, $0, %s\n", temp1, label2);
		printf("\tj\t%s\n", label1);
	}
	else if (instruction->kind == icall_)
	{
		mips_args(instruction->u.icall.args);

		printf("\tjal %s\n", instruction->u.icall.identifier);
		printf("\tor\t %s, $0, $v0\n", instruction->u.icall.temporarie1);
	}
	else if (instruction->kind == call_)
	{
		mips_args(instruction->u.call.args);

		printf("\tjal %s\n", instruction->u.call.identifier);
	}
	else if (instruction->kind == return_)
	{
		char *temp1 = instruction->u.ret.temporarie1;

		if (instruction->u.ret.ret_type == iret_)
		{
			printf("\tor\t $v0, $0, %s\n", temp1);
		}
	}
	else if (instruction->kind == print_)
	{
		printf("\ti_print$ %s\n", instruction->u.print.temporarie1);
	}
	else if (instruction->kind == label_)
	{
		printf("%s:", instruction->u.label.label1);

		mips_instruction(instruction->u.label.instruction);
	}
	else
	{
		printf("\tUNKNOWN INSTRUCTION\n");
	}
}

void mips_args(args args)
{
	if (args->kind == full_args)
	{
		mips_arg(args->arg);
	}

	more_args m_args = args->more_args;

	while(m_args->kind != empty_margs)
	{
		mips_arg(m_args->arg);
		m_args = m_args->more_args;
	}
}

void mips_arg(arg arg)
{
	printf("\taddiu\t $sp, $sp, -4\n");
	printf("\tsw\t%s, 0($sp)\n", arg->temporarie1);
}