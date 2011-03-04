module lang::oberon0::normalize::Utils

import lang::oberon0::ast::Oberon0;

alias Env = map[Ident, Ident];

public Ident TOPLEVEL_SCOPE = id("");

public Ident longName(Ident scope, Ident name) {
	if (scope.name == "") {
		return name;
	}
	return id(scope.name + "_" + name.name);
}

public Ident newScope(Ident scope, Ident name) = longName(scope, name);

public Env initEnv(set[str] names) {
	return ( id(n): id(n) | n <- names ); 
}
