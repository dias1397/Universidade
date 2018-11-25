#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "ir.h"

int temp_t = 0;
int temp_fp = 0;
int labels = 0;

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

	temp_t = 0;
	temp_fp = 0;
	labels = 0;

	ir_fun_body(function_declaration->arg2);
}

void ir_fun_body(body body)
{
//	ir_local_decl(body->arg0);
	ir_statement(body->arg1);
	if (body->arg2->kind != EMPTY)
	{
		int t1 = ir_expression(body->arg2);
		type_ tipo = body->arg2->type->type;

		if (tipo == INT_)
		{
			printf("\ti_return t%d\n", t1);
		}
		if (tipo == REAL_)
		{
			printf("\tr_return fp%d\n", t1);
		}
	}
	else
	{
		printf("\treturn\n");
	}
	
}

int ir_expression(expression expression)
{
	if (expression->kind == BINOP)
	{
		int t1 = ir_expression(expression->u.binop.arg1);
		int t2 = ir_expression(expression->u.binop.arg2);
		
		return ir_oper_2(expression->u.binop.arg0, expression->type, t1, t2);

	} 
	if (expression->kind == UNOP)
	{
		int t1 = ir_expression(expression->u.unop.arg1);

		return ir_oper_1(expression->u.unop.arg0, expression->type, t1);

	}
	if (expression->kind == LITERAL)
	{
		return ir_literal(expression->u.literal.arg0, expression->type);
	}
	if (expression->kind == ATOMIC)
	{
		return ir_atomic(expression->u.atomic.arg0, expression->type);
	}
	return -1;
}

int ir_expressions(expressions expressions)
{
	int temp1 = ir_expression(expressions->arg0);
	/*if (expressions->arg1 != NULL)
	{
		int temp2 = ir_expressions(expressions->arg1);
	printf("%d\n", temp2);
		return temp2;
	}*/
	return temp1;
}

int ir_literal(literal literal, type type)
{
	if (type->type == INT_)
	{
		printf("\tt%d <- i_value %d\n", temp_t, literal->u.int_.arg0);
		return temp_t++;
	}
	else if (type->type == REAL_)
	{
		printf("\tfp%d <- r_value %.1f\n", temp_fp, literal->u.real_.arg1);
		return temp_fp++;
	}

	return -1;
}

int ir_atomic(atomic_expression atomic_expression, type type)
{
	if (atomic_expression->arg0 != NULL)
	{
		return ir_identifier(atomic_expression->arg0, type);
	}
	return -1;
}

int ir_identifier(identifier identifier, type type)
{
	if (type->type == INT_)
	{
		if (identifier->arg1->kind == VAR_)
		{
			printf("\tt%d <- i_gload @%s\n", temp_t, identifier->arg0);
			return temp_t++;
		}
		if (identifier->arg1->kind == LOCAL_)
		{
			printf("\tt%d <- i_lload @%s\n", temp_t, identifier->arg0);
			return temp_t++;
		}
		if (identifier->arg1->kind == ARG_)
		{
			printf("\tt%d <- i_aload @%s\n", temp_t, identifier->arg0);
			return temp_t++;
		}
	}
	if (type->type == REAL_)
	{
		if (identifier->arg1->kind == VAR_)
		{
			printf("\tfp%d <- r_gload @%s\n", temp_fp, identifier->arg0);
			return temp_fp++;
		}
		if (identifier->arg1->kind == LOCAL_)
		{
			printf("\tfp%d <- r_lload @%s\n", temp_fp, identifier->arg0);
			return temp_fp++;
		}
		if (identifier->arg1->kind == ARG_)
		{
			printf("\tfp%d <- r_aload @%s\n", temp_fp, identifier->arg0);
			return temp_fp++;
		}
	}
	return -1;
}

