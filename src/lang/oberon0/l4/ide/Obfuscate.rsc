module lang::oberon0::l4::ide::Obfuscate

import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l4::format::Oberon0;
import lang::oberon0::l4::utils::Implode;
import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l4::normalize::ToMinimalOberon0;
import lang::box::util::Box2Text;

import String;

public str obfuscate(lang::oberon0::l1::syntax::Modules::Module x, loc l) {
	
	map[Ident,Ident] builtins(str ss...){
		return ( id(s) : id(s) | s <- ss);
	}

	lang::oberon0::l4::ast::Oberon0::Module mod = implode(x);
	mod = toMinimalOberon0(mod);
	nameCounter = 0;
	nameMap = builtins("Write","WriteLn","Read");
	mod.decls.procs = for(p <- mod.decls.procs) {
		newName = id("pro<nameCounter>");
		nameMap+=( p.name : newName );
		p.name = newName;
		p.endName = newName;
		nameCounter+=1;
		append p;
	}
	mod = visit(mod){
		case call(p,args) => call(nameMap[p],args)
	}
	return trim(format(mod2box(mod)));
}