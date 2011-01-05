module languages::oberon0::eval::Test

import languages::oberon0::eval::Oberon0;
import languages::oberon0::eval::Memory;
import languages::oberon0::syntax::Oberon0;
import languages::oberon0::ast::Oberon0;
import ParseTree;
import Node;
import IO;


public Module quicksort =
mod(id("QuickSort"),decls([constDecl(id("INPUTLENGTH"),nat(4))],[],[varDecl([id("input")],array(lookup(id("INPUTLENGTH"),[]),user(id("INTEGER")))),varDecl([id("i")],user(id("INTEGER")))],[proc(id("QuickSort"),[formal(true,[id("array")],array(lookup(id("INPUTLENGTH"),[]),user(id("INTEGER")))),formal(false,[id("left"),id("right")],user(id("INTEGER")))],decls([],[],[varDecl([id("pivot"),id("leftIdx"),id("rightIdx")],user(id("INTEGER")))],[proc(id("Swap"),[formal(true,[id("x"),id("y")],user(id("INTEGER")))],decls([],[],[varDecl([id("temp")],user(id("INTEGER")))],[]),[assign(id("temp"),[],lookup(id("x"),[])),assign(id("x"),[],lookup(id("y"),[])),assign(id("y"),[],lookup(id("temp"),[]))],id("Swap"))]),[assign(id("leftIdx"),[],lookup(id("left"),[])),assign(id("rightIdx"),[],lookup(id("right"),[])),ifThen(gt(sub(lookup(id("right"),[]),lookup(id("left"),[])),nat(0)),[assign(id("pivot"),[],div(add(lookup(id("left"),[]),lookup(id("right"),[])),nat(2))),whileDo(amp(leq(lookup(id("leftIdx"),[]),lookup(id("pivot"),[])),geq(lookup(id("rightIdx"),[]),lookup(id("pivot"),[]))),[whileDo(amp(lt(lookup(id("array"),[subscript(lookup(id("leftIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("pivot"),[]))])),leq(lookup(id("leftIdx"),[]),lookup(id("pivot"),[]))),[assign(id("leftIdx"),[],add(lookup(id("leftIdx"),[]),nat(1)))]),whileDo(amp(gt(lookup(id("array"),[subscript(lookup(id("rightIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("pivot"),[]))])),geq(lookup(id("rightIdx"),[]),lookup(id("pivot"),[]))),[assign(id("rightIdx"),[],sub(lookup(id("rightIdx"),[]),nat(1)))]),call(id("Swap"),[lookup(id("array"),[subscript(lookup(id("leftIdx"),[]))]),lookup(id("array"),[subscript(lookup(id("rightIdx"),[]))])]),assign(id("leftIdx"),[],add(lookup(id("leftIdx"),[]),nat(1))),assign(id("rightIdx"),[],sub(lookup(id("rightIdx"),[]),nat(1))),ifThen(eq(sub(lookup(id("leftIdx"),[]),nat(1)),lookup(id("pivot"),[])),[assign(id("rightIdx"),[],add(lookup(id("rightIdx"),[]),nat(1))),assign(id("pivot"),[],lookup(id("rightIdx"),[]))],[<eq(add(lookup(id("rightIdx"),[]),nat(1)),lookup(id("pivot"),[])),[assign(id("leftIdx"),[],sub(lookup(id("leftIdx"),[]),nat(1))),assign(id("pivot"),[],lookup(id("leftIdx"),[]))]>],[])]),call(id("QuickSort"),[lookup(id("array"),[]),lookup(id("left"),[]),sub(lookup(id("pivot"),[]),nat(1))]),call(id("QuickSort"),[lookup(id("array"),[]),add(lookup(id("pivot"),[]),nat(1)),lookup(id("right"),[])])],[],[])],id("QuickSort"))]),[assign(id("i"),[],nat(0)),whileDo(lt(lookup(id("i"),[]),lookup(id("INPUTLENGTH"),[])),[call(id("Read"),[lookup(id("input"),[subscript(lookup(id("i"),[]))])]),assign(id("i"),[],add(lookup(id("i"),[]),nat(1)))]),call(id("QuickSort"),[lookup(id("input"),[]),nat(0),sub(lookup(id("INPUTLENGTH"),[]),nat(1))]),assign(id("i"),[],nat(0)),whileDo(lt(lookup(id("i"),[]),lookup(id("INPUTLENGTH"),[])),[call(id("Write"),[lookup(id("input"),[subscript(lookup(id("i"),[]))])]),call(id("WriteLn"),[]),assign(id("i"),[],add(lookup(id("i"),[]),nat(1)))])],id("QuickSort"));

public languages::oberon0::ast::Oberon0::Module parseQuickSort() {
  return delAnnotationsRec(
    implode(#languages::oberon0::ast::Oberon0::Module,
    parse(#languages::oberon0::syntax::Oberon0::Module, |project://oberon0/src/quicksort.oberon0|)));
}

public languages::oberon0::ast::Oberon0::Module parseTest() {
  return delAnnotationsRec(
    implode(#languages::oberon0::ast::Oberon0::Module,
    parse(#languages::oberon0::syntax::Oberon0::Module, |project://oberon0/src/test.oberon0|)));
}


public void main() {
  Stream input = ["34234", "2932", "4", "5", "2", "3", "7", "8", "323", "1", "2", "7", "8", "4", "2", "2", "3",
           "4", "5", "2", "3", "7", "8", "323", "1", "2", "7", "8", "4", "2", "2", "3"];
  input = ["23", "5", "3", "4"];
  println(eval(quicksort, input));
}


