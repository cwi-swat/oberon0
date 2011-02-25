module languages::oberon0::compile::Oberon0ToC

import languages::oberon0::ast::Oberon0;
import String;
import List;
import IO;

alias Env = map[Ident, list[Formal]];
alias ByRef = set[Ident];

public str mod2c(Module m) {
	// assume procs, types and consts have been resolved and lifted
	env = (id("Write"): [formal(false, [id("x")], user(id("INTEGER")))],
			id("WriteLn"): [],
			id("Read"): [formal(true, [id("x")], user(id("INTEGER")))]);
	env += ( p.name: p.formals | p <- m.decls.procs );
return "
#include \<builtins.h\>
<consts2c(m.decls.consts)>
<types2c(m.decls.types)>
<vars2c(m.decls.vars)>
<procs2c(m.decls.procs, env)>
int main(int argc, char **argv) {
  <stats2c(m.body, env, {})>
}
";
}

public str procs2c(list[Procedure] procs, Env env) {
	return ( "" | it + proc2c(p, env) | p <- procs );
}

public str proc2c(Procedure p, Env env) {
	byRef = { n | f <- p.formals, f.hasVar, n <- f.names };
 	return "
static void <p.name.name>(<formals2c(p)>) {
  <vars2c(p.decls.vars)>
  <stats2c(p.body, env, byRef)>
}
";
}

public str formals2c(Procedure p) {
  cfs = for (f <- p.formals, n <- f.names) {
    append f.hasVar ? varType2c("(*<n.name>)", f.\type) : varType2c(n.name, f.\type);
  }
  return intercalate(", ", cfs);
}


public str stats2c(list[Statement] stats, Env env, ByRef byRef) {
  return ("" | it + stat2c(s, env, byRef) + "\n" | s <- stats);
}

public str stat2c(Statement stat, Env env, ByRef byRef) {
  switch (stat) {
    case assign(v, sels, exp): return "<var2c(v, sels, byRef)> = <exp2c(exp, byRef)>;";
    case call(Ident id, args): return "<call2c(id, args, env, byRef)>;"; 
    case ifThen(c, b, eis, ep):
      return "
if (<exp2c(c, byRef)>) {
  <stats2c(b, env, byRef)>
}
<for (ei <- eis) {>
else if (<exp2c(ei[0], byRef)>) {
  <stats2c(ei[1], env, byRef)>
}
<}>
<if (ep != []) {>
else {
  <stats2c(ep, env, byRef)>
}
<}>";
    
    case whileDo(c, b): return "
while (<exp2c(c, byRef)>) {
   <stats2c(b, env, byRef)>
 }";
  }
}

public str call2c(Ident id, list[Expression] args, Env env, ByRef byRef) {
  int i = 0;
  cargs = for (f <- env[id], _ <- f.names) {
    a = exp2c(args[i], byRef);
    append f.hasVar ? "&(<a>)" : a; 
    i += 1;
  }
  return "<id.name>(<intercalate(", ", cargs)>)";
}


public str exp2c(Expression e, ByRef byRef) {
  switch (e) {
    case nat(int val): 		return "<val>";
    case lookup(v, sels): 	return var2c(v, sels, byRef);
    case neg(exp): 			return "(-<exp2c(exp, byRef)>)";
    case pos(exp): 			return exp2c(exp, byRef);
    case mul(lhs, rhs): 	return "(<exp2c(lhs, byRef)>*<exp2c(rhs, byRef)>)";
    case div(lhs, rhs): 	return "(<exp2c(lhs, byRef)>/<exp2c(rhs, byRef)>)";
    case mod(lhs, rhs): 	return "(<exp2c(lhs, byRef)>%<exp2c(rhs, byRef)>)";
    case add(lhs, rhs): 	return "(<exp2c(lhs, byRef)>+<exp2c(rhs, byRef)>)";
    case sub(lhs, rhs): 	return "(<exp2c(lhs, byRef)>-<exp2c(rhs, byRef)>)";
    case not(exp): 			return "(!<exp2c(exp, env)>)";
    case amp(lhs, rhs): 	return "(<exp2c(lhs, byRef)> && <exp2c(rhs, byRef)>)";
    case or(lhs, rhs): 		return "(<exp2c(lhs, byRef)> || <exp2c(rhs, byRef)>)";
    case eq(lhs, rhs): 		return "(<exp2c(lhs, byRef)> == <exp2c(rhs, byRef)>)";
    case neq(lhs, rhs): 	return "(<exp2c(lhs, byRef)> != <exp2c(rhs, byRef)>)";
    case lt(lhs, rhs): 		return "(<exp2c(lhs, byRef)> \< <exp2c(rhs, byRef)>)";
    case gt(lhs, rhs): 		return "(<exp2c(lhs, byRef)> \> <exp2c(rhs, byRef)>)";
    case leq(lhs, rhs): 	return "(<exp2c(lhs, byRef)> \<= <exp2c(rhs, byRef)>)";
    case geq(lhs, rhs): 	return "(<exp2c(lhs, byRef)> \>= <exp2c(rhs, byRef)>)";
    default: throw "Not a exp: <e>";
  }
}

public str var2c(Ident id, list[Selector] sels, ByRef byRef) {
  if (id in byRef) {
    return "(*<id.name>)<sels2c(sels, byRef)>";
  }
  return "<id.name><sels2c(sels, byRef)>";
}

public str sels2c(list[Selector] sels, ByRef byRef) {
  csels = for (s <- sels) {
    switch (s) {
      case field(Ident id): append ".<id.name>";
      case subscript(e): append "[<exp2c(e, byRef)>]";
    }
  }
  return ("" | it + cs | cs <- csels);
}



public str types2c(list[TypeDecl] tds) {
  return ("" | it + "typedef <type2c(td.\type)> <td.name.name>;\n" | td <- tds );
}

public str vars2c(list[VarDecl] vds) {
 return ("" | it + "<varType2c(n.name, vd.\type)>;\n" | vd <- vds, n <- vd.names );
}

public str consts2c(list[ConstDecl] cds) {
 return ("" | it + "#define <cd.name.name> <exp2c(cd.\value, {})>\n" | cd <- cds );
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
    default: return <"<type2c(t)>", "[<exp2c(bound, {})>]">;
  }
}

public str type2c(Type t) {
  switch (t) {
    case user(id("INTEGER")): return "int";
    case user(id("BOOLEAN")): return "int";
    case record(fs): return "struct {
<fields2c(fs)>}";
  }
  throw "Cannot happen";
}

public str fields2c(list[Field] fs) {
 return ("" | it + "<varType2c(n.name, f.\type)>;\n" | f <- fs, n <- f.names );
}







