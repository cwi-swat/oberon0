module lang::oberon0::eval::Test

import lang::oberon0::eval::Oberon0;
import lang::oberon0::eval::Memory;
import lang::oberon0::utils::Parse;
import lang::oberon0::ast::Oberon0;

import ParseTree;
import Node;
import IO;


public void main() {
  Stream input = ["34234", "2932", "4", "5", "2", "3", "7", "8", "323", "1", "2", "7", "8", "4", "2", "2", "3",
           "4", "5", "2", "3", "7", "8", "323", "1", "2", "7", "8", "4", "2", "2", "3"];
  input = ["23", "5", "3", "4", "12"];
  println(eval(implode(#Module, parseQuickSort()), input));
}


