module ldta::oberon0::l1::Check

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::Bind;
import ldta::oberon0::l1::Scope;
import Message;

// presupposes name binding to have occurred.

public Message intErr(loc l) = error("Expected int", l);
public Message boolErr(loc l) = error("Expected bool", l);
public Message incompErr(loc l) = error("Incompatible types", l);
public Message assignErr(loc l) = error("Invalid type for assignment", l);
public Message invalidExpErr(loc l) = error("Invalid expression", l);


public bool isInt(Type t) = typeEq(t, intType());
public bool isBool(Type t) = typeEq(t, boolType());
public Type intType() = user(id("INTEGER"));
public Type boolType() = user(id("BOOLEAN"));

public bool typeEq(\type(l1, t1), \type(l2, t2)) = l1 == l2;

public bool typeEq(user(x), user(x)) = true
   when x.name in {"BOOLEAN", "INTEGER"};
   
public bool typeEq(user(x), user(y)) = typeEq(x@decl, y@decl)
  when {x.name, y.name} & {"BOOLEAN", "INTEGER"} == {};
      
public default bool typeEq(Type t1, Type t2) = false;
 

public set[Message] check(Module::\mod(n, ds, b, n1)) = check(ds) + checkBody(b);

// Declarations
public set[Message] check(decls(cds, _, _)) = ( {} | it + check(cd) | cd <- cds );
  
public set[Message] check(cd:constDecl(n, e)) = { intErr(cd@location) | !isInt(typeOf(e)) }; 

// Statements
public set[Message] check(assign(v, e)) =
  check(e) + { assignErr(v@location) | (v@decl)?, !typeEq((v@decl).\type, typeOf(e)) }
    + { invalidExpErr(e@location) | isBoolExp(e) };
     
public default bool isBoolExp(Expression e) = false;
     

public set[Message] check(ifThen(c, b, eis, e)) =
  ( checkCond(c) + check(c) + checkBody(b) + checkBody(e) | 
    it + checkCond(ec) + check(ec) + checkBody(eb) | <ec, eb> <- eis ); 

public set[Message] check(whileDo(c, b)) = checkCond(c) + check(c) + checkBody(b);

public set[Message] check(skip()) = {};

public set[Message] checkCond(Expression c) = { boolErr(c@location) | !typeEq(typeOf(c), boolType()) };
  
public set[Message] checkBody(list[Statement] b) = ({} | it + check(s) | s <- b );

// Expressions
public set[Message] check(neg(e)) = check(e) + { intErr(e@location)| !isInt(typeOf(e)) };  

public set[Message] check(pos(e)) = check(e) + { intErr(e@location)| !isInt(typeOf(e)) };  
         
public set[Message] check(not(e)) = check(e) + {boolErr(e@location) | !isBool(typeOf(e)) };
   
public set[Message] check(mul(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };
   
public set[Message] check(div(e1, e2)) = check(e1) + check(e2) + 
    {intErr(e1@location) | !isInt(typeOf(e1)) } + {intErr(e2@location) | !isInt(typeOf(e2)) };
 
public set[Message] check(Expression::\mod(e1, e2)) = check(e1) + check(e2) + 
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
    {incompErr(o@location) | !(isInt(typeOf(e1)) && isInt(typeOf(e2))) };
 
public set[Message] check(o:neq(e1, e2)) = check(e1) + check(e2) + 
    {incompErr(o@location) | !(isInt(typeOf(e1)) && isInt(typeOf(e2))) };

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
public Type typeOf(neg(e)) = intType();
public Type typeOf(pos(e)) = intType();
public Type typeOf(not(e)) = boolType();
public Type typeOf(mul(e1, e2)) = intType();
public Type typeOf(div(e1, e2)) = intType();
public Type typeOf(Expression::\mod(e1, e2)) = intType(); 
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
    if (d is trueOrFalse) {
      return boolType();
    }
    return d.\type;
  }
  return INVALID();
}
