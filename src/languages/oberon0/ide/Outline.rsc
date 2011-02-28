module languages::oberon0::ide::Outline

import languages::oberon0::syntax::Oberon0;
import languages::oberon0::syntax::Declarations;
import languages::oberon0::syntax::Statements;
import languages::oberon0::syntax::Expressions;
import languages::oberon0::syntax::Lexical;
import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Types;

import ParseTree; // for loc annos

data Node
	= outline(list[Node] nodes)
	| constDecl()
	| varDecl()
	| typeDecl()
	| proc(list[Node] nodes)
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
	pds = outline([ outlineDecls(p.decls)[@label="<p.name>"][@\loc=p@\loc] | ProcedureDecl p <- decls.procs ])[@label="Procedures"];
 	return outline([cds, tds, vds, pds]);
}