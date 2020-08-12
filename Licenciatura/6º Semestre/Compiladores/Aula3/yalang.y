%%

%union{
	int f_int;
	float f_float;
	char *id;
	int boolean;
	char *string;
}

%token <var>		INTLIT FLOATLIT BOOLLIT
%token <str> 		STRLIT
%token <id> 		ID

%token 				COLON

%token 				DEFINE RETURN STRUCT WHILE IF THEN

%token				T_INT T_FLOAT T_STRING T_BOOL

%left				SEMI

%right				ASSIGN

%left				COMMA

%left				OR
%left				AND
%left				NOT

%nonassoc			EQ NEQ GT GEQ LT LEQ

%left				SUB ADD
%left				MUL DIV MOD
%right				POW
%left				NEG

%nonassoc			LCBRACE RCBRACE
%nonassoc			LSBRACE RSBRACE
%nonassoc			LPAR RPAR

%%

program: /* 	empty */
		|		decls
				;

decls:			decl
		|		decl decls
				;

decl:			ids COLON type SEMI
		|		ids COLON type ASSIGN exp SEMI
		|		ID LPAR RPAR COLON type LCBRACE stms RBRACE SEMI
		|		ID LPAR argdefs RPAR COLON type LCBRACE stms RCBRACE SEMI
		|		DEFINE ID type SEMI
				;

stms 			stm
		| 		stm stms
				;

stms:			decl
		|		IF exp THEN LCBRACE stms RCBRACE SEMI
		|		IF exp THEN LCBRACE stms RCBRACE ELSE LCBRACE stms RCBRACE SEMI
		|		WHILE exp DO LCBRACE stms RCBRACE SEMI
		|		RETURN exp SEMI
		|		


ids:			ID
		|		ID COMMA ids
				; 

argdefs: 		argdefs
		|		argdef COMMA argdefs
				;

argdef:			ID COLON type
				;

args: 			exp
		|		exp COMMA args
				;


exp:			NUM					{}
		|		ID 					{}
		| 		exp ADD exp			{}
		|		exp SUB exp			{}
		| 		exp MUL exp			{}
		|		exp DIV exp			{}
		|		SUB exp %prec NEG 	{}
		|		LPAR exp RPAR		{}
		|		ID ASSIGN exp		{}
;

%%
