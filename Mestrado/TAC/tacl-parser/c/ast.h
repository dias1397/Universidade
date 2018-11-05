#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct ast_decls decls;
typedef struct ast_decl decl;

typedef struct ast_id id;


typedef enum kind_decl {var_decl, fun_decl} kind_decl;


struct ast_decls{
	decl *declaration;
	decls *declarations;
}
struct ast_decl{
	kind_decl kind;

	union {
		id *id;
		
	} var;

	union {

	} fun;
}

decls *new_ast_decls(decl *declaration, decls *declarations);