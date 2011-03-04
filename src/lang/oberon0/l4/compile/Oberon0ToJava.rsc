module lang::oberon0::l4::compile::Oberon0ToJava

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l3::ast::Oberon0;
import lang::oberon0::l4::ast::Oberon0;

import lang::oberon0::l3::compile::AnnotateByRefs;

import String;
import List;

public str compile2Java(Module m) {
	return "
class <m.name.name> extends BaseProgram{
	<procs2Java(m.decls.procs)>
	public static void main(String[] argv) {
  		<stats2Java(m.body)>
	}
}
";
}

public str procs2Java(list[Procedure] procs) {
	return ( "" | it + proc2Java(p) | p <- procs );
}

public str proc2Java(Procedure p) {
 	return "
static void <p.name.name>() {
  <stats2Java(p.body)>
}
";
}

public str stats2Java(list[Statement] stats) {
  return ("" | it + stat2Java(s) + "\n" | s <- stats);
}

public str stat2Java(Statement stat) {
  switch (stat) {
    case assign(id("stack"), [subscript(s)], exp): return "stack[<intExp2Java(s)>] = <intExp2Java(exp)>;";
    case assign(id("sp"), [] , exp) : return "sp =  <intExp2Java(exp)>;";
    case call(id("assureStack_"),[nat(s)]) : return "assureStack_(<s>);";
    case call(id("copy_"),[destPointer,sourcePointer,nat(s)]) :
    	 return "copy_(<intExp2Java(destPointer)>,<intExp2Java(sourcePointer)>,<s>);";
    case call(Ident id, []): return "<id.name>();"; 
    case ifThen(c, b, eis, ep):
      return "
if (<boolExp2Java(c)>) {
  <stats2Java(b)>
}
<for (ei <- eis) {>
else if (<boolExp2Java(ei[0])>) {
  <stats2Java(ei[1])>
}
<}>
<if (ep != []) {>
else {
  <stats2Java(ep)>
}
<}>";
    
    case whileDo(c, b): return "
while (<boolExp2Java(c)>) {
   <stats2Java(b)>
 }";
 
 	default: throw "unhandled statement : <stat>";
  }
}

str boolExp2Java(Expression e) {
	switch (e) {
	    case nat(int val): 		return "<val> == 1";
	    case lookup(id("stack"), [subscript(exp)]): return "stack[<intExp2Java(exp)>] == 1";
	    case not(exp): return "(!<boolExp2Java(exp)>)";
	    case amp(lhs, rhs): return "(<boolExp2Java(lhs)> &&  <boolExp2Java(rhs)>)";
	    case or(lhs, rhs) : return "(<boolExp2Java(lhs)> ||  <boolExp2Java(rhs)>)";
	    case eq(lhs, rhs) : return "(<intExp2Java(lhs)> ==  <intExp2Java(rhs)>)";
	    case neq(lhs, rhs): return "(<intExp2Java(lhs)> !=  <intExp2Java(rhs)>)";
	    case lt(lhs, rhs) : return "(<intExp2Java(lhs)> \<  <intExp2Java(rhs)>)";
	    case gt(lhs, rhs) : return "(<intExp2Java(lhs)> \>  <intExp2Java(rhs)>)";
	    case leq(lhs, rhs): return "(<intExp2Java(lhs)> \<= <intExp2Java(rhs)>)";
	    case geq(lhs, rhs): return "(<intExp2Java(lhs)> \>= <intExp2Java(rhs)>)";
	    default: throw "Not a Boolean exp: <e>";
  }		
}


str intExp2Java(Expression e) {
  switch (e) {
    case nat(int val): 		return "<val>";
    case lookup(id("sp"), []) : return "sp";
    case lookup(id("stack"), [subscript(exp)]): return "stack[<intExp2Java(exp)>]";
    case neg(exp): 			return "(-<intExp2Java(exp)>)";
    case pos(exp): 			return intExp2Java(exp);
    case mul(lhs, rhs): 	return "(<intExp2Java(lhs)>*<intExp2Java(rhs)>)";
    case div(lhs, rhs): 	return "(<intExp2Java(lhs)>/<intExp2Java(rhs)>)";
    case mod(lhs, rhs): 	return "(<intExp2Java(lhs)>%<intExp2Java(rhs)>)";
    case add(lhs, rhs): 	return "(<intExp2Java(lhs)>+<intExp2Java(rhs)>)";
    case sub(lhs, rhs): 	return "(<intExp2Java(lhs)>-<intExp2Java(rhs)>)";
    default: throw "Not a Integer exp: <e>";
  }
}