#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "mips.h"

int text = 0;

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
	printf("::MIPS end::\n");
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
	printf("%s:", ir_function->identifier);

	mips_instructions(ir_function->instructions);
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
			printf("\taddu %s, %s, %s\n", temp1 ,temp2 ,temp3 );
		}
		else if (temp->kind == i_sub)
		{
			printf("\tsubu %s, %s, %s\n", temp1, temp2, temp3 );
		}
		else if (temp->kind == i_mul)
		{
			printf("\tmult %s, %s\n", temp2, temp3);
			printf("\tmflo %s\n", temp1 );
		}
		else if (temp->kind == i_div)
		{
			printf("\tdiv %s, %s\n", temp2, temp3);
			printf("\tmflo %s\n", temp1 );
		}
		else if (temp->kind == mod)
		{
			printf("\tdiv %s, %s\n", temp2, temp3);
			printf("\tmfhi %s\n", temp1 );
		}
		else if (temp->kind == i_eq)
		{
			printf("\tsubu %s, %s, %s\n", temp1, temp2, temp3);
			printf("\tsltiu %s, %s, 1\n", temp1, temp1);
		}
		else if (temp->kind == i_lt)
		{
			printf("\tslt %s, %s, %s\n", temp1, temp2, temp3);
		}
		else if (temp->kind == i_ne)
		{
			printf("\tsubu %s, %s, %s\n", temp1, temp2, temp3);
			printf("\tsltu %s, %0, %s\n", temp1, temp1);
		}
		else if (temp->kind == i_le)
		{
			printf("\tslt %s, %s, %s\n", temp1, temp2, temp3);
			printf("\txori %s, %s, 1\n", temp1, temp1);
		}
	}
	else if (instruction->kind == unop_)
	{
		operation temp = instruction->u.unop.operation;

		char *temp1 = instruction->u.binop.temporarie1;
		char *temp2 = instruction->u.binop.temporarie2;

		if (temp->kind == i_inv)
		{
			printf("\tsubu %s, $0, %s\n", temp1, temp2);
		}
		else if (temp->kind == _not)
		{
			printf("\txori %s, %s, 1\n", temp1, temp2);
		}
		else if (temp->kind == i_copy)
		{
			printf("\tadd %s, %s, $0\n", temp1, temp2);
		}
	}
	else if (instruction->kind == value_)
	{
		literal temp = instruction->u.value.literal;
		if (temp->kind == intlit_)
		{
			printf("\tori %s, $0, %d\n", instruction->u.value.temporarie1, temp->u.int_literal);
		}
		else if (temp->kind == boollit_)
		{
			printf("\tori %s, $0, %d\n", instruction->u.value.temporarie1, temp->u.bool_literal);
		}
	}
	else
	{
		printf("\tUNKNOWN INSTRUCTION\n");
	}
}