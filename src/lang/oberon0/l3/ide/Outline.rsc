module lang::oberon0::l3::ide::Outline

extend lang::oberon0::l1::ide::Outline;
import lang::oberon0::l3::syntax::Declarations;
import lang::oberon0::l3::syntax::Statements;



public node outlineModule(Module x) {
	return outlineDecls(x.decls)[@label="<x.name>"];
}

// TODO finish this

Node outlineDecls(Declarations decls) {
	cds = outline([ constDecl()[@label="<cd.name>"][@\loc=cd@\loc] | /ConstDecl cd := decls.consts ])[@label="Constants"];
	tds = outline([ typeDecl()[@label="<td.name>"][@\loc=td@\loc] | /TypeDecl td := decls.types ])[@label="Types"];
	vds = outline([ varDecl()[@label="<vd.names>"][@\loc=vd@\loc] | /VarDecl vd := decls.vars ])[@label="Variables"];
 	return outline([cds, tds, vds]);
}