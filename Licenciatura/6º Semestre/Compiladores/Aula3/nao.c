struct t_decls{
	enum {d_1, d_list} kind;

	union{
		t_decl d;

		struct {
			t_decl d;
			t_decls tail;
		} dust;
	} u;
};


struct t_decl {
	enum {d_id, d_idval, d_f, d_fargs, d_type} kind; 

	union {
		struct {
			t_ids ids;
			t_type typ;
		}did;

		struct {
			t_ids ids;
			t_type typ;
			t_exp e;
		}didval;

		
	}
}