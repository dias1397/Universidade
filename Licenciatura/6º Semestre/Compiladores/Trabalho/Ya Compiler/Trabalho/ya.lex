%option noyywrap
%option yylineno

%{
#include <stdlib.h>
#include <string.h>
#include "ya.h"
#include "parser.h"

int line = 0;
int column = 0;

#define INC_RET(x, y) 	column += x; return (y)
#define INC_COL(x)		column += x
#define INC_LINE		line++;		 column = 0

%}

LINT 	[0-9]+
LFLOAT 	[0-9]*\.[0-9]+([eE]([\-\+])?[0-9]+)?
LSTRING \"[^\"]+\"
ID 		[a-zA-Z][a-zA-Z0-9_]*

%%

"+"		{ INC_RET(1, ADD);		}	
"-"		{ INC_RET(1, SUB); 		}		
"*"		{ INC_RET(1, MUL); 		}	
"/"		{ INC_RET(1, DIV); 		}
"^" 	{ INC_RET(1, POW);		}			
"mod" 	{ INC_RET(3, MOD);		}

"and" 	{ INC_RET(3, AND);		}
"or" 	{ INC_RET(2, OR);		}
"not" 	{ INC_RET(3, NOT);		}

"==" 	{ INC_RET(2, EQ);		}
"!=" 	{ INC_RET(2, DIF);		}
"<" 	{ INC_RET(1, LT);		}
">" 	{ INC_RET(1, GT);		}
"<=" 	{ INC_RET(2, LEQ);		}
">=" 	{ INC_RET(2, GEQ);		}
"=" 	{ INC_RET(1, ASSIGN);	}

";" 	{ INC_RET(1, SEMI);		}
"\"" 	{ INC_RET(1, ASP);		}
"("		{ INC_RET(1, LPAR);		}
")"		{ INC_RET(1, RPAR);		}
"["		{ INC_RET(1, LRPAR);	}
"]" 	{ INC_RET(1, RRPAR);	}
"{" 	{ INC_RET(1, LCBRACE);	}
"}" 	{ INC_RET(1, RCBRACE);	}
"," 	{ INC_RET(1, COMMA);	}
":" 	{ INC_RET(1, COLON);	}
"."		{ INC_RET(1, DOT); 	  	}

"int" 	{ INC_RET(3, INT); 		}
"float" { INc_RET(5, FLOAT); 	}
"string"{ INC_RET(6, STRING); 	}
"bool"  { INC_RET(4, BOOL);		}
"void"  { INC_RET(4, VOID); 	}

"if" 	{ INC_RET(2, IF); 		}
"then"  { INC_RET(4, THEN); 	}
"else"  { INC_RET(4, ELSE); 	}

"while" { INC_RET(5, WHILE); 	}
"do"    { INC_RET(2, DO); 		}

"define"{ INC_RET(6, DEFINE); 	}
"return"{ INC_RET(6, RETURN);	}
"break" { INC_RET(5, BREAK);	}
"next" 	{ INC_RET(4, NEXT);		}

"print" { INC_RET(5, PRINT); 	}
"input" { INC_RET(5, INPUT);	}

{LINT} 	{ yylval.f_int = atof(yytext); INC_RET(strlen(yytext), LINT); }
{LFLOAT} { yylval.f_float = atof(yytext); INC_RET(strlen(yytext), LFLOAT); }
{LSTRING} { yylval.string = strdup(yytext); INC_RET(strlen(yytext), LSTRING); }
{ID} 	{ yylval.id = strdup(yytext); INC_RET(strlen(yytext), ID); }

"true" 	{ yylval.boolean = 1; INC_RET(4, LBOOL); }
"false" { yylval.boolean = 0; INC_RET(5, LBOOL); }

\n 		{ INC_LINE();}
[ \t]+	{ INC_COL(strlen(yytext)); }


%%

int yywrap() 
{
	return 1;
}