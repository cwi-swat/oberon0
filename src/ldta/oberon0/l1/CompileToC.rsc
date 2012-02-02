module ldta::oberon0::l1::CompileToC

import ldta::oberon0::l1::AST;
import String;
import List;

public str compile2c(Module m) = mod2c(m);

public str mod2c(Module m) = "<decls2c(m.decls)>\n<body2c(m.body)>";

public str decls2c(Declarations decls) = "<consts2c(decls.consts)>\n<types2c(decls.types)>\n<vars2c(decls.vars)>";

public str body2c(list[Statement] stats) = "int main(int argc, char **argv) {
                                           '    <stats2c(stats)>
                                           '}";

public str stats2c(list[Statement] stats) = intercalate("\n", [ stat2c(s) | s <- stats ]);

public str stat2c(assign(v, exp)) = "<var2c(v)> = <exp2c(exp)>;";

public str stat2c(ifThen(c, b, eis, ep)) = 
   "if (<exp2c(c)>) {
   '    <stats2c(b)>
   '}<for (ei <- eis) {>
   'else if (<exp2c(ei[0])>) {
   '    <stats2c(ei[1])>
   '}
   '<}><if (ep != []) {>
   'else {
   '    <stats2c(ep)>
   '}
   '<}>";

public str stat2c(whileDo(c, b)) = "while (<exp2c(c)>) {
                                   '    <stats2c(b)>
                                   '}";

public str stat2c(skip()) = ";";

public str exp2c(nat(int val)) = "<val>";
public str exp2c(lookup(v)) = var2c(v)
  when !(v@decl is trueOrFalse);

public str exp2c(lookup(v)) = (v@decl).val ? "1" : "0"
  when v@decl is trueOrFalse;
  
public str exp2c(neg(exp)) = "(-<exp2c(exp)>)";
public str exp2c(pos(exp)) = exp2c(exp);
public str exp2c(mul(lhs, rhs)) = "(<exp2c(lhs)> * <exp2c(rhs)>)";
public str exp2c(div(lhs, rhs)) = "(<exp2c(lhs)> / <exp2c(rhs)>)";
public str exp2c(Expression::\mod(lhs, rhs)) = "(<exp2c(lhs)> % <exp2c(rhs)>)";
public str exp2c(add(lhs, rhs)) = "(<exp2c(lhs)> + <exp2c(rhs)>)";
public str exp2c(sub(lhs, rhs)) = "(<exp2c(lhs)> - <exp2c(rhs)>)";
public str exp2c(not(exp)) = "(!<exp2c(exp)>)";
public str exp2c(amp(lhs, rhs)) = "(<exp2c(lhs)> && <exp2c(rhs)>)";
public str exp2c(or(lhs, rhs)) = "(<exp2c(lhs)> || <exp2c(rhs)>)";
public str exp2c(eq(lhs, rhs)) = "(<exp2c(lhs)> == <exp2c(rhs)>)";
public str exp2c(neq(lhs, rhs)) = "(<exp2c(lhs)> != <exp2c(rhs)>)";
public str exp2c(lt(lhs, rhs)) = "(<exp2c(lhs)> \< <exp2c(rhs)>)";
public str exp2c(gt(lhs, rhs)) = "(<exp2c(lhs)> \> <exp2c(rhs)>)";
public str exp2c(leq(lhs, rhs)) = "(<exp2c(lhs)> \<= <exp2c(rhs)>)";
public str exp2c(geq(lhs, rhs)) = "(<exp2c(lhs)> \>= <exp2c(rhs)>)";

public default str var2c(Ident x) = x.name;

public str types2c(list[TypeDecl] tds) = ("" | it + "typedef <type2c(td.\type)> <td.name.name>;\n" | td <- tds );

public str vars2c(list[VarDecl] vds) = ("" | it + "<varType2c(n.name, vd.\type)>;\n" | vd <- vds, n <- vd.names );

public str consts2c(list[ConstDecl] cds) = ("" | it + "#define <cd.name.name> <exp2c(cd.\value)>\n" | cd <- cds );

public default str varType2c(str v, Type t) = "<type2c(t)> <v>";

public str type2c(user(id("INTEGER"))) = "int";
public str type2c(user(id("BOOLEAN"))) = "int";
public default str type2c(user(x)) = x.name;








