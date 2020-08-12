typedef struct t_decl_      *t_decl;
typedef struct t_decls_     *t_decls;
typedef struct t_ids_       *t_ids;
typedef struct t_type_      *t_type;
typedef struct t_argdefs_   *t_argdefs;
typedef struct t_argdef_    *t_argdef;
typedef struct t_literal_   *t_literal;
typedef struct t_stmts_     *t_stmts;
typedef struct t_stmt_      *t_stmt;

struct t_decl_
{
    enum
    {
        t_decl_SINGULAR_DECLARATION,
        t_decl_MULTIPLE_DECLARATION
    }kind;
    struct
    {
        t_decl T_decl;
        t_decls T_decls;
    }u;
};


struct t_decls_
{
    enum
    {
        t_decls_VARIABLE,
        t_decls_VARIABLE_WITH_VALUE,
        t_decls_FUNCTION,
        t_decls_FUNCTION_WITH_ARGS,
        t_decls_DEFINE
    }kind;
    union
    {
        struct
        {
            t_ids T_ids,
            t_type T_type,
            t_exp T_exp
        }variable;
        struct
        {
            char* name,
            t_argdefs T_argdefs,
            t_type T_type,
            t_stmts T_stmts
        }func_def;
    }u;
}

struct t_ids_
{
    enum
    {
        t_ids_SINGULAR,
        t_ids_MULTIPLE
    }kind;
    struct
    {
        char* name;
        t_ids T_ids;
    }u;
}

struct t_type_
{
    enum
    {
        t_type_INT,
        t_type_FLOAT,
        t_type_STRING,
        t_type_BOOL,
        t_type_VOID,
        t_type_TYPE
    }kind;
    struct
    {
        t_type T_type;
        int x;
    }u;
}

struct t_argdefs_
{
    enum
    {
        t_argdefs_SINGULAR,
        t_argdefs_MULTIPLE
    }kind;
    struct 
    {
        t_argdef T_argdef;
        t_argdefs T_argdefs;
    }u;
};

struct t_argdef_
{
    enum
    {
        t_argdef_SINGULAR,
    }kind;
    struct 
    {
        char* name;
        t_type T_type;
    }u;
};

struct t_literal_
{
    enum
    {
        t_literal_LINT,
        t_literal_LFLOAT,
        t_literal_LSTRING,
        t_literal_LBOOL,
    }
    struct
    {
        int lint;
        float lfloat;
        char* lstring;
    }u;
};


struct t_stmts_
{
    enum
    {
        t_stmts_SINGULAR_DECLARATION,
        t_stmts_MULTIPLE_DECLARATION
    }KIND;
    struct
    {
        t_stmt T_stmt;
        t_stmts T_stmts;
    }u;
}

struct t_stmt_
{
    enum
    {
        t_stmt_DECLARATION,
        t_stmt_ID_EXP,
        t_stmt_ASSIGN_EXP,
        t_stmt_IF_THEN,
        t_stmt_IF_THEN_ELSE,
        t_stmt_WHILE,
        t_stmt_RETURN,
        t_stmt_BREAK,
        t_stmt_NEXT,
        t_stmt_PRINT,
        t_stmt_INPUT
    }kind;
    union
    {
        struct
        {
            t_decl T_decl;
        }declaration;
        struct
        {
            t_exp T_exp;
            t_stmts T_stmts;
            t_stmts T_stmts2;
        }others;
    }
}

/////////////////////////////////////////////////////////////
t_decl T_decl_declaration(t_decl arg0, t_decls arg1)
{
    t_decl ret  = (t_decl) malloc(sizeof(*ret));

    if(arg1 == null)
    {
        ret->kind = t_decl_SINGULAR_DECLARATION;
        ret->u.T_decl = arg0;
        return ret;
    }

    ret->kind = t_decl_MULTIPLE_DECLARATION;
    ret->u.T_decl = arg0;
    ret->u.T_decls = arg1;
    return ret;
}
/////////////////////////////////////////////////////////////
t_decls T_decls_variable(t_ids arg0, t_type arg1, t_exp arg2)
{
    t_decls ret = (t_decls) malloc(sizeof(*ret));

    if(arg2 == null)
    {
        ret->kind = t_decls_VARIABLE;
        ret->u.variable.T_ids = arg0;
        ret->u.variable.T_type = arg1;
        return ret;
    }

    ret->kind = t_decls_VARIABLE_WITH_VALUE;
    ret->u.variable.T_ids = arg0;
    ret->u.variable.T_type = arg1;
    ret->u.variable.T_exp = arg2;
    return ret;
}

