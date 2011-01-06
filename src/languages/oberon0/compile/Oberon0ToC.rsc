module languages::oberon0::compile::Oberon0ToC

import languages::oberon0::ast::Oberon0;
import languages::oberon0::compile::Oberon0;
import String;
import List;
import IO;

public str mod2c(Module m) {
return "
#include \<builtins.h\>
<consts2c(m.decls.consts)>
<types2c(m.decls.types)>
<vars2c(m.decls.vars)>
<procs2c(m.decls.procs)>
int main(int argc, char **argv) {
  <stats2c(m.body)>
}
";
}

public str proc2c(Procedure p) {
 return "
<consts2c(p.decls.consts)>
<types2c(p.decls.types)>
<procs2c(p.decls.procs)>
static void <p.name@longName>(<formals2c(p)>) {
  <vars2c(p.decls.vars)>
  <stats2c(p.body)>
}
";
}

public str procs2c(list[Procedure] procs) {
  return ("" | it + proc2c(p) | p <- procs);
}

public str types2c(list[TypeDecl] tds) {
  return ("" | it + "typedef <type2c(td.\type)> <td.name.name>;\n" | td <- tds );
}

public str vars2c(list[VarDecl] vds) {
 return ("" | it + "<varType2c(n.name, vd.\type)>;\n" | vd <- vds, n <- vd.names );
}

public str consts2c(list[ConstDecl] cds) {
 return ("" | it + "#define <cd.name.name> <exp2c(cd.\value)>\n" | cd <- cds );
}

public str varType2c(str v, Type t) {
  switch (t) {
    case array(b, et): {
      <base, bounds> = baseBounds(et, b);
      return "<base> <v><bounds>";
    }
    default: return "<type2c(t)> <v>";
  }
}

public tuple[str, str] baseBounds(Type t, Expression bound) {
  switch (t) {
    case array(b2, et): {
      <t2, bound2> = baseBounds(et, b2);
      return <t2, bound1 + bound2>;
    }
    default: return <"<type2c(t)>", "[<exp2c(bound)>]">;
  }
}

public str type2c(Type t) {
  switch (t) {
    case user(id("INTEGER")): return "int";
    case user(id("BOOLEAN")): return "int";
    case array(b, et): return "<type2c(et)>[<exp2c(b)>]";
    case record(fs): return "struct {
<fields2c(fs)>}";
  }
}

public str fields2c(list[Field] fs) {
 return ("" | it + "<varType2c(n.name, f.\type)>;\n" | f <- fs, n <- f.names );
}


public str formals2c(Procedure p) {
  cfs = for (f <- p.formals + p.name@captured, n <- f.names) {
    t = type2c(f.\type);
    append f.hasVar ? varType2c("(*<n.name>)", f.\type) : varType2c(n.name, f.\type);
  }
  return intercalate(", ", cfs);
}


public str cond2c(Expression e) {
  switch (e) {
    case not(exp): return "(!<cond2c(exp, env)>)";
    case amp(lhs, rhs): return "(<cond2c(lhs)> && <cond2c(rhs)>)";
    case or(lhs, rhs): return  "(<cond2c(lhs)> || <cond2c(rhs)>)";
    case eq(lhs, rhs): return "(<exp2c(lhs)> == <exp2c(rhs)>)";
    case neq(lhs, rhs): return  "(<exp2c(lhs)> != <exp2c(rhs)>)";
    case lt(lhs, rhs): return  "(<exp2c(lhs)> \< <exp2c(rhs)>)";
    case gt(lhs, rhs): return  "(<exp2c(lhs)> \> <exp2c(rhs)>)";
    case leq(lhs, rhs): return  "(<exp2c(lhs)> \<= <exp2c(rhs)>)";
    case geq(lhs, rhs): return  "(<exp2c(lhs)> \>= <exp2c(rhs)>)";
    default: throw "Not a condition: <e>";
  }
}

public str var2c(Ident id, list[Selector] sels) {
  println("var = <id.name>");
  // consts in types and var decls are not annotated
  if ((id@isByReference)? && id@isByReference) {
    return "(*<id.name>)<sels2c(sels)>";
  }
  return "<id.name><sels2c(sels)>";
}

public str sels2c(list[Selector] sels) {
  csels = for (s <- sels) {
    switch (s) {
      case field(Ident id): append ".<id.name>";
      case subscript(e): append "[<exp2c(e)>]";
    }
  }
  return intercalate("", csels);
}

public str exp2c(Expression e) {
  switch (e) {
    case nat(int val): return "<val>";
    case lookup(v, sels): return var2c(v, sels);
    case neg(exp): return "(-<exp2c(exp)>)";
    case pos(exp): return exp2c(exp);
    case mul(lhs, rhs): return "(<exp2c(lhs)>*<exp2c(rhs)>)";
    case div(lhs, rhs): return "(<exp2c(lhs)>/<exp2c(rhs)>)";
    case mod(lhs, rhs): return "(<exp2c(lhs)>%<exp2c(rhs)>)";
    case add(lhs, rhs): return "(<exp2c(lhs)>+<exp2c(rhs)>)";
    case sub(lhs, rhs): return "(<exp2c(lhs)>-<exp2c(rhs)>)";
    default: throw "Not a exp: <e>";
  }
}


public str call2c(Ident id, list[Expression] args) {
  int i = 0;
  println("Calling: <id.name>");
  cargs = for (f <- id@formals, _ <- f.names) {
    a = exp2c(args[i]);
    append f.hasVar ? "&(<a>)" : a; 
    i += 1;
  }
  cargs += for (f <- id@captured, n <- f.names) {
    append "&<n.name>";
  }
  return "<id@longName>(<intercalate(", ", cargs)>)";
}

public str stats2c(list[Statement] stats) {
  return ("" | it + stat2c(s) + "\n" | s <- stats);
}

public str stat2c(Statement stat) {
  switch (stat) {
    case assign(v, sels, exp): return "<var2c(v, sels)> = <exp2c(exp)>;";
    case call(Ident id, args): return "<call2c(id, args)>;"; 
    case ifThen(c, b, eis, ep):
      return "
if (<cond2c(c)>) {
  <stats2c(b)>
}
<for (ei <- eis) {>
else if (<cond2c(ei[0])>) {
  <stats2c(ei[1])>
}
<}>
<if (ep != []) {>
else {
  <stats2c(ep)>
}
<}>    
    ";
    
    case whileDo(c, b): return "
 while (<cond2c(c)>) {
   <stats2c(b)>
 }   
";
  }
}