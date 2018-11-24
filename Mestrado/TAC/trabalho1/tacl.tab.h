/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_TACL_TAB_H_INCLUDED
# define YY_YY_TACL_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    VAR = 258,
    FUN = 259,
    BODY = 260,
    ARG = 261,
    LOCAL = 262,
    ASSIGN = 263,
    CALL = 264,
    PRINT = 265,
    IF = 266,
    WHILE = 267,
    OPPAR = 268,
    CLPAR = 269,
    OPRPAR = 270,
    CLRPAR = 271,
    COLON = 272,
    ID = 273,
    INT_LITERAL = 274,
    REAL_LITERAL = 275,
    INT = 276,
    REAL = 277,
    BOOL = 278,
    TOREAL = 279,
    NIL = 280,
    INT_LITERAL_VALUE = 281,
    REAL_LITERAL_VALUE = 282,
    BOOL_LITERAL = 283,
    IDENTIFIER = 284,
    OR = 285,
    AND = 286,
    EQ = 287,
    NE = 288,
    LT = 289,
    LE = 290,
    GT = 291,
    GE = 292,
    PLUS = 293,
    MINUS = 294,
    TIMES = 295,
    DIV = 296,
    MOD = 297,
    NOT = 298,
    INV = 299,
    ERROR = 300
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 9 "tacl.y" /* yacc.c:1909  */

	char   *string;
	int    integer;
	double real;

	struct global_declarations *global_declarations;
	struct global_declaration *global_declaration;
	struct variable_declaration *variable_declaration;
	struct function_declaration *function_declaration;
	struct identifier *identifier;
	struct literal *literal;
	struct expressions *expressions;
	struct expression *expression;
	struct statements *statements;
	struct statement *statement;
	struct kind *kind;
	struct type *type;
	struct operator_one *operator_one;
	struct operator_two *operator_two;
	struct formal_args *formal_args;
	struct formal_arg *formal_arg;
	struct body *body;
	struct local_declarations *local_declarations;
	struct local_declaration *local_declaration;
	struct if_statement *if_statement;
	struct call_statement *call_statement;
	struct fun_call *fun_call;
	struct atomic_expression *atomic_expression;

#line 130 "tacl.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_TACL_TAB_H_INCLUDED  */
