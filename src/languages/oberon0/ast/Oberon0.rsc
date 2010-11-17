
module languages::oberon0::ast::Oberon0

data Selector = field(str field)
              | subscript(Expression exp);

data Expression = nat(int val)
                | lookup(Variable var)
                | not(Expression exp)
                | pos(Expression exp)
                | not(Expression exp)
                | mul(Expression lhs, Expression rhs)
                | div(Expression lhs, Expression rhs)
                | mod(Expression lhs, Expression rhs)
                | amp(Expression lhs, Expression rhs)
                | add(Expression lhs, Expression rhs)
                | sub(Expression lhs, Expression rhs)
                | or(Expression lhs, Expression rhs)
                | eq(Expression lhs, Expression rhs)
                | neq(Expression lhs, Expression rhs)
                | lt(Expression lhs, Expression rhs)
                | gt(Expression lhs, Expression rhs)
                | leq(Expression lhs, Expression rhs)
                | geq(Expression lhs, Expression rhs);

data Variable = var(str name, list[Selector] selectors);

data Statement = assign(Variable var, Expression exp)
               | call(Variable var, list[Expression] args)
               | ifThen(Expression condition, list[Statement] body, 
                   list[tuple[Expression condition, list[Statement] body]] elseIfs,
                   list[Statement] elsePart)
               | whileDo(Expression condition, list[Statement] body);


data Type = user(str name)
          | array(Expression exp, Type \type)
          | record(list[Field] fields)
          | integer();

data Field = field(list[str] names, Type \type);

data Formal = formal(bool hasVar, list[str] names, Type \type);

data Procedure = proc(str name, list[Formal] formals, Declarations decls,
                               list[Statement] body, str endName);

data Declarations = decls(list[ConstDecl] consts, list[TypeDecl] types, 
                              list[VarDecl] vars, 
                                  list[Procedure]);

data ConstDecl = constDecl(str name, Expression \value);
data TypeDecl = typeDecl(str name, Type \type);
data VarDecl = varDecl(list[str] names, Type \type);

data Module = mod(str name, Declarations decls, list[Statement] body, str endName);

