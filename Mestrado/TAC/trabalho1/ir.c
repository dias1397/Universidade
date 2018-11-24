#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "ir.h"

void ir(global_declarations global_declarations)
{
	if (global_declarations == NULL)
	{
		printf("nop\n");
	}
	else
	{
		printf("\n");
		ir_global_decl(global_declarations->u.multi_decl.arg0);
		ir_global_decls(global_declarations->u.multi_decl.arg1);
	}
}

void ir_global_decls(global_declarations global_declarations)
{
	printf("decls\n");
}

void ir_global_decl(global_declaration global_declaration)
{
	printf("decl\n");
}
