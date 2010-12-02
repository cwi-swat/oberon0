module languages::oberon0::format::AST

import languages::oberon0::ast::Oberon0;
import box::Box;

data Box = arg(int pos) 
 	 | txt(int pos);


public map[str,Box] ppExpTable = (
  "nat": NM(arg(0)),
  "lookup": arg(0),
  "not": H([L("~"), arg(0)])[@hs=1],
  "mul": H([arg(0), arg(1)])[@hs=1],
  "div": H([arg(0), arg(1)])[@hs=1],
  "mod": H([arg(0), arg(1)])[@hs=1],
  "amp": H([arg(0), arg(1)])[@hs=1],
  "add": H([arg(0), arg(1)])[@hs=1],
  "sub": H([arg(0), arg(1)])[@hs=1],
  "or":  H([arg(0), arg(1)])[@hs=1],
  "eq":  H([arg(0), arg(1)])[@hs=1],
  "neq": H([arg(0), arg(1)])[@hs=1],
  "lt":  H([arg(0), arg(1)])[@hs=1],
  "gt":  H([arg(0), arg(1)])[@hs=1],
  "leq": H([arg(0), arg(1)])[@hs=1],
  "geq": H([arg(0), arg(1)])[@hs=1],
);

public map[str,Box] ppStatTable = (
  "assign" : H([arg(0), L(":="), arg(1)]),
  "call": H([arg(0), [@hs=0]
data Statement = assign(Variable var, Expression exp)
               | call(Variable var, list[Expression] args)
               | ifThen(Expression condition, list[Statement] body, 
                   list[tuple[Expression condition, list[Statement] body]] elseIfs,
                   list[Statement] elsePart)
               | whileDo(Expression condition, list[Statement] body);

);