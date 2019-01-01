#include "tree.h"

void mips(preamble preamble, functions functions);

void mips_preamble(preamble preamble);

void mips_global_symbol(global_symbol global_symbol);
void mips_variable_decl(variable_declaration variable_declaration);
void mips_function_decl(function_declaration function_declaration);

void mips_functions(functions functions);