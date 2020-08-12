#includ "t_exp.h"

struct t_lit_ {
	enum {L_INT, L_FLOAT, L_STR, L_BOOL } kind;

	union {
	int i; /* contains both int abd boll */
	double f;
	char *s;
	} uM
};

struct t_exp {
	enum {E_LIT_, E_ID; E_ARR, E_BINOP, E_UNOP, E:FUNCALL, E_ASSIGN } kind;

	union{
		t_kist kit;
		char *id;

		struct {
			char *id;
			int index;
		}arr;

		struct {
			char op[5];
			t_EXP e1;
			t_EXP e2;
		}binop;

		struct{
			char op[5];
			t_EXP e;
		} unio;

		struct{
			char *id;
			t_ARGS args;
		} funcall;

	}
}
