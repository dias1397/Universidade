#include "ast.h"

char *remove_quotes(char *src);
void ir(global_declarations global_declarations);

void ir_global_decls(global_declarations global_declarations);
void ir_global_decl(global_declaration global_declaration);

void ir_fun_decl(function_declaration function_declaration);
void ir_fun_body(body body);

int ir_expression(expression expression);
int ir_expressions(expressions expressions);

int ir_literal(literal literal, type type);
int ir_atomic(atomic_expression atomic_expression, type type);

int ir_identifier(identifier identifier, type type);
int ir_oper_2(operator_two operator_two, type type, int tx, int ty);

int ir_oper_1(operator_one operator_one, type type, int tx);

void ir_statement(statement statement);
void ir_assign(identifier identifier, expression expression);

void ir_statements(statements statements);
void ir_call_stmt(call_statement call_statement);

void ir_if_stmt(if_statement if_statement);

void ir_local_decl(local_declaration local_declaration);
void ir_local_decls(local_declarations local_declarations);

int ir_fun_call(fun_call fun_call);
