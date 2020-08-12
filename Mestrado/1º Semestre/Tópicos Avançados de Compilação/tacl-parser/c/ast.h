#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct ast_decls decls;
typedef struct ast_decl decl;

typedef struct ast_var var;
typedef struct ast_fun fun;

typedef struct ast_id id;
typedef struct ast_exp exp;

typedef struct ast_formal_args formal_args;
typedef struct ast_body body;

typedef enum kind_decl {var_decl, fun_decl} kind_decl;


struct ast_decls{
	decl *declaration;
	decls *declarations;
}

struct ast_decl{
	kind_decl kind;

	union {

	} var;

	union {

	} fun;
}
struct ast_decl{
	kind_decl kind;

	union {
		id *id;
		exp *exp;
	} var;

	union {
		char *identifier;
		formal_args *formal_args;
		body *body;
	} fun;
}

decls *new_ast_decls(decl *declaration, decls *declarations);

decl *new_ast_decl_var()