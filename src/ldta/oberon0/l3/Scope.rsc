module ldta::oberon0::l3::Scope

import ldta::oberon0::l3::AST;
extend ldta::oberon0::l1::Scope;

data Decl 
  = proc(loc location, list[Formal] formals) 
  | param(loc location, Type \type, bool hasVar)
  ;

// Procedures carry their scope
anno NEnv Procedure@scope;

// Allow nesting of scopes.
data NEnv = nest(map[Ident, Decl] env, NEnv parent);

public bool isDefined(nest(env, _), Ident x) = env[x]?;
public bool isVisible(nest(env, p), Ident x) = (env[x]?) ? true : isVisible(p, x);
public Decl getDef(nest(env, p), Ident x) = (env[x]?) ? env[x] : getDef(p, x);
public NEnv define(s:nest(_, _), Ident x, Decl b) {
  s.env[x] = b;
  return s;
}


