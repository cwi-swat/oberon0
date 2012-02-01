module ldta::oberon0::l3::Check

import ldta::oberon0::l3::AST;
import ldta::oberon0::l3::Scope;
extend ldta::oberon0::l2::Check;
import IO;
import List;

public Message lvalueErr(loc l) = error("Not an lvalue", l);
public Message argNumErr(loc l) = error("Wrong number of arguments", l);

public bool isLValue(lookup(x)) = !((x@decl) is const);
public default bool isLValue(Expression _) = false;


public set[Message] check(decls(cds, tds, vds, pds)) =
  ( check(decls(cds, tds, vds)) | it + check(pd) | pd <- pds );
  
public set[Message] check(Procedure::proc(_, fs, ds, b, _)) = 
   check(ds) + checkBody(b) + checkFormals(fs);
   
public default set[Message] checkFormals(list[Formal] fs) = {};     

public set[Message] check(s:call(f, as)) {
  if (!(f@decl)?) {
    return {}; // name error
  }
  fs = (f@decl).formals;
  fsize = ( 0 | it + size(ns) | formal(_, ns, _) <- fs );
  errs = { argNumErr(s@location) | (size(as) < fsize || size(as) > fsize) };
  
  int i = 0;
  for (frm <- fs, n <- frm.names, i < size(as)) {
    // types in formals annos (e.g. fs) have ben evaluated)
    errs += checkFormal(frm, as[i]);
    i += 1; 
  }
  
  return  ( errs | it + check(a) | a <- as);
}

public set[Message] checkFormal(Formal frm, Expression exp) =
    { incompErr(exp@location) | !typeEq(typeOf(exp), frm.\type) }
      + { lvalueErr(exp@location) | frm.hasVar, !isLValue(exp) };
   


