#include "ast.h"

decls *new_ast_decls(decl *declaration, decls *declarations)
{
	decls *ret = malloc(sizeof(decls));

	ret->declaration = declaration;
	ret->declarations = declarations;

	return ret;
}