t_decls T_decls_func_def(t_argdefs arg0, t_type arg1, t_stmts arg2, char* arg3)
{
    t_decls ret = (t_decls) malloc(sizeof(*ret));

    if(arg2==null)
    {
        ret->kind = t_decls_DEFINE;
        ret->u.func_def.T_type = arg1;
        ret->u.func_def.name = arg3;
        return ret;
    }
    if(arg0 == null)
    {
        ret->kind = t_decls_FUNCTION;
        ret->u.func_def.T_type = arg1;
        ret->u.func_def.T_stmts = arg2;
        ret->u.func_def.name = arg3;
        return ret;
    }
    ret->kind = t_decls_FUNCTION_WITH_ARGS;
    ret->u.func_def.T_argdefs = arg0;
    ret->u.func_def.T_type = arg1;
    ret->u.func_def.T_stmts = arg2;
    ret->u.func_def.name = arg3;
    return ret;
}
/////////////////////////////////////////////////////////////
t_ids T_ids (char* arg0, t_ids arg1)
{
    t_ids ret = (t_ids) malloc(sizeof(*ret));

    if (arg1 == null)
    {
        ret->kind = t_ids_SINGULAR;
        ret->u.name = arg0;
        return ret
    }
    ret->kind = t_ids_MULTIPLE;
    ret->u.name = arg0;
    ret->u.T_ids = arg1;
    return id;
}

///////////////////////////////////////////////////////////////7
t_type T_type (int arg0, t_type arg1, int arg2)
{
    t_type ret = (t_type) malloc(sizeof(*ret));

    ret->kind = arg0;

    if (arg0 == 5)
    {
        ret->u.T_type = arg1;
        rer->u.x = arg2;
    }

    return ret;
}

/////////////////////////////////////////////////////////////////
t_argdefs T_argdefs(t_argdef arg0, t_argdefs arg1)
{
    t_argdefs ret = (t_argdefs) malloc(sizeof(*ret));

    if (arg1 == null)
    {
        ret->kind = t_argdefs_SINGULAR;
        ret->u.T_argdef = arg0;
        return ret;
    }
    ret->kind = t_argdefs_MULTIPLE;
    ret->u.T_argdef = arg0;
    ret->u.T_argdefs = arg1;
    return ret;
}

/////////////////////////////////////////////////////////////////
t_argdef T_argdef(t_type arg0, char* arg1)
{
    t_argdef ret = (t_argdef) malloc(sizeof(*ret));

    ret->kind = t_argdef_SINGULAR;
    ret->u.t_type = arg0;
    ret->u.name = arg1;
    return ret;
}

////////////////////////////////////////////////////////////////
t_literal T_literal(int arg1, float arg2, char* arg3)
{
    t_literal ret = (t_literal) malloc(sizeof(*ret));

    if (arg1 != null)
    {
        ret->kind = t_literal_LINT;
        ret->u.lint = arg1;
        return ret;
    }
    if (arg2 != null)
    {
        ret->kind = t_literal_LFLOAT;
        ret->u.lfloat = arg2;
        return ret;
    }

    ret->kind = t_literal_LSTRING;
    ret->u.lstring = arg3;
    return ret;
}

/////////////////////////////////////////////////////////////


t_stmts T_stmts(t_stmt arg0, t_stmts arg1)
{
    t_stmts ret = (t_stmts) malloc(sizeof(*ret));

    if (arg1==null)
    {
        ret->kind = t_stmts_SINGULAR_DECLARATION;
        ret->u.t_stmt = arg0;   
        return ret;
    }
    ret->kind = t_stmts_MULTIPLE_DECLARATION;
    ret->u.t_stmt = arg0;
    ret->u.t_stmts = arg1;
    return ret;
} 

t_stmt T_stmt_decl(t_decl arg0)
{
    t_stmt ret = (t_stmt) malloc(sizeof(*ret));

    ret->kind = t_stmt_DECLARATION;
    ret->u.declaration = arg0;

    return ret;
}