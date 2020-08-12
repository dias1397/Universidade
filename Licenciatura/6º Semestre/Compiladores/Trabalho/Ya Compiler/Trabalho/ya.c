#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#include "ya.h"

struct calc_t_decls {
	enum {
		DECLS_ONE,
		DECLS_MULTI
	} kind;
	
	union {
		calc_t_decl decl;
		calc_t_decls decls;
	} u;
};
struct calc_t_decl {
	enum {
		DECL_VAR,
		DECL_VAR_INIT,
		DECL_FUNC,
		DECL_FUNC_ARGS,
		DECL_DEFINE
	} kind;

	union {
		calc_t_ids ids;
		calc_t_type type;
		calc_t_exp exp;
		calc_t_stms stms;
		calc_t_argdefs arg;
		char* id;
	} u;
};

struct calc_t_stms {
	enum {
		STMS_ONE,
		STMS_MULTI
	} kind;

	union {
		calc_t_stm stm;
		calc_t_stms stms;
	} u;
};
struct calc_t_stm {
	enum {
		STM_DECL,
		STM_ID,
		STM_ID_ASSIGN,
		STM_RETURN,
		STM_BREAK,
		STM_NEXT,
		STM_IF_THEN,
		STM_IF_THEN_ELSE,
		STM_WHILE,
		STM_PRINT,
		STM_INPUT
	} kind;

	union {
		calc_t_decl decl;
		calc_t_exp exp;
		calc_t_stms stms;
		calc_t_stms stms_else;
		char* id;
	} u;
};

struct calc_t_argdefs {
	enum {
		ARGDEFS_ONE,
		ARGDEFS_MULTI
	} kind;

	union {
		calc_t_argdef argdef;
		calc_t_argdefs argdefs;
	} u;
};
struct calc_t_argdef {
	enum {
		ÃRGDEF
	} kind;

	union {
		calc_t_type type;
	} u;
};

struct calc_t_exp {
	enum {
		EXP_ID,
		EXP_LIT,
		EXP_BINOP,
		EXP_UNOP,
		EXP_PAR,
		EXP_ASSIGN
	}kind;

	union {
		char *id;
		calc_t_lit lit;
		struct {
			char op[3];
			calc_t_exp arg1;
			calc_t_exp arg2;
		} binop;
		struct {
			char op[3];
			calc_t_exp arg;
		} unop;
		calc_t_exp par;
	} u;
};

struct calc_t_type {
	enum {
		TYPE_INT,
		TYPE_FLOAT,
		TYPE_STRING,
		TYPE_BOOL,
		TYPE_VOID,
		TYPE_ARRAY
	} kind;

	union {
		calc_t_type type;
		int lint;
	} u;
};
struct calc_t_ids {
	enum {
		ID,
		IDS
	} kind;

	union {
		calc_t_ids ids;
		char* id;
	} u;
};
struct calc_t_literal {
	enum {
		LIT_INT,
		LIT_FLOAT,
		LIT_STRING,
		LIT_BOOL
	} kind;

	union {
		struct {
			int arg;
		} lint;
		struct {
			float arg;
		} lfloat;
		struct {
			char* arg;
		} lstring;
	} u;
};

// DECLS
calc_t_decls calc_decls_new_one(calc_t_decl arg1)
{
	calc_t_decls ret = (calc_t_decls) malloc(sizeof (*ret));

	ret->kind = DECLS_ONE;
	ret->u.decl = arg1;

	return ret;
}
calc_t_decls calc_decls_new_multi(calc_t_decl arg1, calc_t_decls arg2)
{
	calc_t_decls ret = (calc_t_decls) malloc(sizeof (*ret));

	ret->kind = DECLS_MULTI;
	ret->u.decl = arg1;
	ret->u.decls = arg2;

	return ret;
}
// DECL
calc_t_decl calc_decl_new_var(calc_t_ids arg1, calc_t_type arg2, calc_t_exp arg3)
{
	calc_t_decl ret = (calc_t_decl) malloc(sizeof (*ret));

	if (arg3 == null)
	{		
		ret->kind = DECL_VAR;
		ret->u.ids = arg1;
		ret->u.type = arg2;
	}
	else
	{
		ret->kind = DECL_VAR_INIT;
		ret->u.ids = arg1;
		ret->u.type = arg2;
		ret->u.exp = arg3;
	}

	return ret;
}
calc_t_decl calc_decl_new_func(calc_t_argdefs arg1, calc_t_type arg2, calc_t_stms arg3, char* arg4)
{
	calc_t_decl ret = (calc_t_decl) malloc(sizeof (*ret));

	if (arg1 == null)
	{
		ret->kind = DECL_FUNC;
		ret->u.type = arg2;
		ret->u.stms = arg3;
		ret->u.id = arg4;
	}
	else
	{
		ret->kind = DECL_FUNC_ARGS;
		ret->u.arg = arg1;
		ret->u.type = arg2;
		ret->u.stms = arg3;
		ret->u.id = arg4;
	}

	return ret;
}
calc_t_decl calc_decl_new_define(calc_t_type arg1, char* arg2)
{
	calc_t_decl ret = (calc_t_decl) malloc(sizeof (*ret));

	ret->kind = DECL_DEFINE;
	ret->u.type = arg1;
	ret->u.id = arg2;

	return ret;
}

