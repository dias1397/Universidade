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
	printf("function  @%s\n", remove_quotes(function_declaration->arg0));

	temp_t = 0;
	temp_fp = 0;
	labels = 0;

	ir_fun_body(function_declaration->arg2);
}

void ir_fun_body(body body)
{
	ir_local_decls(body->arg0);

	ir_statement(body->arg1);

	if (body->arg2->kind != EMPTY)
	{
		int t1 = ir_expression(body->arg2);
		type_ tipo = body->arg2->type->type;

		if (tipo == INT_)
		{
			printf("\ti_return t%d\n\n", t1);
		}
		if (tipo == REAL_)
		{
			printf("\tr_return fp%d\n\n", t1);
		}
	}
	else
	{
		printf("\treturn\n\n");
	}
	
}

void ir_local_decls(local_declarations local_declarations)
{
	if (local_declarations->arg0 != NULL && local_declarations->arg1 != NULL)
	{
		ir_local_decl(local_declarations->arg0);
		ir_local_decls(local_declarations->arg1);	
	}
}

void ir_local_decl(local_declaration local_declaration)
{
	int temp = ir_expression(local_declaration->arg2);

	if (temp == -1){
		return;
	}

	if (local_declaration->arg1->type == INT_)
	{
		printf("\t@%s <- i_lstore t%d\n", remove_quotes(local_declaration->arg0), temp);
		temp_t=temp+1;
	}
	else if (local_declaration->arg1->type == REAL_)
	{
		printf("\t@%s <- r_lstore fp%d\n", remove_quotes(local_declaration->arg0), temp);
		temp_fp=temp+1;;
	}
}


void ir_statement(statement statement)
{
	if (statement->kind == EMPTY_)
	{
		return;
	}
	else if (statement->kind == ASSIGN_)
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

		if (statement->u.print_.arg0->type->type == INT_)
		{
			printf("\ti_print t%d\n", temp);
		}
		else if (statement->u.print_.arg0->type->type == REAL_)
		{
			printf("\tr_print fp%d\n", temp);
		}
		else if (statement->u.print_.arg0->type->type == BOOL_)
		{
			printf("\tb_print t%d\n", temp);
		}	
	}
	else if (statement->kind == IF_)
	{
		ir_if_stmt(statement->u.if_.arg0);
	}
	else if (statement->kind == WHILE_)
	{
		ir_while(statement->u.while_.arg0, statement->u.while_.arg1);
	}
	else if (statement->kind == STMTS_)
	{
		ir_statements(statement->u.compound_.arg0);
	}
}

void ir_assign(identifier identifier, expression expression)
{
	int temp = ir_expression(expression);

	switch (identifier->arg1->kind)
	{
		case VAR_	:
		{
			if (expression->type->type == INT_ || expression->type->type == BOOL_)
			{
				printf("\t@%s <- i_gstore t%d\n", remove_quotes(identifier->arg0), temp);
				break;
			}
			else if (expression->type->type == REAL_)
			{
				printf("\t@%s <- r_gstore fp%d\n", remove_quotes(identifier->arg0), temp);
				break;
			}
		}
		case LOCAL_ :
		{
			if (expression->type->type == INT_ || expression->type->type == BOOL_)
			{
				printf("\t@%s <- i_lstore t%d\n", remove_quotes(identifier->arg0), temp);
				break;
			}
			else if (expression->type->type == REAL_)
			{
				printf("\t@%s <- r_lstore fp%d\n", remove_quotes(identifier->arg0), temp);
				break;
			}
		}
		case ARG_ 	:
		{
			if (expression->type->type == INT_ || expression->type->type == BOOL_)
			{
				printf("\t@%s <- i_astore t%d\n", remove_quotes(identifier->arg0), temp);
				break;
			}
			else if (expression->type->type == REAL_)
			{
				printf("\t@%s <- r_astore fp%d\n", remove_quotes(identifier->arg0), temp);
				break;
			}
		}

	}
}

void ir_call_stmt(call_statement call_statement)
{
	int temp = ir_expressions(call_statement->arg2);

	printf("TESTAR%s\n", call_statement->u.arg1->arg0);

	if (call_statement->arg2->arg0->type->type == INT_)
	{
		printf("\tcall @%s, [t%d]\n", remove_quotes(call_statement->u.arg0), temp);
		temp_t++;
	}
	else if (call_statement->arg2->arg0->type->type == REAL_)
	{
		printf("\tcall @%s, [fp%d]\n", remove_quotes(call_statement->u.arg0), temp);
		temp_fp++;
	}
} 


