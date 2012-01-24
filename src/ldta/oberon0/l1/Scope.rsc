module ldta::oberon0::l1::Scope

import ldta::oberon0::l1::AST;

anno Decl Ident@decl;

data Decl 
  = var(loc location, Type \type) 
  | const(loc location, Expression exp) 
  | \type(loc location, Type \type)
  | trueOrFalse(bool val);

data NEnv = scope(map[Ident, Decl] env);
  
public bool isDefined(scope(env), Ident x) = env[x]?;
public bool isVisible(scope(env), Ident x) = env[x]?;
public Decl getDef(scope(env), Ident x) = env[x];
public NEnv define(s:scope(_), Ident x, Decl b) {
  s.env[x] = b;
  return s;
}