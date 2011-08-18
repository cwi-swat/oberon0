module ldta::oberon0::l4::Format

import ldta::oberon0::l4::AST;
extend ldta::oberon0::l3::Format;

import lang::box::util::Box;
import List;


public Box sel2box(Selector sel) {
  switch (sel) {
    case field(Ident field): return H([L("."),id2box(field)])[@hs=0];
    case subscript(Expression exp): return H([L("["),exp2box(exp), L("]")])[@hs=0];
  }
}

public Box exp2box(lookup(Ident var, list[Selector] selectors)) = var2box(var, selectors);

public Box var2box(Ident var, list[Selector] selectors) =
  H([id2box(var)] + [ sel2box(s) | s <- selectors ])[@hs=0];

public Box stat2box(assign(Ident var, list[Selector] selectors, Expression exp)) = H([var2box(var, selectors), L(":="), exp2box(exp)])[@hs=1];

public default Box stat2box(Statement s) { throw "Unhandeled <s>"; }

public Box type2box(array(Expression exp, Type t)) = H([KW(L("ARRAY")), exp2box(exp), KW(L("OF")), type2box(t)])[@hs=1];

public Box type2box(record(list[Field] fields)) =
  (fields == []) ? H([KW(L("RECORD")), KW(L("END"))])[@hs=1]
   	: V([KW(L("RECORD")), I(hsepList(fields, ";", field2box)), KW(L("END"))]);


public Box field2box(Field field) =
  H([H([H(hsepList(field.names, ",", id2box))[@hs=1], L(":")])[@hs=0], type2box(field.\type)])[@hs=1];

