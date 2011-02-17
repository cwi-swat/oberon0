module languages::oberon0::compile::Test

import languages::oberon0::syntax::Oberon0;
import languages::oberon0::ast::Oberon0;
import languages::oberon0::compile::Resolve;
import languages::oberon0::compile::Oberon0ToC;

import ParseTree;
import Node;
import IO;


public Module quicksort =
mod(id("QuickSort"),decls([constDecl(id("INPUTLENGTH"),nat(4))],[],[varDecl([id("input")],array(lookup(id("INPUTLENGTH"),[]),user(id("INTEGER")))),varDecl([id("i")],user(id("INTEGER")))],[proc(id("QuickSort"),[formal(true,[id("array")],array(lookup(id("INPUTLENGTH"),[]),user(id("INTEGER")))),formal(false,[id("left"),id("right")],user(id("INTEGER")))],decls([],[],[varDecl([id("pivot"),id("leftIdx"),id("rightIdx")],user(id("INTEGER")))],[proc(id("Swap"),[formal(true,[id("x"),id("y")],user(id("INTEGER")))],decls([],[],[varDecl([id("temp")],user(id("INTEGER")))],[]),[assign(id("temp"),[],lookup(id("x"),[])),assign(id("x"),[],lookup(id("y"),[])),assign(id("y"),[],lookup(id("temp"),[]))],id("Swap"))]),[assign(id("leftIdx"),[],lookup(id("left"),[])),assign(id("rightIdx"),[],lookup(id("right"),[])),ifThen(gt(sub(lookup(id("right"),[]),lookup(id("left"),[])),nat(0)),[assign(id("pivot"),[],div(add(lookup(id("left"),[]),lookup(id("right"),[])),nat(2))),whileDo(amp(leq(lookup(id("leftIdx"),[]),lookup(id("pivot"),[])),geq(lookup(id("rightIdx"),[]),lookup(id("pivot"),[]))),[whileDo(amp(lt(lookup(id("array"),[subscript(lookup(id("leftIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("pivot"),[]))])),leq(lookup(id("leftIdx"),[]),lookup(id("pivot"),[]))),[assign(id("leftIdx"),[],add(lookup(id("leftIdx"),[]),nat(1)))]),whileDo(amp(gt(lookup(id("array"),[subscript(lookup(id("rightIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("pivot"),[]))])),geq(lookup(id("rightIdx"),[]),lookup(id("pivot"),[]))),[assign(id("rightIdx"),[],sub(lookup(id("rightIdx"),[]),nat(1)))]),call(id("Swap"),[lookup(id("array"),[subscript(lookup(id("leftIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("rightIdx"),[]))])]),assign(id("leftIdx"),[],add(lookup(id("leftIdx"),[]),nat(1))),assign(id("rightIdx"),[],sub(lookup(id("rightIdx"),[]),nat(1))),ifThen(eq(sub(lookup(id("leftIdx"),[]),nat(1)),lookup(id("pivot"),[])),[assign(id("rightIdx"),[],add(lookup(id("rightIdx"),[]),nat(1))),assign(id("pivot"),[],lookup(id("rightIdx"),[]))],[<eq(add(lookup(id("rightIdx"),[]),nat(1)),lookup(id("pivot"),[])),[assign(id("leftIdx"),[],sub(lookup(id("leftIdx"),[]),nat(1))),assign(id("pivot"),[],lookup(id("leftIdx"),[]))]>],[])]),call(id("QuickSort"),[lookup(id("array"),[]),lookup(id("left"),[]),sub(lookup(id("pivot"),[]),nat(1))]),call(id("QuickSort"),[lookup(id("array"),[]),add(lookup(id("pivot"),[]),nat(1)),lookup(id("right"),[])])],[],[])],id("QuickSort"))]),[assign(id("i"),[],nat(0)),whileDo(lt(lookup(id("i"),[]),lookup(id("INPUTLENGTH"),[])),[call(id("Read"),[lookup(id("input"),[subscript(lookup(id("i"),[]))])]),assign(id("i"),[],add(lookup(id("i"),[]),nat(1)))]),call(id("QuickSort"),[lookup(id("input"),[]),nat(0),sub(lookup(id("INPUTLENGTH"),[]),nat(1))]),assign(id("i"),[],nat(0)),whileDo(lt(lookup(id("i"),[]),lookup(id("INPUTLENGTH"),[])),[call(id("Write"),[lookup(id("input"),[subscript(lookup(id("i"),[]))])]),call(id("WriteLn"),[]),assign(id("i"),[],add(lookup(id("i"),[]),nat(1)))])],id("QuickSort"));

public Module sample =
mod(id("Sample"),decls([],[],[],[proc(id("Nesting"),[],decls([],[],[varDecl([id("x"),id("y")],user(id("INTEGER")))],[proc(id("f"),[formal(false,[id("x")],user(id("INTEGER"))),formal(true,[id("z")],user(id("INTEGER")))],decls([],[],[],[proc(id("g"),[formal(false,[id("abc")],user(id("INTEGER")))],decls([],[],[],[proc(id("h"),[],decls([],[],[],[]),[call(id("Write"),[lookup(id("x"),[])]),call(id("Write"),[lookup(id("z"),[])]),assign(id("abc"),[],add(add(lookup(id("x"),[]),lookup(id("z"),[])),lookup(id("y"),[])))],id("h"))]),[assign(id("y"),[],nat(12)),assign(id("x"),[],nat(42))],id("g"))]),[assign(id("y"),[],nat(3)),call(id("Write"),[lookup(id("x"),[])]),assign(id("z"),[],add(lookup(id("z"),[]),nat(1)))],id("f"))]),[assign(id("y"),[],nat(1)),assign(id("x"),[],nat(3)),call(id("f"),[lookup(id("x"),[]),lookup(id("y"),[])])],id("Nesting")),proc(id("Multiply"),[],decls([],[],[varDecl([id("x"),id("y"),id("z")],user(id("INTEGER")))],[]),[call(id("Read"),[lookup(id("x"),[])]),call(id("Read"),[lookup(id("y"),[])]),assign(id("z"),[],nat(0)),whileDo(gt(lookup(id("x"),[]),nat(0)),[ifThen(eq(mod(lookup(id("x"),[]),nat(2)),nat(1)),[assign(id("z"),[],add(lookup(id("z"),[]),lookup(id("y"),[])))],[],[]),assign(id("y"),[],mul(nat(2),lookup(id("y"),[]))),assign(id("x"),[],div(lookup(id("x"),[]),nat(2)))]),call(id("Write"),[lookup(id("x"),[])]),call(id("Write"),[lookup(id("y"),[])]),call(id("Write"),[lookup(id("z"),[])]),call(id("WriteLn"),[])],id("Multiply")),proc(id("Divide"),[],decls([],[],[varDecl([id("x"),id("y"),id("r"),id("q"),id("w")],user(id("INTEGER")))],[]),[call(id("Read"),[lookup(id("x"),[])]),call(id("Read"),[lookup(id("y"),[])]),assign(id("r"),[],lookup(id("x"),[])),assign(id("q"),[],nat(0)),assign(id("w"),[],lookup(id("y"),[])),whileDo(leq(lookup(id("w"),[]),lookup(id("r"),[])),[assign(id("w"),[],mul(nat(2),lookup(id("w"),[])))]),whileDo(gt(lookup(id("w"),[]),lookup(id("y"),[])),[assign(id("q"),[],mul(nat(2),lookup(id("q"),[]))),assign(id("w"),[],div(lookup(id("w"),[]),nat(2))),ifThen(leq(lookup(id("w"),[]),lookup(id("r"),[])),[assign(id("r"),[],sub(lookup(id("r"),[]),lookup(id("w"),[]))),assign(id("q"),[],add(lookup(id("q"),[]),nat(1)))],[],[])]),call(id("Write"),[lookup(id("x"),[])]),call(id("Write"),[lookup(id("y"),[])]),call(id("Write"),[lookup(id("q"),[])]),call(id("Write"),[lookup(id("r"),[])]),call(id("WriteLn"),[])],id("Divide")),proc(id("BinSearch"),[],decls([],[],[varDecl([id("i"),id("j"),id("k"),id("n"),id("x")],user(id("INTEGER"))),varDecl([id("a")],array(nat(32),user(id("INTEGER"))))],[]),[call(id("Read"),[lookup(id("n"),[])]),assign(id("k"),[],nat(0)),whileDo(lt(lookup(id("k"),[]),lookup(id("n"),[])),[call(id("Read"),[lookup(id("a"),[subscript(lookup(id("k"),[]))])]),assign(id("k"),[],add(lookup(id("k"),[]),nat(1)))]),call(id("Read"),[lookup(id("x"),[])]),assign(id("i"),[],nat(0)),assign(id("j"),[],lookup(id("n"),[])),whileDo(lt(lookup(id("i"),[]),lookup(id("j"),[])),[assign(id("k"),[],div(add(lookup(id("i"),[]),lookup(id("j"),[])),nat(2))),ifThen(lt(lookup(id("x"),[]),lookup(id("a"),[subscript(lookup(id("k"),[]))])),[assign(id("j"),[],lookup(id("k"),[]))],[],[assign(id("i"),[],add(lookup(id("k"),[]),nat(1)))])]),call(id("Write"),[lookup(id("i"),[])]),call(id("Write"),[lookup(id("j"),[])]),call(id("Write"),[lookup(id("a"),[subscript(lookup(id("j"),[]))])]),call(id("WriteLn"),[])],id("BinSearch"))]),[],id("Sample"));


public languages::oberon0::ast::Oberon0::Module parseQuickSort() {
  return delAnnotationsRec(
    implode(#languages::oberon0::ast::Oberon0::Module,
    parse(#languages::oberon0::syntax::Oberon0::Module, |project://oberon0/src/quicksort.oberon0|)));
}

public languages::oberon0::ast::Oberon0::Module parseTest() {
  return parseSomething( |project://oberon0/src/test.oberon0| );
}

public languages::oberon0::ast::Oberon0::Module parseSample() {
  return parseSomething( |project://oberon0/src/sample.oberon0| );
}

public languages::oberon0::ast::Oberon0::Module parseSomething(loc location) {
  return delAnnotationsRec(
    implode(#languages::oberon0::ast::Oberon0::Module,
    parse(#languages::oberon0::syntax::Oberon0::Module, location)));
}

public void main() {
  writeFile(|project://oberon0/src/sample.c|, mod2c(resolve(sample)));
}

