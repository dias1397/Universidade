%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *);	// see below
%}


%error-verbose
%expect 0

%union {
  char   *string;
  int    integer;
  double real;
}

%token FUN
%token VAR
%token PROC
%token PRINT
%token IF ELSE WHILE
%token INT REAL BOOL
%token EQSIGN COMMA SEMICOLON OPPAR CLPAR LRPAR RRPAR
%token ID
%token INT_LITERAL

%left POT
%left OR
%left AND
%left EQ NE LT LE GT GE
%left PLUS MINUS
%left TIMES DIV MOD
%nonassoc NOT

%token ERROR		// for signalling lexical errors

%%

program : global_declarations 
		;


global_declarations : global_declaration global_declarations
	    | global_declaration
		;

global_declaration : variable_declaration
		| function_declaration 
		| procedure_declaration
		;


variable_declaration : VAR type ID variable_init SEMICOLON	
		;

function_declaration : FUN type ID OPPAR formal_args CLPAR function_init
		;

procedure_declaration : PROC ID OPPAR formal_args CLPAR procedure_body 
		; 


type : INT | REAL | BOOL 
		;

formal_arg : type ID 
		;

formal_args : formal_arg more_formal_args
	    | /* empty */
	    ;

more_formal_args : COMMA formal_arg more_formal_args
		| /* empty */
		;


variable_init : EQSIGN expression 
		| /*empty */
		; 

function_init : EQSIGN expression SEMICOLON 
		| LRPAR function_body RRPAR 
		;


function_body : local_variable instructions return_statment 
		;

procedure_body : LRPAR local_variable instructions RRPAR
		;


local_variable : variable_declaration local_variable 
		| /*empty */
		;


instructions : /*empty */
		| instruction instructions 
		;

instruction : ID EQSIGN expression SEMICOLON 
		| ID OPPAR expression_args CLPAR SEMICOLON
		| PRINT expression SEMICOLON
		| IF OPPAR expression CLPAR instruction 
		| IF OPPAR expression CLPAR instruction ELSE instruction
		| WHILE OPPAR expression CLPAR instruction
		| LRPAR instructions RRPAR
		;


return_statment :  POT expression 
		;


expression : expression OR expression
		| expression AND expression
		| expression compare_op expression %prec EQ
		| expression PLUS expression
		| expression MINUS expression
		| expression TIMES expression
		| expression DIV expression
		| expression MOD expression
		| NOT expression
		| MINUS expression %prec NOT
		| atomic_expression
		;


expression_arg : expression 
		;

expression_args : expression_arg more_expression_args 
		| /*empty */
		;

more_expression_args : COMMA expression_arg more_expression_args 
		| /*empty */
		;


atomic_expression : ID
		| literal
		;

literal : INT_LITERAL
        ;

compare_op : EQ | NE | LT | LE | GT | GE ;

%%

/* called when there is a syntax error */
void yyerror(const char *msg)
{
  fprintf(stderr, "error: %s\n", msg);
}

int main()
{
  return yyparse();
}

