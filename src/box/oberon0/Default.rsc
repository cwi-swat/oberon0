module box::oberon0::Default
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
     

// Don't change this part 

public text toText(loc src, loc dest){
     Module a = parse(#Module, src);
     setUserRules();
     text r = toText(a);
     toExport(src, dest, r, ".txt");
     return r;
     }
     
 public text toHtml(loc src, loc dest){
     Module a = parse(#Module, src);
     setUserRules();
     text r = toHtml(a);
     toExport(src, dest, r, ".html");
     return r;
     }  
     
public text toLatex(loc src, loc dest){
     Module a = parse(#Module, src);
     // rawPrintln(a);
     setUserRules();
     text r = toLatex(a);
     toExport(src, dest, r, ".tex");
     return r;
     } 

public text toRichText(loc asf){
     Module a = parse(#Module, asf);
     setUserRules();
     text r = toRichText(a);
     return r;
     } 
          
public Box toBox(loc asf) {
     Tree a = parse(#Module, asf);
     setUserRules();
     return toBox(a);
     }  


public Box extraRules(Tree q) {  
    return getUserDefined(q);
    }
    
