#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct t_decl_      *t_decl;
typedef struct t_decls_     *t_decls;
typedef struct t_ids_       *t_ids;
typedef struct t_type_      *t_type;
typedef struct t_argdefs_   *t_argdefs;
typedef struct t_argdef_    *t_argdef;
typedef struct t_literais_  *t_literais;
typedef struct t_stmts_     *t_stmts;
typedef struct t_stmt_      *t_stmt;
typedef struct t_exp_       *t_exp;

t_decls T_decls_declaration(t_decl arg0, t_decls arg1);
t_decl T_decl_variable(t_ids arg0, t_type arg1, t_exp arg2);
t_decl T_decl_func_def(char* arg3, t_argdefs arg0, t_type arg1, t_stmts arg2);

t_ids T_ids_id(t_ids arg0, char* arg1);

t_type T_type_def(t_type arg0, int arg1, int arg2);

t_argdefs T_argdefs_def(t_argdef arg0, t_argdefs arg1);
t_argdef T_argdef_def(t_type arg0, char* arg1);

t_literais T_literais_int_bool(int arg0, int arg1);
t_literais T_literais_string(char* arg0);
t_literais T_literais_float(float arg0);

t_stmts T_stmts_def(t_stmt arg0, t_stmts arg1);

t_stmt T_stmt_decl(t_decl arg0);
t_stmt T_stmt_id(char* arg0, t_exp arg1, int arg2);
t_stmt T_stmt_all(t_exp arg0, t_stmts arg1, t_stmts arg2, int arg3);
t_stmt T_stmt_empty(int arg0);

t_exp T_exp_one_id(char* arg0);
t_exp T_exp_one_literais(t_literais arg0);
t_exp T_exp_exp(t_exp arg0, t_exp arg1, int arg2);
t_exp T_exp_id(char* arg0, t_exp arg1);


void print_decls (t_decls arg0);