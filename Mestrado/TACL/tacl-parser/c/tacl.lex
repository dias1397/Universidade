%{
#include "tacl.tab.h"
%}

/* avoid `input' and `yyunput' not used warnings */
%option noinput
%option nounput

%%

fun		return FUN;

"("		return OPPAR;
")"		return CLPAR;

[_a-zA-Z][_a-zA-Z0-9]*	{
			  // ...

			  return ID;
			}

[0-9]+		{
		  yylval.integer = atoi(yytext);

		  return INT_LITERAL;
		}

#.*		; /* ignore comments */

[ \t\n]+	; /* and whitespace */

.		{
		  fprintf(stderr, "unrecognised character: `%c'\n", *yytext);

		  return ERROR;
		}
