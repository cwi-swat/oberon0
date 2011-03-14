module lang::oberon0::l1::compile::Oberon0ToC

import lang::oberon0::l1::ast::Oberon0;
import String;
import List;

public str compile2c(Module m) {
	return mod2c(m);
}

public str mod2c(Module m) {
return "
<decls2c(m.decls)>
<body2c(m.body)>
";
}

public str decls2c(Declarations decls) {
	return "<consts2c(decls.consts)>
<types2c(decls.types)>
<vars2c(decls.vars)>";
}

public str body2c(list[Statement] stats) {
	return "int main(int argc, char **argv) {
           '    <stats2c(stats)>
           '}";
}

public str stats2c(list[Statement] stats) {
  return intercalate("\n", [ stat2c(s) | s <- stats ]);
}

public str stat2c(assign(v, exp)) = "<v.name> = <exp2c(exp)>;";

public str stat2c(ifThen(c, b, eis, ep)) = "if (<exp2c(c)>) {
                                           '    <stats2c(b)>
                                           '}
										   '<for (ei <- eis) {>
										       'else if (<exp2c(ei[0])>) {
										       '    <stats2c(ei[1])>
										       '}
										   '<}>
										   '<if (ep != []) {>
										        'else {
										        '    <stats2c(ep)>
										        '}
										   '<}>";
    
public str stat2c(whileDo(c, b)) = "while (<exp2c(c)>) {
                                   '    <stats2c(b)>
                                   '}";

public str exp2c(nat(int val)) = "<val>";
public str exp2c(\true()) = "1";
public str exp2c(\false()) = "0";
public str exp2c(lookup(v)) = v.name;
public str exp2c(neg(exp)) = "(-<exp2c(exp)>)";
public str exp2c(pos(exp)) = exp2c(exp);
public str exp2c(mul(lhs, rhs)) = "(<exp2c(lhs)>*<exp2c(rhs)>)";
public str exp2c(div(lhs, rhs)) = "(<exp2c(lhs)>/<exp2c(rhs)>)";
public str exp2c(Expression::mod(lhs, rhs)) = "(<exp2c(lhs)>%<exp2c(rhs)>)";
public str exp2c(add(lhs, rhs)) = "(<exp2c(lhs)>+<exp2c(rhs)>)";
public str exp2c(sub(lhs, rhs)) = "(<exp2c(lhs)>-<exp2c(rhs)>)";
public str exp2c(not(exp)) = "(!<exp2c(exp)>)";
public str exp2c(amp(lhs, rhs)) = "(<exp2c(lhs)> && <exp2c(rhs)>)";
public str exp2c(or(lhs, rhs)) = "(<exp2c(lhs)> || <exp2c(rhs)>)";
public str exp2c(eq(lhs, rhs)) = "(<exp2c(lhs)> == <exp2c(rhs)>)";
public str exp2c(neq(lhs, rhs)) = "(<exp2c(lhs)> != <exp2c(rhs)>)";
public str exp2c(lt(lhs, rhs)) = "(<exp2c(lhs)> \< <exp2c(rhs)>)";
public str exp2c(gt(lhs, rhs)) = "(<exp2c(lhs)> \> <exp2c(rhs)>)";
public str exp2c(leq(lhs, rhs)) = "(<exp2c(lhs)> \<= <exp2c(rhs)>)";
public str exp2c(geq(lhs, rhs)) = "(<exp2c(lhs)> \>= <exp2c(rhs)>)";


public str types2c(list[TypeDecl] tds) {
	return ("" | it + "typedef <type2c(td.\type)> <td.name.name>;\n" | td <- tds );
}

public str vars2c(list[VarDecl] vds) {
	return ("" | it + "<varType2c(n.name, vd.\type)>;\n" | vd <- vds, n <- vd.names );
}

public str consts2c(list[ConstDecl] cds) {
	return ("" | it + "#define <cd.name.name> <exp2c(cd.\value)>\n" | cd <- cds );
}

public str default varType2c(str v, Type t) = "<type2c(t)> <v>";

public str type2c(user(id("INTEGER"))) = "int";
public str type2c(user(id("BOOLEAN"))) = "int";