int ir_oper_2(operator_two operator_two, type type, int tx, int ty)
{
	if (type->type == INT_)
	{
		switch (operator_two->op2)
		{
			case PLUS_ :
			{
				printf("\tt%d <- i_add t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			case MINUS_:
			{
				printf("\tt%d <- i_sub t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			case TIMES_:
			{
				printf("\tt%d <- i_mul t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			case DIV_  :
			{
				printf("\tt%d <- i_div t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			case MOD_  :
			{
				printf("\tt%d <- mod t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			default :
			{

			}
		}
	}
	else if (type->type == REAL_)
	{
		switch (operator_two->op2)
		{
			case PLUS_ :
			{
				printf("\tfp%d <- r_add fp%d fp%d\n", temp_fp, tx, ty);
				return temp_fp;
			}
			case MINUS_:
			{
				printf("\tfp%d <- r_sub fp%d fp%d\n", temp_fp, tx, ty);
				return temp_fp;
			}
			case TIMES_:
			{
				printf("\tfp%d <- r_mul fp%d fp%d\n", temp_fp, tx, ty);
				return temp_fp;
			}
			case DIV_:
			{
				printf("\tfp%d <- r_div fp%d fp%d\n", temp_fp, tx, ty);
				return temp_fp;
			}
			default :
			{

			}
		}
	}
	else
	{
		switch (operator_two->op2)
		{
			case EQ_   :
			{
				printf("\tt%d <- i_eq t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			case NE_   :
			{
				printf("\tt%d <- i_eq t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			case LT_   :
			{
				printf("\tt%d <- i_lt t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			case GT_   :
			{
				printf("\tt%d <- i_lt t%d t%d\n", temp_t, ty, tx);
				return temp_t;
			}
			case LE_   :
			{
				printf("\tt%d <- i_lt t%d t%d\n", temp_t, ty, tx);
				return temp_t;
			}
			case GE_   :
			{
				printf("\tt%d <- i_lt t%d t%d\n", temp_t, tx, ty);
				return temp_t;
			}
			default :
			{

			}
		}
	}

	return -1;
}

int ir_oper_1(operator_one operator_one, type type, int tx)
{
	switch (operator_one->op1)
	{
		case TOREAL_ :
		{
			printf("\tfp%d <- itor t%d\n", temp_fp, tx);
			return temp_fp;	
		}
		default :
		{

		}
	}

	return -1;
}

void ir_statement(statement statement)
{
	if (statement->kind == ASSIGN_)
	{
		ir_assign(statement->u.assign_.arg0, statement->u.assign_.arg1);
	}
	else if (statement->kind == CALL_)
	{
		ir_call_stmt(statement->u.call_.arg0);
	}
	else if (statement->kind == PRINT_)
	{
		int temp = ir_expression(statement->u.print_.arg0);
		printf("\tr_print fp%d\n", temp);
	}
	else if (statement->kind == STMTS_)
	{
		ir_statements(statement->u.compound_.arg0);
	}
}

void ir_call_stmt(call_statement call_statement)
{
	int temp = ir_expressions(call_statement->arg2);

	printf("\tcall @%s, [fp%d]\n", call_statement->u.arg0, temp);
} 

void ir_statements(statements statements)
{
	ir_statement(statements->arg0);
	if (statements->arg1 != NULL)
	{
		ir_statements(statements->arg1);
	}
}

void ir_assign(identifier identifier, expression expression)
{
	int temp = ir_expression(expression);

	if (expression->type->type == INT_)
	{
		switch (identifier->arg1->kind)
		{
			case VAR_  :
			{
				printf("\t@%s <- i_gstore t%d\n", identifier->arg0, temp);
				break;
			}
			case LOCAL_:
			{
				printf("\t@%s <- i_lstore t%d\n", identifier->arg0, temp);
				break;
			}
			case ARG_  :
			{
				printf("\t@%s <- i_astore t%d\n", identifier->arg0, temp);
				break;
			}
		}
	}

	if (expression->type->type == REAL_)
	{
		switch (identifier->arg1->kind)
		{
			case VAR_:
			{
				printf("\t@%s <- r_gstore fp%d\n", identifier->arg0, temp);
				break;
			}
			case LOCAL_:
			{
				printf("\t@%s <- r_lstore fp%d\n", identifier->arg0, temp);
				break;
			}
			case ARG_  :
			{
				printf("\t@%s <- r_astore fp%d\n", identifier->arg0, temp);
				break;
			}
		}
	}

}