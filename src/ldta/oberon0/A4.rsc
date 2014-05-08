module ldta::oberon0::A4

import ldta::oberon0::l4::Implode;
import ldta::oberon0::l4::Parse;
import ldta::oberon0::l4::Check;
import ldta::oberon0::l4::Bind;
import ldta::oberon0::l4::Format;
import ldta::oberon0::l4::CompileToC;
import ldta::oberon0::l2::Desugar;
import ldta::oberon0::l3::Scope;
import ldta::oberon0::l3::Lift;

import Message;
import ParseTree;
import lang::box::util::Box2Text;

public Tree parseL4(loc l) = parse(l);
public Tree parseL4(str src, loc l) = parse(src, l);

public str formatL4(loc l) = format(mod2box(implode(parse(l))));

public set[Message] bindL4(loc l) = errs
  when
    <_, errs> := bindModule(implode(parse(l)), GLOBALS()); 

public set[Message] checkL4(loc l) = check(m)
  when
    <m, {}> := bindModule(implode(parse(l)), GLOBALS()); 

public str compileL4(loc l) = compileL4toC(lift(m))
  when
    <m, _> := bindModule(desugar(implode(parse(l))), GLOBALS());