// STMS
calc_t_stms calc_stms_new_one(calc_t_stm arg1)
{
	calc_t_stms ret = (calc_t_stms) malloc(sizeof (*ret));

	ret->kind = STMS_ONE;
	ret->u.stm = arg1;

	return ret;
}
calc_t_stms calc_stms_new_multi(calc_t_stm arg1, calc_t_stms arg2)
{
	calc_t_stms ret = (calc_t_stms) malloc(sizeof (*ret));

	ret->kind = STMS_MULTI;
	ret->u.stm = arg1;
	ret->u.stms = arg2;

	return ret;
}
// STM
calc_t_stm calc_stm_new_decl(calc_t_decl arg1)
{
	calc_t_stm ret = (calc_t_stm) malloc(sizeof (*ret));

	ret->kind = STMS_DECL;
	ret->u.decl = arg1;

	return ret;
}
calc_t_stm calc_stm_new_stm(int arg0, calc_t_exp arg1, char* arg2)
{
	calc_t_stm ret = (calc_t_stm) malloc(sizeof (*ret));

	ret->kind = arg0;
	ret->u.exp = arg1;
	if (arg2 != null)
	{
		ret->u.id = arg2;
	}

	return ret;
}
calc_t_stm calc_stm_new_cycle(int arg0, calc_t_exp arg1, calc_t_stms arg2, calc_t_stms arg3)
{
	calc_t_stm ret = (calc_t_stm) malloc(sizeof (*ret));

	ret->kind = arg0;
	ret->u.exp = arg1;
	ret->u.stms = arg2;
	if (arg3 != null)
	{
		ret->u.stms_else = arg3;
	}

	return ret;
}

// ARGDEFS
calc_t_argdefs calc_argdefs_new_one(calc_t_argdef arg1)
{
	calc_t_argdefs ret = (calc_t_argdefs) malloc(sizeof (*ret));

	ret->kind = ARGDEFS_ONE;
	ret->u.argdef = arg1;

	return ret;
}
calc_t_argdefs calc_argdefs_new_multi(calc_t_argdef arg1, calc_t_argdefs arg2)
{
	calc_t_argdefs ret = (calc_t_argdefs) malloc(sizeof (*ret));

	ret->kind = ARGDEFS_MULTI;
	ret->u.argdef = arg1;
	ret->u.argdefs = arg2;

	return ret;
}
//ARGDEF
calc_t_argdef calc_argdef(calc_t_type arg1)
{
	calc_t_argdef ret= (calc_t_argdef) malloc(sizeof (*ret));

	ret->kind = ARGDEF;
	ret->u.type = arg1;

	return ret;
}

