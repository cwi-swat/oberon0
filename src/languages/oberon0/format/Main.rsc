module languages::oberon0::format::Main
import ParseTree;
import box::Concrete;
import box::Box;
import IO;

import languages::oberon0::syntax::Oberon0;
import languages::oberon0::format::UserDefined;

/*
alias UserDefinedFilter = Box(Tree t) ;

list[Box(Tree t)] userDefinedFilters = [ 
       ];
*/

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
     
     
void setUserRules() {
    setUserDefined(extraRules);
    setIndent(isIndented);
    setSeparated(isSeparated);
    }  
     
public text toText(loc asf){
     Module a = parse(#PROGRAM, asf);
     setUserRules();
     text r = toText(a);
     writeData(asf, r, ".txt");
     return r;
     }
 
 public text toHtml(loc asf){
     Module a = parse(#Module, asf);
     setUserRules();
     text r = toHtml(a);
     writeData(asf, r, ".html");
     return r;
     }  
     
public text toLatex(loc asf){
     Module a = parse(#Module, asf);
     // rawPrintln(a);
     setUserRules();
     text r = toLatex(a);
     writeData(asf, r, ".tex");
     return r;
     } 
     
public Box toBox(loc asf) {
     Tree a = parse(#Module, asf);
     // rawPrintln(a);
     setUserRules();
     return toBox(a);
     }  

// Don't change this part 

public Box extraRules(Tree q) {  
    return getUserDefined(q);
    }
    
