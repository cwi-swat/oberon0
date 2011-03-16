module lang::oberon0::l4::utils::BoxFormat
import ParseTree;
import lang::oberon0::l1::syntax::Modules;
import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Declarations;
import lang::oberon0::l1::syntax::Expressions;
import lang::oberon0::l1::syntax::Statements;
import lang::oberon0::l1::syntax::Types;

import lang::oberon0::l2::syntax::Statements;

import lang::oberon0::l3::syntax::Declarations;
import lang::oberon0::l3::syntax::Statements;

import lang::oberon0::l4::syntax::Expressions;
import lang::oberon0::l4::syntax::Statements;
import lang::oberon0::l4::syntax::Types;

import lang::box::util::Concrete;
import lang::box::util::Box;
import lang::oberon0::l4::format::UserDefined;
import IO;


list[int] isIndented(list[Symbol] q) {
     if (isScheme(q , ["BEGIN", "N"])) return [1];
     if (isScheme(q , ["IF", "N", "THEN", "N", "N", "N", "END"])) return [3];
     if (isScheme(q , ["WHILE", "N", "DO", "N", "END"])) return [3];
     if (isScheme(q , ["PROCEDURE", "N", "N", ";", "N", "N", "END", "N", ";"])) return [4];
     return [];
     }

     
bool isSeparated(list[Symbol] q) {
     if (isScheme(q , ["VAR","N"])) return true;  
     if (isScheme(q , ["ARRAY", "N", "OF", "N"])) return true;
     return false;
     }
     
 public Box extraRules(Tree q) {  
    return getUserDefined(q);
    }    
     
void setUserRules() {
    setUserDefined(extraRules);
    setIndent(isIndented);
    setSeparated(isSeparated);
    }  
     
          
public Box toBox(loc asf) {
     Tree a = parse(#Module, asf);
     setUserRules();
     return treeToBox(a);
     }  



    