// EXP
calc_t_exp calc_exp_new_id(char *id) 
{
	calc_t_exp ret = (calc_t_exp) malloc(sizeof (*ret));

	ret->kind = EXP_ID;
	ret->u.id = id;

	return ret;
}
calc_t_exp calc_exp_new_literal(calc_t_lit arg1)
{
	calc_t_exp ret = (calc_t_exp) malloc(sizeof (*ret));

	ret->kind = EXP_LIT;
	ret->u.lit = arg1;

	return ret;
}
calc_t_exp calc_exp_new_binop(char op[], calc_t_exp arg1, calc_t_exp arg2)
{
	calc_t_exp ret = (calc_t_exp) malloc(sizeof (*ret));

	ret->kind = EXP_BINOP;
	strncpy(ret->u.binop.op, op, 2);
	ret->u.binop.arg1 = arg1;
	ret->u.binop.arg2 = arg2;

	return ret;
}
calc_t_exp calc_exp_new_unop(char op[], calc_t_exp arg1)
{
	calc_t_exp ret = (calc_t_exp) malloc(sizeof (*ret));

	ret->kind = EXP_UNOP;
	strncpy(ret->u.unop, op, 2);
	ret->u.unop.arg = arg1;

	return ret;
}
calc_t_exp calc_exp_new_par(calc_t_exp arg1)
{
	calc_t_exp ret = (calc_t_exp) malloc(sizeof (*ret));

	ret->kind = EXP_PAR;
	ret->u.par = arg1;

	return ret;
}

// TYPE
calc_t_type calc_type(int arg0, calc_t_type arg1, int arg2)
{
	calc_t_type ret = (calc_t_type) malloc(sizeof (*ret));

	ret->kind = arg0;

	if (arg1 != null)
	{
		ret->u.type = arg1;
	}

	if (arg2 != null)
	{
		ret->u.lint = arg2;
	}

	return ret;
}
// IDS
calc_t_ids calc_ids(calc_t_ids arg1, char* arg2)
{
	calc_t_ids ret = (calc_t_ids) malloc(sizeof (*ret));

	if (arg1 == null)
	{
		ret->kind = ID;
		ret->u.id = arg2;
	}
	else
	{
		ret->kind = IDS;
		ret->u.ids = arg1;
		ret->u.id = arg2;
	}

	return ret;
}
// LITERAL
calc_t_literal calc_literal(int arg0, int arg1, float arg2, char* arg3)
{
	calc_t_literal ret = (calc_t_literal) malloc(sizeof(*ret));

	ret->kind = arg0;

	if (arg1 != null)
	{
		ret->u.lint.arg = arg1;
	}
	if (arg2 != null)
	{
		ret->u.lfloat.arg = arg2;
	}
	if (arg3 != null)
	{
		ret->u.lstring.arg = arg3;
	}

	return ret;
}

//////////////////////////////////////////////////////
// 		 PRINT APT
/////////////////////////////////////////////////////

void print_decls(calc_t_decls decls)
{
	switch(decls->kind) 
	{
		case DECLS_ONE:
			printf("[.decls \n");
			print_decl(decls->u.decl);
			printf("] \n");
			break;
		case DECLS_MULTI:
			printf("[.decls \n");
			print_decl(decls->u.decl);
			print_decls(decls->u.decls);
			printf("] \n");
			break;
		default :
			printf("Erro\n");
	}
}

void print_decl(calc_t_decl decl)
{
	switch(decl->kind)
	{
		case DECL_VAR:
			printf("[.decl \n");
			print_ids(decl->u.ids);
			print_type(decl->u.type);
			printf("] \n");
			break;
		case DECL_VAR_INIT:
			printf("[.decl \n");
			print_ids(decl->u.ids);
			print_type(decl->u.type);
			print_exp(decl->u.exp);
			printf("] \n");
			break;
		case DECL_FUNC:
			printf("[.decl \n");
			print_type(decl->u.type);
			print_exp(decl->u.stms);
			printf("] \n");
			break;
		case DECL_FUNC_ARGS:
			printf("[.decl \n");
			print_ids(decl->u.arg);
			print_type(decl->u.type);
			print_exp(decl->u.stms);
			printf("] \n");
			break;
		case DECL_DEFINE:
			printf("[.decl \n");
			print_type(decl->u.type);
			printf("] \n");
			break;
		default :
			printf("Erro\n");
	}
}

void print_stms(calc_t_stms stms)
{
	switch(stms->kind) 
	{
		case STMS_ONE:
			printf("[.stms \n");
			print_decl(stms->u.stm);
			printf("] \n");
			break;
		case STMS_MULTI:
			printf("[.stms \n");
			print_decl(stms->u.stm);
			print_decls(stms->u.stms);
			printf("] \n");
			break;
		default :
			printf("Erro\n");
	}
}