void ir_if_stmt(if_statement if_statement)
{
	int label1 = labels++;
	int label2 = labels++;
	int label3 = labels++;

	if (if_statement->arg0->u.binop.arg0->op2 == OR_)
	{
		int label4 = labels++;
		int t1 = ir_expression(if_statement->arg0->u.binop.arg1);
		printf("\tcjump t%d, l%d, l%d\n", t1, label1, label4);
		printf("l%d: ", label4);
		int t2 = ir_expression(if_statement->arg0->u.binop.arg2);
		printf("\tcjump t%d, l%d, l%d\n", t2, label1, label2);
		printf("l%d: ", label1);
		ir_statement(if_statement->arg1);
		printf("\tjump l%d\n", label3);
		printf("l%d: ", label2);
		ir_statement(if_statement->arg2);
		printf("l%d: ", label3);
	}
	else if (if_statement->arg0->u.binop.arg0->op2 == OR_)
	{
		int label4 = labels++;
		int t1 = ir_expression(if_statement->arg0->u.binop.arg1);
		printf("\tcjump t%d, l%d, l%d\n", t1, label1, label3);
		printf("l%d: ", label1);
		int t2 = ir_expression(if_statement->arg0->u.binop.arg2);
		printf("\tcjump t%d, l%d, l%d\n", t2, label2, label3);
		printf("l%d: ", label2);
		ir_statement(if_statement->arg1);
		printf("\tjump l%d\n", label4);
		printf("l%d: ", label3);
		ir_statement(if_statement->arg2);
		printf("l%d: ", label4);
	}
	else
	{
		int temp = ir_expression(if_statement->arg0);
		printf("\tcjump t%d, l%d, l%d\n", temp, label1, label2);
		printf("l%d: ", label1);
		ir_statement(if_statement->arg1);
		if (if_statement->arg2->kind == EMPTY_)
		{
			printf("l%d: ", label2);
			ir_statement(if_statement->arg2);
		}
		else
		{
			printf("\tjump l%d\n", label3);
			printf("l%d: ", label2);
			ir_statement(if_statement->arg2);
			printf("l%d: ", label3);
		}
	}

}

int ir_fun_call(fun_call fun_call)
{
	int temp = ir_expressions(fun_call->arg1);

	printf("\tt%d <- i_call @%s, [t%d]\n",temp_t, remove_quotes(fun_call->arg0), temp);
	return temp_t++;
}

void ir_while(expression expression, statement statement)
{
	int label1 = labels++;
	int label2 = labels++;
	int label3 = labels++;

	printf("l%d: ", label1);
	int temp = ir_expression(expression);
	printf("\tcjump t%d, l%d, l%d\n", temp, label2, label3);
	printf("l%d: ", label2);
	ir_statement(statement);
	printf("\tjump l%d\n", label1);
	printf("l%d: ", label3);
}

void ir_statements(statements statements)
{
	ir_statement(statements->arg0);
	if (statements->arg1 != NULL)
	{
		ir_statements(statements->arg1);
	}
}


int ir_expressions(expressions expressions)
{
	int temp1 = ir_expression(expressions->arg0);
	if (expressions->arg1 != NULL)
	{
		int temp2 = ir_expressions(expressions->arg1);
		return temp2;
	}
	return temp1;
}

