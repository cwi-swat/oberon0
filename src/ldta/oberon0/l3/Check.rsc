module ldta::oberon0::l3::Check

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;
extend ldta::oberon0::l2::Check;
import IO;
import List;

public Message lvalueErr(loc l) = error("Not an lvalue", l);
public Message argNumErr(loc l) = error("Wrong number of arguments", l);

// TODO: what with record fields and array derefs?
public bool isLValue(lookup(x)) = isWritable(x@decl);
public default bool isLValue(Expression _) = false;

public Message notAProcErr(loc l) = error("Not a procedure", l);

public bool isCallable(Decl::proc(_, _)) = true;
public default bool isCallable(Decl _) = false;

public bool isWritable(param(_, _, _)) = true;
public bool isReadable(param(_, _, _)) = true;



public set[Message] check(decls(cds, tds, vds, pds)) =
  ( check(decls(cds, tds, vds)) | it + check(pd) | pd <- pds );
  
public set[Message] check(Procedure::proc(_, fs, ds, b, _)) = 
   check(ds) + checkBody(b) + checkFormals(fs);
   
public default set[Message] checkFormals(list[Formal] fs) = {};     

public set[Message] check(s:call(f, as)) {
  if (!isCallable(f@decl)) {
    return { notAProcErr(f@location) };
  }
  fs = (f@decl).formals;
  arity = ( 0 | it + size(ns) | formal(_, ns, _) <- fs );
  errs =  {};
  if (size(as) < arity || size(as) > arity) {
    errs += { argNumErr(s@location) };
  }
  else {
    i = 0;
    for (frm <- fs, n <- frm.names) {
      errs += checkFormal(n, as[i], frm.hasVar);
      i += 1;
    }
  }
  return  ( errs | it + check(a) | a <- as);
}

public Type typeOf(lookup(x)) = x@decl.\type when x@decl is param;

public set[Message] checkFormal(Ident n, Expression exp, bool hasVar) =
    { incompErr(exp@location) | !typeEq(typeOf(exp), n@decl.\type) }
      + { lvalueErr(exp@location) | hasVar, !isLValue(exp) };
   


