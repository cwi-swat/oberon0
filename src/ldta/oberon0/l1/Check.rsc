module ldta::oberon0::l1::Check

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::Bind;
import ldta::oberon0::l1::Scope;
import Message;

// presupposes name binding to have occurred.

data Type = INVALID();

public Message intErr(loc l) = error(l, "Expected int");
public Message boolErr(loc l) = error(l, "Expected bool");
public Message incompErr(loc l) = error(l, "Incompatible types");
public Message assignErr(loc l) = error(l, "Invalid type for assignment");


public bool isInt(Type t) = t == intType();
public bool isBool(Type t) = t == boolType();
public Type intType() = user(id("INTEGER"));
public Type boolType() = user(id("BOOLEAN"));


public set[Message] check(Module::mod(n, ds, b, n1)) = check(ds) + checkBody(b);

// Declarations
public set[Message] check(decls(cds, _, _)) = ( {} | it + check(cd) | cd <- cds );
  
public set[Message] check(cd:constDecl(n, e)) = { intErr(cd@location) | !isInt(typeOf(e)) }; 

// Statements
public set[Message] check(assign(v, e)) =
  check(e) + { assignErr(v@location) | (v@decl)?, (v@decl).\type != typeOf(e) };

public set[Message] check(ifThen(c, b, eis, e)) =
  ( checkCond(c) + check(c) + checkBody(b) + checkBody(e) | 
    it + checkCond(ec) + check(ec) + checkBody(eb) | <ec, eb> <- eis ); 

public set[Message] check(whileDo(c, b)) = checkCond(c) + check(c) + checkBody(b);

public set[Message] check(skip()) = {};

public set[Message] checkCond(Expression c) = { boolErr(c@location) | typeOf(c) != boolType() };
  
public set[Message] checkBody(list[Statement] b) = ({} | it + check(s) | s <- b );

// Expressions
public set[Message] check(neg(e)) = check(e) + { intErr(e@location)| !isInt(typeOf(e)) };  

public set[Message] check(pos(e)) = check(e) + { intErr(e@location)| !isInt(typeOf(e)) };  
         
public set[Message] check(not(e)) = check(e) + {boolErr(e@location) | !isBool(typeOf(e)) };
   
public set[Message] check(mul(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };
   
public set[Message] check(div(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };
 
public set[Message] check(Expression::mod(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };

public set[Message] check(add(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };

public set[Message] check(sub(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };

public set[Message] check(amp(e1, e2)) = check(e1) + check(e2) + 
    {boolErr(e1@location) | !isBool(typeOf(e1)) } + {boolErr(e2@location) | !isBool(typeOf(e2)) };

public set[Message] check(or(e1, e2)) = check(e1) + check(e2) + 
    {boolErr(e1@location) | !isBool(typeOf(e1)) } + {boolErr(e2@location) | !isBool(typeOf(e2)) };
 
public set[Message] check(o:eq(e1, e2)) = check(e1) + check(e2) + 
    {incompErr(o@location) | typeOf(e1) != typeOf(e2) };
 
public set[Message] check(o:neq(e1, e2)) = check(e1) + check(e2) + 
    {incompErr(o@location) | typeOf(e1) != typeOf(e2) };

public set[Message] check(gt(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };

 
public set[Message] check(lt(e1, e2)) = check(e1) + check(e2) + 
  {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };

public set[Message] check(geq(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };

public set[Message] check(leq(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };
    
// otherwise: no errors
public default set[Message] check(Expression e) = {};


// Obtain the type of an expression
public Type typeOf(nat(_)) = intType();
public Type typeOf(\true()) = boolType();
public Type typeOf(\false()) = boolType();
public Type typeOf(neg(e)) = intType();
public Type typeOf(pos(e)) = intType();
public Type typeOf(not(e)) = boolType();
public Type typeOf(mul(e1, e2)) = intType();
public Type typeOf(div(e1, e2)) = intType();
public Type typeOf(Expression::mod(e1, e2)) = intType(); 
public Type typeOf(add(e1, e2)) = intType();
public Type typeOf(sub(e1, e2)) = intType();
public Type typeOf(amp(e1, e2)) = boolType();
public Type typeOf(or(e1, e2)) = boolType();
public Type typeOf(eq(e1, e2)) = boolType();
public Type typeOf(neq(e1, e2)) = boolType();
public Type typeOf(gt(e1, e2)) = boolType();
public Type typeOf(lt(e1, e2)) = boolType();
public Type typeOf(geq(e1, e2)) = boolType();
public Type typeOf(leq(e1, e2)) = boolType();

public Type typeOf(lookup(x)) {
  if ((x@decl)?) {
    d = x@decl;
    if (d is const) {
      return intType();
    }
    return d.\type;
  }
  return INVALID();
}
