#include "ast.h"

void ir(global_declarations global_declarations);

void ir_global_decls(global_declarations global_declarations);
void ir_global_decl(global_declaration global_declaration);

void ir_fun_decl(function_declaration function_declaration);
void ir_fun_body(body body);

void ir_expression(expression expression);

void ir_literal(literal literal, type type);
void ir_atomic(atomic_expression atomic_expression, type type);

void ir_identifier(identifier identifier, type type);
void ir_oper_2(operator_two operator_two, type type);