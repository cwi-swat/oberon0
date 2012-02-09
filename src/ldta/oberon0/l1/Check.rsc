module ldta::oberon0::l1::Check

import ldta::oberon0::l1::AST;
import ldta::oberon0::l1::Bind;
import ldta::oberon0::l1::Scope;
import Message;

// presupposes name binding to have occurred.

public Message notATypeErr(loc l) = error("Not a type", l);
public Message notAVarOrConstErr(loc l) = error("Not a variable/constant", l);
public Message notAConstErr(loc l) = error("Not a constant", l);
public Message cannotEvalConstErr(loc l) = error("Cannot evaluate constant", l);
public Message notAVarErr(loc l) = error("Not a variable", l);
public Message divZeroErr(loc l) = error("Division by zero", l);

public Message intErr(loc l) = error("Expected int", l);
public Message boolErr(loc l) = error("Expected bool", l);
public Message incompErr(loc l) = error("Incompatible types", l);
public Message assignErr(loc l) = error("Invalid type for assignment", l);
public Message invalidExpErr(loc l) = error("Invalid expression", l);

public bool isWritable(Decl::var(_, _)) = true;
public default bool isWritable(Decl _) = false;

public bool isReadable(Decl::var(_, _)) = true;
public bool isReadable(Decl::const(_, _)) = true;
public default bool isReadable(Decl _) = false;

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
  
public set[Message] check(cd:constDecl(n, e)) = 
  { intErr(cd@location) | !isInt(typeOf(e)) } + evalConst(e); 

// Statements
public set[Message] check(assign(v, e)) =
  check(e) + { assignErr(v@location) | isWritable(v@decl), !typeEq((v@decl).\type, typeOf(e)) }
//    + { invalidExpErr(e@location) | isBoolExp(e) }
    + { notAVarErr(v@location) | !isWritable(v@decl) };
     
public default bool isBoolExp(Expression e) = false;

public set[Message] check(ifThen(c, b, eis, e)) =
  ( checkCond(c) + checkBody(b) + checkBody(e) | it + checkCond(ec) + checkBody(eb) | <ec, eb> <- eis ); 

public set[Message] check(whileDo(c, b)) = checkCond(c) + checkBody(b);

public set[Message] check(skip()) = {};

public set[Message] checkCond(Expression c) = 
 check(c) + { boolErr(c@location) | !typeEq(typeOf(c), boolType()) };
  
public set[Message] checkBody(list[Statement] b) = ({} | it + check(s) | s <- b );

// Expressions

public set[Message] check(lookup(x)) = 
  { notAVarOrConstErr(x@location) | !(x@decl is trueOrFalse), !isReadable(x@decl) };

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

public Type typeOf(lookup(x)) = intType() when x@decl is const;
public Type typeOf(lookup(x)) = boolType() when x@decl is trueOrFalse;
public Type typeOf(lookup(x)) = x@decl.\type when x@decl is var;

public set[Message] evalConst(Expression e) {
  solve (e) {
    e = visit (e) {
      case pos(nat(a)) => nat(a)
      case neg(nat(a)) => nat(- a)
      case add(nat(a), nat(b)) => nat(a + b)
      case sub(nat(a), nat(b)) => nat(a - b)
      case mul(nat(a), nat(b)) => nat(a * b)
      case div(nat(a), nat(0)): return {divZeroErr(e@location)};
      case div(nat(a), nat(b)) => nat(a / b)
      case \mod(nat(a), nat(0)): return {divZeroErr(e@location)};
      case \mod(nat(a), nat(b)) => nat(a mod b)
      case a:lookup(x) => xe when const(_, xe) := x@decl
    }
  }
  return { cannotEvalConstErr(e@location) | !(e is nat) };
}

