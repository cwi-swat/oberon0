module lang::oberon0::l1::ide::Outline

import lang::oberon0::l1::\syntax::Modules;
import lang::oberon0::l1::\syntax::Declarations;
import lang::oberon0::l1::\syntax::Expressions;
import lang::oberon0::l1::\syntax::Statements;
import lang::oberon0::l1::\syntax::Types;
import lang::oberon0::l1::\syntax::Lexical;
import lang::oberon0::l1::\syntax::Layout;


import ParseTree; // for loc annos

data Node
	= outline(list[Node] nodes)
	| constDecl()
	| varDecl()
	| typeDecl()
	;	

anno str Node@label;
anno loc Node@\loc;

public node outlineModule(Module x) {
	return outlineDecls(x.decls)[@label="<x.name>"];
}

Node outlineDecls(Declarations decls) {
	cds = outline([ constDecl()[@label="<cd.name>"][@\loc=cd@\loc] | /ConstDecl cd := decls.consts ])[@label="Constants"];
	tds = outline([ typeDecl()[@label="<td.name>"][@\loc=td@\loc] | /TypeDecl td := decls.types ])[@label="Types"];
	vds = outline([ varDecl()[@label="<vd.names>"][@\loc=vd@\loc] | /VarDecl vd := decls.vars ])[@label="Variables"];
 	return outline([cds, tds, vds]);
}