int ir_expression(expression expression)
{
	if (expression->kind == BINOP)
	{
		if (expression->u.binop.arg0->op2 == OR_)
		{
			int label1 = labels++;
			int label2 = labels++;

			int t1 = ir_expression(expression->u.binop.arg1);
			printf("\tcjump t%d, l%d, l%d\n", t1, label1, label2);
			printf("l%d: ", label2);
			int t2 = ir_expression(expression->u.binop.arg2);
			printf("\tt%d <- i_copy t%d\n", t1, t2);
			printf("l%d: ", label1);

			return t1;
		}
		else if (expression->u.binop.arg0->op2 == AND_)
		{
			int label1 = labels++;
			int label2 = labels++;

			int t1 = ir_expression(expression->u.binop.arg1);
			printf("\tcjump t%d, l%d, l%d\n", t1, label1, label2);
			printf("l%d: ", label1);
			int t2 = ir_expression(expression->u.binop.arg2);
			printf("\tt%d <- i_copy t%d\n", t1, t2);
			printf("l%d: ", label2);

			return t1;
		}
		else
		{
			int t1 = ir_expression(expression->u.binop.arg1);
			int t2 = ir_expression(expression->u.binop.arg2);
			
			return ir_oper_2(expression->u.binop.arg0, expression->type, t1, t2);
		}

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

int ir_literal(literal literal, type type)
{
	if (type->type == INT_)
	{
		printf("\tt%d <- i_value %d\n", temp_t++, literal->u.int_.arg0);
		return temp_t-1;
	}
	else if (type->type == REAL_)
	{
		printf("\tfp%d <- r_value %.1f\n", temp_fp++, literal->u.real_.arg1);
		return temp_fp-1;
	}

	return -1;
}

int ir_atomic(atomic_expression atomic_expression, type type)
{
	if (atomic_expression->arg0 != NULL)
	{
		return ir_identifier(atomic_expression->arg0, type);
	}
	else if (atomic_expression->arg1 != NULL)
	{
		return ir_fun_call(atomic_expression->arg1);
	}
	else
	{
		printf("\tt%d <- i_value %d\n", temp_t++, atomic_expression->arg2);
		return temp_t-1;
	}
	return -1;
}


int ir_identifier(identifier identifier, type type)
{
	switch (identifier->arg1->kind)
	{
		case VAR_ 	:
		{
			if (type->type == INT_ || type->type == BOOL_)
			{
				printf("\tt%d <- i_gload @%s\n", temp_t, remove_quotes(identifier->arg0));
				return temp_t++;
			}
			else if (type->type == REAL_)
			{
				printf("\tfp%d <- r_gload @%s\n", temp_fp, remove_quotes(identifier->arg0));
				return temp_fp++;
			}
		}
		case LOCAL_ :
		{
			if (type->type == INT_ || type->type == BOOL_)
			{
				printf("\tt%d <- i_lload @%s\n", temp_t, remove_quotes(identifier->arg0));
				return temp_t++;
			}
			else if (type->type == REAL_)
			{
				printf("\tfp%d <- r_lload @%s\n", temp_fp, remove_quotes(identifier->arg0));
				return temp_fp++;
			}
		}
		case ARG_ 	:
		{
			if (type->type == INT_ || type->type == BOOL_)
			{
				printf("\tt%d <- i_aload @%s\n", temp_t, remove_quotes(identifier->arg0));
				return temp_t++;
			}
			else if (type->type == REAL_)
			{
				printf("\tfp%d <- r_aload @%s\n", temp_fp, remove_quotes(identifier->arg0));
				return temp_fp++;
			}
		}
	}

	return -1;
}

int ir_oper_2(operator_two operator_two, type type, int tx, int ty)
{
	switch (operator_two->op2)
	{
		case PLUS_ :
		{
			if (type->type == INT_)
			{
				printf("\tt%d <- i_add t%d, t%d\n", temp_t++, tx, ty);
				return temp_t-1;
			}
			else if (type->type == REAL_)
			{
				printf("\tfp%d <- r_add fp%d, fp%d\n", temp_fp++, tx, ty);
				return temp_fp-1;
			} 
		}
		case MINUS_:
		{
			if (type->type == INT_)
			{
				printf("\tt%d <- i_sub t%d, t%d\n", temp_t++, tx, ty);
				return temp_t-1;
			}
			else if (type->type == REAL_)
			{
				printf("\tfp%d <- r_sub fp%d, fp%d\n", temp_fp++, tx, ty);
				return temp_fp-1;
			} 
		}
		case TIMES_:
		{
			if (type->type == INT_)
			{
				printf("\tt%d <- i_mul t%d, t%d\n", temp_t++, tx, ty);
				return temp_t-1;
			}
			else if (type->type == REAL_)
			{
				printf("\tfp%d <- r_mul fp%d, fp%d\n", temp_fp++, tx, ty);
				return temp_fp-1;
			} 
		}
		case DIV_  :
		{
			if (type->type == INT_)
			{
				printf("\tt%d <- i_div t%d, t%d\n", temp_t++, tx, ty);
				return temp_t-1;
			}
			else if (type->type == REAL_)
			{
				printf("\tfp%d <- r_div fp%d, fp%d\n", temp_fp++, tx, ty);
				return temp_fp-1;
			} 
			
		}
		case MOD_  :
		{
			printf("\tt%d <- mod t%d, t%d\n", temp_t++, tx, ty);
			return temp_t-1;
		}
		case EQ_   :
		{
			printf("\tt%d <- i_eq t%d, t%d\n", temp_t++, tx, ty);
			return temp_t-1;
		}
		case NE_   :
		{
			printf("\tt%d <- i_eq t%d, t%d\n", temp_t++, tx, ty);
			return temp_t-1;
		}
		case LT_   :
		{
			printf("\tt%d <- i_lt t%d, t%d\n", temp_t++, tx, ty);
			return temp_t-1;
		}
		case GT_   :
		{
			printf("\tt%d <- i_lt t%d, t%d\n", temp_t++, ty, tx);
			return temp_t-1;
		}
		case LE_   :
		{
			printf("\tt%d <- i_lt t%d, t%d\n", temp_t++, ty, tx);
			return temp_t-1;
		}
		case GE_   :
		{
			printf("\tt%d <- i_lt t%d, t%d\n", temp_t++, tx, ty);
			return temp_t-1;
		}
		default :
		{
			printf("ERRO\n");
			return -1;
		}
	}
}

int ir_oper_1(operator_one operator_one, type type, int tx)
{
	switch (operator_one->op1)
	{
		case TOREAL_ :
		{
			printf("\tfp%d <- itor t%d\n", temp_fp++, tx);
			return temp_fp-1;	
		}
		case INV_ 	:
		{
			if (type->type == INT_)
			{
				printf("\tt%d <- i_inv t%d\n", temp_t++, tx);
				return temp_t-1;	
			}
			else if (type->type == REAL_)
			{
				printf("\tfp%d <- r_inv fp%d\n", temp_fp++, tx);
				return temp_fp-1;	
			}
		}
		case NOT_ 	:
		{
			printf("NOT\n");
			return -1;
		}
	}

	return -1;
}


char *remove_quotes(char *src)
{
	int length = strlen(src);
	char *dest = malloc(sizeof(char) * (length-2));

	memset(dest, '\0', sizeof(*dest));

	strncpy(dest, &src[1], length-2);

	return dest;
}