module lang::oberon0::l3::ide::Outline

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::ide::Outline;
import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::syntax::Declarations;
import lang::oberon0::l3::syntax::Declarations;
import lang::oberon0::l3::syntax::Statements;
import ParseTree;


public node outlineModule(Module x) {
	return outlineDecls(x.decls)[@label="<x.name>"];
}

data Node = procDecls(list[Node] nodes);

Node outlineDecls(Declarations decls) {
	cds = outline([ constDecl()[@label="<cd.name>"][@\loc=cd@\loc] | /ConstDecl cd := decls.consts ])[@label="Constants"];
	tds = outline([ typeDecl()[@label="<td.name>"][@\loc=td@\loc] | /TypeDecl td := decls.types ])[@label="Types"];
	vds = outline([ varDecl()[@label="<vd.names>"][@\loc=vd@\loc] | /VarDecl vd := decls.vars ])[@label="Variables"];
	if (decls has procs) {
		pds = outline([])[@label="Procedures"];
		top-down-break visit (decls.procs) {
			case ProcedureDecl p: pds.nodes += 
					[procDecls(outlineDecls(p.decls).nodes)[@label="<p.name>"][@\loc=p@\loc]]; 
		}
	 	return outline([cds, tds, vds, pds]);
	 }
	 return outline([cds, tds, vds]);
}