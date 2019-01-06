#include "tree.h"
#define N 10
 
typedef struct function *function;
typedef struct list *list;

struct function 
{
	char *formal_args[N];
	int nr_args;

	char *local_vars[N];
	int nr_vars;

	function next;
};

struct list
{
	int size;
	int current;

	function header;
};

list new_list();
void insert(list list, function function);

function get_function(list list, int position);
function new_function(formal_args formal_args, local_vars local_vars);

void mips(preamble preamble, functions functions);

void mips_preamble(preamble preamble);

void mips_global_symbol(global_symbol global_symbol);
void mips_variable_decl(variable_declaration variable_declaration);
void mips_function_decl(function_declaration function_declaration);

void mips_functions(functions functions);

void mips_function(ir_function ir_function);
void mips_prologue();
void mips_epilogue();
void mips_instructions(instructions instructions);
void mips_instruction(instruction instruction);
void mips_args(args args);
void mips_arg(arg arg);

char *change_label(char *src);
