#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "mips.h"

int data = 0;
int text = 0;

void mips(preamble preamble, functions functions)
{
	printf("\n::MIPS start::\n");

	if (preamble != NULL)
	{
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
	printf("::Preamble start::\n");

	if (preamble->kind == single)
	{
		mips_global_symbol(preamble->u.single.global_symbol);
	}
	else if (preamble->kind == multi)
	{
		mips_global_symbol(preamble->u.multi.global_symbol);
		mips_preamble(preamble->u.multi.preamble);
	}

	printf("::Preamble end::\n");
}

void mips_global_symbol(global_symbol global_symbol)
{
	printf("::Global Symbol start::\n");
	if (global_symbol->kind == var)
	{
		if (data == 0)
		{
			printf("\t\t.data\n");
			data = 1;
		}
		mips_variable_decl(global_symbol->u.variable_declaration);
	}
	else if (global_symbol->kind == fun)
	{
		if (text == 0)
		{
			printf("\t\t.text\n");
			text = 1;
		}
		mips_function_decl(global_symbol->u.function_declaration);
	}
	printf("::Global Symbol end::\n");
}

void mips_variable_decl(variable_declaration variable_declaration)
{
	printf("::Variable Declaration start::\n");

	printf("::Variable Declaration end::\n");
}

void mips_function_decl(function_declaration function_declaration)
{
	printf("::Function Declaration start::\n");

	printf("::Function Declaration end::\n");
}

void mips_functions(functions functions)
{
	printf("::Functions start::\n");

	printf("::Functions end::\n");
}