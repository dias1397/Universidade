#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct calc_t_decls_ *calc_t_decls;
typedef struct calc_t_decl_ *calc_t_decl;
typedef struct calc_t_stms_ *calc_t_stms;
typedef struct calc_t_stm_ *calc_t_stm;
typedef struct calc_t_argdefs_ *calc_t_argdefs;
typedef struct calc_t_argdef_ *calc_t_argdef;
typedef struct calc_t_exp_ *calc_t_exp;
typedef struct calc_t_type_ *calc_t_type;
typedef struct calc_t_ids_ *calc_t_ids;
typedef struct calc_t_literal_ *calc_t_literal;

calc_t_decls calc_decls_new_one(calc_t_decl arg1);
calc_t_decls calc_decls_new_multi(calc_t_decl arg1, calc_t_decls arg2);
calc_t_decl calc_decl_new_var(calc_t_ids arg1, calc_t_type arg2, calc_t_exp arg3);
calc_t_decl calc_decl_new_func(calc_t_argdefs arg1, calc_t_type arg2, calc_t_stms arg3);
calc_t_decl calc_decl_new_define(calc_t_type arg1);

calc_t_stms calc_stms_new_one(calc_t_stm arg1);
calc_t_stms calc_stms_new_multi(calc_t_stm arg1, calc_t_stms arg2);
calc_t_stm calc_stm_new_decl(calc_t_decl arg1);
calc_t_stm calc_stm_new_stm(int arg0, calc_t_exp arg1);
calc_t_stm calc_stm_new_cycle(int arg0, calc_t_exp arg1, calc_t_stms arg2, calc_t_stms arg3);

calc_t_argdefs calc_argdefs_new_one(calc_t_argdef arg1);
calc_t_argdefs calc_argdefs_new_multi(calc_t_argdef arg1, calc_t_argdefs arg2);
calc_t_argdef calc_argdef(calc_t_type arg1);

calc_t_exp calc_exp_new_id(char *id);
calc_t_exp calc_exp_new_literal(calc_t_lit arg1);
calc_t_exp calc_exp_new_binop(char op[], calc_t_exp arg1, calc_t_exp arg2);
calc_t_exp calc_exp_new_unop(char op[], calc_t_exp arg1);
calc_t_exp calc_exp_new_par(calc_t_exp arg1);

calc_t_type calc_type(int arg0, calc_t_type arg1);
calc_t_ids calc_ids(calc_t_ids arg1);
calc_t_literal calc_literal(int arg0, int arg1, float arg2, char* arg3);
