module ldta::oberon0::l3::Format


import lang::box::util::Box;
import ldta::oberon0::l3::AST;
extend ldta::oberon0::l2::Format;



public Box decls2box(decls(consts, types, vars, procs)) =
  V([consts2boxes(consts) + types2boxes(types) + vars2boxes(vars), V([proc2box(x) | x <- procs])[@vs=1]])[@vs=0];


public Box stat2box(call(Ident proc, list[Expression] args)) = 
  H([id2box(proc), L("("),  H(hsepList(args, ",", exp2box))[@hs=1],  L(")")])[@hs=0];


public Box proc2box(Procedure pr) =
  V([
    H([KW(L("PROCEDURE")), H([id2box(pr.name), L("("), hsepList(pr.formals, ";", formal2box), L(")"), L(";")])[@hs=0]])[@hs=1],
    I([
      decls2box(pr.decls)
    ])[@vs=1],
    KW(L("BEGIN")),
    I([
      V(hsepList(pr.body, ";", stat2box))[@vs=0]
    ]),
    H([H([KW(L("END")), id2box(pr.endName)])[@hs=1], L(";")])[@hs=0]
  ])[@vs=0];

public Box formal2box(Formal form) {
  result = H([])[@hs=1];
  if (form.hasVar) {
    result.h += [KW(L("VAR"))];
  }
  result.h += [H([H(hsepList(form.names, ",", id2box))[@hs=1], L(":")])[@hs=0]];
  result.h += [type2box(form.\type)];
  return result;
}




