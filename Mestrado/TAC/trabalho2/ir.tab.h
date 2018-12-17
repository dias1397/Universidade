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

#ifndef YY_YY_IR_TAB_H_INCLUDED
# define YY_YY_IR_TAB_H_INCLUDED
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
    ID = 260,
    AT = 261,
    VOID = 262,
    INT = 263,
    BOOL = 264,
    OPPAR = 265,
    CLPAR = 266,
    OPRPAR = 267,
    CLRPAR = 268,
    COMMA = 269,
    COLON = 270,
    ARROW = 271,
    IR_FUN = 272,
    I_COPY = 273,
    I_VALUE = 274,
    I_GLOAD = 275,
    I_LLOAD = 276,
    I_ALOAD = 277,
    I_GSTORE = 278,
    I_LSTORE = 279,
    I_ASTORE = 280,
    JUMP = 281,
    CJUMP = 282,
    I_CALL = 283,
    CALL = 284,
    I_RETURN = 285,
    RETURN = 286,
    I_PRINT = 287,
    B_PRINT = 288,
    TEMPORARIE = 289,
    LABEL = 290,
    BOOL_LITERAL = 291,
    INT_LITERAL = 292,
    IDENTIFIER = 293,
    ERROR = 294,
    I_ADD = 295,
    I_SUB = 296,
    I_MUL = 297,
    I_DIV = 298,
    MOD = 299,
    I_EQ = 300,
    I_LT = 301,
    I_NE = 302,
    I_LE = 303,
    NOT = 304,
    I_INV = 305,
    ITOR = 306
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 11 "ir.y" /* yacc.c:1909  */

	char 	*temporarie;
	char 	*label;
	char 	*string;
	int 	integer;

#line 113 "ir.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_IR_TAB_H_INCLUDED  */
