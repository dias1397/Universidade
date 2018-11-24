#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "ir.h"

int temp = 0;

void ir(global_declarations global_declarations)
{
	ir_global_decls(global_declarations);
}

void ir_global_decls(global_declarations global_declarations)
{
	if (global_declarations == NULL)
	{
		return ;
	}
	else
	{
		ir_global_decl(global_declarations->u.multi_decl.arg0);
		ir_global_decls(global_declarations->u.multi_decl.arg1);
	}
}

void ir_global_decl(global_declaration global_declaration)
{
	if (global_declaration->kind == fun)
	{
		ir_fun_decl(global_declaration->u.fun_decl.arg1);
	}
}

void ir_fun_decl(function_declaration function_declaration)
{
	printf("\n");
	printf("function @%s\n", function_declaration->arg0);

	ir_fun_body(function_declaration->arg2);
}

void ir_fun_body(body body)
{
//	ir_local_decl(body->arg0);
//	ir_statement(body->arg1);
	ir_expression(body->arg2);

	if (body->arg2->u.binop.arg3->type == INT_)
	{
		printf("i_return t%d\n", temp);
	}
}

void ir_expression(expression expression)
{
	if (expression->kind == BINOP)
	{
		ir_expression(expression->u.binop.arg1);
		ir_expression(expression->u.binop.arg2);
		
		ir_oper_2(expression->u.binop.arg0, expression->u.binop.arg3);
	} 

	if (expression->kind == LITERAL)
	{
		ir_literal(expression->u.literal.arg0, expression->u.literal.arg1);
	}
	if (expression->kind == ATOMIC)
	{
		ir_atomic(expression->u.atomic.arg0, expression->u.atomic.arg1);
	}
}

void ir_literal(literal literal, type type)
{
	if (type->type == INT_)
	{
		printf("t%d <- i_value %d\n", temp, literal->u.int_.arg0);
		temp++;
	}
}

void ir_atomic(atomic_expression atomic_expression, type type)
{
	if (atomic_expression->arg0 != NULL)
	{
		ir_identifier(atomic_expression->arg0, type);
	}
}

void ir_identifier(identifier identifier, type type)
{
	if (type->type == INT_)
	{
		if (identifier->arg1->kind == ARG_)
		{
			printf("t%d <- i_aload %s\n", temp, identifier->arg0);
			temp++;
		}
	}
}

void ir_oper_2(operator_two operator_two, type type)
{
	if (type->type == INT_)
	{
		if (operator_two->op2 == TIMES_)
		{
			printf("t%d <- i_mul t%d t%d\n", temp, temp-1, temp-2 );
		}
	}
}