void print_stm(calc_t_stm stm)
{
	switch(stm->kind)
	{
		case STM_DECL:
			printf("[.stm \n");
			print_decl(stm->u.decl);
			printf("] \n");
			break;
		case STM_ID:
			printf("[.stm \n");
			print_exp(stm->u.exp);
			printf("] \n");
			break;
		case STM_ID_ASSIGN:
			printf("[.stm \n");
			print_exp(stm->u.exp);
			printf("] \n");
			break;
		case STM_RETURN:
			printf("[.stm \n");
			print_exp(stm->u.exp);
			printf("] \n");
			break;
		case STM_BREAK:
			printf("[.decl \n");
			printf("] \n");
			break;
		case STM_NEXT:
			printf("[.decl \n");
			printf("] \n");
			break;
		case STM_IF_THEN:
			printf("[.stm \n");
			print_exp(stm->u.exp);
			print_stms(stm->u.stms);
			printf("] \n");
			break;
		case STM_IF_THEN_ELSE:
			printf("[.stm \n");
			print_exp(stm->u.exp);
			print_stms(stm->u.stms);
			print_stms(stm->u.stms_else);			
			printf("] \n");
			break;
		case STM_WHILE:
			printf("[.stm \n");
			print_exp(stm->u.exp);
			print_stms(stm->u.stms);
			printf("] \n");
			break;
		case STM_PRINT:
			printf("[.stm \n");
			print_exp(stm->u.exp);
			printf("] \n");
			break;
		case STM_INPUT:
			printf("[.stm \n");
			print_exp(stm->u.exp);
			printf("] \n");
			break;
		default :
			printf("Erro\n");
	}
}

void print_argdefs(calc_t_argdefs argdefs)
{
	switch(argdefs->kind) 
	{
		case ARGDEFS_ONE:
			printf("[.argdefs \n");
			print_argdef(argdefs->u.argdef);
			printf("] \n");
			break;
		case ARGDEFS_MULTI:
			printf("[.argdefs \n");
			print_argdef(argdefs->u.argdef);
			print_argdefs(argdefs->u.argdefs);
			printf("] \n");
			break;
		default :
			printf("Erro\n");
	}
}

void print_argdef(calc_t_argdef argdef)
{
	switch(argdef->kind)
	{
		case ARGDEF:
			printf("[.argdef \n");
			print_type(argdef->u.type);
			printf("] \n");
			break;
		default :
			printf("Erro\n");
	}
}

void print_exp(calc_t_exp exp)
{
	switch (exp->kind) {
	  	case EXP_ID:
	    	printf("[.exp [.id $%s$ ] ]\n", exp->u.id);
	    	break;
	    case EXP_LIT:
	    	printf("[.exp ");
	    	print_literal(exp->u.lit);
	    	printf("] \n");
	  	case EXP_BINOP:
	    	printf("[.exp [.binop [.$%s$ ] ", exp->u.binop.op);
	    	print_exp(exp->u.binop.arg1);
	    	print_exp(exp->u.binop.arg2);
	    	printf(" ] ]\n ");
	    	break;
	  	case EXP_UNOP:
	    	printf("[.exp [.unop [.$%s$ ] ", exp->u.unop.op);
	    	print_exp(exp->u.unop.arg);
	    	printf(" ] ]\n ");
	    	break;
	  	case EXP_PAR:
	    	printf("[.exp [.parens ");
	    	print_exp(exp->u.par);
	    	printf(" ] ]\n ");
	    	break;
	  	case EXP_ASSIGN:
	    	printf("[.exp [.assign [.id $%s$ ] ", exp->u.assign.id);
	    	calc_exp_print(exp->u.assign.rvalue);
	    	printf(" ] ]\n ");
	    	break;
	    default :
	    	printf("Erro \n");
	}
}

void print_type(calc_t_type type)
{
	switch(type->kind)
	{
		case TYPE_INT:
			printf("[.type [ INT ] ]\n");
			break;
		case TYPE_FLOAT:
			printf("[.type [ FLOAT ] ]\n");
			break;
		case TYPE_STRING:
			printf("[.type [ STRING ] ]\n");
			break;
		case TYPE_BOOL:
			printf("[.type [ BOOL ] ]\n");
			break;
		case TYPE_VOID:
			printf("[.type [ VOID ] ]\n");
			break;
		case TYPE_ARRAY:
			printf("[.type \n");
			print_type(type->u.type);
			printf("] \n");
			break;
		default :
			printf("Erro \n");
	}
}

void print_ids(calc_t_ids ids)
{
	switch(ids->kind)
	{

	}
}