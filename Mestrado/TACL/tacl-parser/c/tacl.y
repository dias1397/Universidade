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
%token INT REAL BOOL
%token EQSIGN COMMA SEMICOLON OPPAR CLPAR
%token ID
%token INT_LITERAL

%left OR
%left AND
%left EQ NE LT LE GT GE
%left PLUS MINUS
%left TIMES DIV MOD
%nonassoc NOT

%token ERROR		// for signalling lexical errors

%%

program : global_declarations ;

global_declarations : global_declaration global_declarations
	     	    | global_declaration
		    ;

global_declaration : fundef
		   ;

fundef : FUN type ID OPPAR formal_args CLPAR body
       ;

type : INT | REAL | BOOL ;

formal_arg : type ID ;

formal_args : formal_arg more_formal_args
	    | /* empty */
	    ;

more_formal_args : COMMA formal_arg more_formal_args
		 | /* empty */
		 ;

body : EQSIGN expression SEMICOLON
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

atomic_expression : ID
		  | literal
		  ;

compare_op : EQ | NE | LT | LE | GT | GE ;

literal : INT_LITERAL
        ;

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
