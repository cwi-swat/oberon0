module lang::oberon0::l1::format::Oberon0

import lang::oberon0::l1::ast::Oberon0;
import lang::oberon0::l1::format::Priorities;

import lang::box::util::Box;
import List;

public Box mod2box(Module m) {
  return V([
    H([KW(L("MODULE")), H([id2box(m.name), L(";")])[@hs=0]])[@hs=1],
    decls2box(m.decls),
    body2box(m.body, m.endName)
  ])[@vs=1];
}

public Box body2box(list[Statement] body, Ident endName) {
    return V([
    KW(L("BEGIN")),
    I([
      V(hsepList(body, ";", stat2box))[@vs=0]
    ]),
    H([H([KW(L("END")), id2box(endName)])[@hs=1], L(".")])[@hs=0]
    ])[@vs=0];
}

public Box decls2box(decls(consts, types, vars)) = 
	V(consts2boxes(consts) + types2boxes(types) + vars2boxes(vars))[@vs=0];

public list[Box] consts2boxes(list[ConstDecl] consts) {
   	if (consts != []) {
     	return [KW(L("CONST")), 
     	  I([A([constDecl2box(x) | x <- consts])[@vs=0]])[@vs=0]];
   	}
   	return [];
}

public list[Box] types2boxes(list[TypeDecl] types) {
   	if (types != []) {
     	return [KW(L("TYPE")), I([A([typeDecl2box(x) | x <- types])[@vs=0]])[@vs=0]];
   	}
   	return [];
}

public list[Box] vars2boxes(list[VarDecl] vars) {
   	if (vars != []) {     
		return [KW(L("VAR")), I([A([varDecl2box(x) | x <- vars])[@vs=0]])[@vs=0]];
   	}
   	return [];
}


public Box constDecl2box(ConstDecl cd) {
 	return R([L(cd.name.name), L("="), H([exp2box(cd.\value), L(";")])[@hs=0]]);
}

public Box typeDecl2box(TypeDecl td) {
  	return R([L(td.name.name), L(":"), H([type2box(td.\type), L(";")])[@hs=0] ]);
}

public Box varDecl2box(VarDecl vd) {
  	return R([H(hsepList(vd.names, ",", id2box))[@hs=1], L(":"), H([type2box(vd.\type), L(";")])[@hs=0]]);
}

public Box stat2box(assign(Ident var, Expression exp)) = H([id2box(var), L(":="), exp2box(exp)])[@hs=1];

public Box stat2box(ifThen(Expression condition, list[Statement] body, list[tuple[Expression condition, list[Statement] body]] elseIfs, list[Statement] elsePart)) {
    ift = V([
        H([KW(L("IF")), exp2box(condition), KW(L("THEN"))])[@hs=1],
          I([V(hsepList(body, ";", stat2box))])]);
    elifs = for (<cond, ebody> <- elseIfs) {
      append V([
        H([KW(L("ELSIF")), exp2box(cond), KW(L("THEN"))])[@hs=1],
        I(hsepList(ebody, ";", stat2box))
      ]);
    }
    Box els;
    if(elsePart != []){
    	els = V([
        	KW(L("ELSE")),
        	I(hsepList(elsePart, ";", stat2box))
    	]);
    } else {
    	els = [];
    }
    return V([ift] + elifs + [els] + [KW(L("END"))]);
    
}
    
Box stat2box(whileDo(c, b)) = V([
            H([KW(L("WHILE")), exp2box(c), KW(L("DO"))])[@hs=1],
             I([V(hsepList(b, ";", stat2box))]),
            KW(L("END"))
        ]);   

public Box exp2box(nat(int val)) = L("<val>");
public Box exp2box(lookup(Ident var)) = id2box(var);
public Box exp2box(neg(arg)) = H([L("-"), exp2box(arg)])[@hs=0];
public Box exp2box(pos(arg)) = H([L("+"), exp2box(arg)])[@hs=0];
public Box exp2box(not(arg)) = H([L("~"), exp2box(arg)])[@hs=0];

public Box exp2box(p:mul(lhs, rhs)) = H([exp2box(p, lhs), L("*"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:div(lhs, rhs)) = H([exp2box(p, lhs), L("DIV"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:Expression::\mod(lhs, rhs)) = H([exp2box(p, lhs), L("MOD"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:amp(lhs, rhs)) = H([exp2box(p, lhs), L("&"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:add(lhs, rhs)) = H([exp2box(p, lhs), L("+"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:sub(lhs, rhs)) = H([exp2box(p, lhs), L("-"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:or(lhs, rhs)) = H([exp2box(p, lhs), L("OR"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:eq(lhs, rhs)) = H([exp2box(p, lhs), L("="), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:neq(lhs, rhs)) = H([exp2box(p, lhs), L("#"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:lt(lhs, rhs)) = H([exp2box(p, lhs), L("\<"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:gt(lhs, rhs)) = H([exp2box(p, lhs), L("\>"), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:leq(lhs, rhs)) = H([exp2box(p, lhs), L("\<="), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:geq(lhs, rhs)) = H([exp2box(p, lhs), L("\>="), exp2box(p, rhs)])[@hs=1];
public Box exp2box(p:geq(lhs, rhs)) = H([exp2box(p, lhs), L("\>="), exp2box(p, rhs)])[@hs=1];
  
public Box exp2box(Expression parent, Expression kid) =
  parens(oberon0Prios(), parent, kid, exp2box(kid), parenizer);

private Box parenizer(Box box) = H([L("("), box, L(")")])[@hs=0];


public Box type2box(user(Ident name)) = id2box(name);

public list[Box] hsepList(list[&T] elts, str sep, Box(&T) tobox) {
	if (elts == []) { 
     	return [];
    }
  	result = [];
  	Box lst = tobox(head(elts));
  	for (e <- tail(elts)) {
   		result += [H([lst, L(sep)])[@hs=0]];
   		lst = tobox(e);
  	}
  	return result + [lst];
}


public Box id2box(Ident id) {
	return VAR(L(id.name));
}


