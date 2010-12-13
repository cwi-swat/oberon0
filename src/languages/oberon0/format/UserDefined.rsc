module languages::oberon0::format::UserDefined

import languages::oberon0::syntax::Oberon0;
import box::Box;
import box::Concrete;
import ParseTree;
import IO;
import List;

Box makeBody(Tree body) {
   list[Box] bs = getArgs(body);
   bs = [b | Box b<-bs, COMM(_)!:=b];
   Box b = ((size(bs)%2==0)?V(0, [I([H(0, [bs[i], bs[i+1]])])|int i <-[0,2..(size(bs)-1)]]):
   V(0, [I([H(0, [bs[i], bs[i+1]])])|int i <-[0,2..(size(bs)-2)]]+[I([bs[size(bs)-1]])]));
   return b;
   }
   
Tree getOpt(Tree t) {
    if (/opt(_):= t) 
       return getFirst(t);
    return amb({});
    }

public Box getUserDefined(Tree q) {
     // println("User Defined");
     /* Module = mod: "MODULE" Ident name ";" Declarations decls Body? body "END" Ident "."; */
      if (Module a:=q) {
          if (`MODULE <Ident id1> ; <Declarations decls> <Body? body> END <Ident id2> .`:=a) {
          return V(1, [H(1, [KW(L("Module")), evPt(id1), L(";")]), evPt(decls), evPt(getOpt(body)), H(1, 
             [KW(L("END")), H(0, [evPt(id2), L(";")])])]);       
         }
         }
      if (ProcedureDecl a := q) {
      	 if (`PROCEDURE <Ident id1>  <Formals? formals> ; <Declarations decls> <Body? body> END <Ident id2> ;`:=a) {
      	    return V(0, [H(1, [KW(L("PROCEDURE")), H(0, [evPt(id1), evPt(formals), L(";")])]), evPt(decls), evPt(getOpt(body)),  
      	                      H(1, [KW(L("END")), H(0, [evPt(id2), L(";")])])]);
      	    }
      }
      if (Statement a:= q) {
         switch (a) {
               case `<Variable var> := <Expression exp>`: return H(1, [evPt(var), L(":="), evPt(exp)]);
               // case `<Variable var> <Actuals? actuals>`: return H(0, evPt(var), evPt(actuals));
               case `IF <Expression cond> THEN <{Statement ";"}+ body> <ElsIfPart* ei> <ElsePart? ep> END`: {
                     return V(0,  [H(1, [KW(L("IF")), evPt(cond), KW(L("THEN"))]), makeBody(body), evPt(getOpt(ep)), KW(L("END"))]);
                     }
               case `WHILE <Expression exp> DO <{Statement ";"}+ body> END`: {
                    return V(0,  [H(1, [KW(L("WHILE")), evPt(exp), KW(L("DO"))]), makeBody(body), KW(L("END"))]);
                    }
               }
             }
        if (ElsePart a:=q) {
             if (`ELSE <{Statement ";"}+ body>`:= a) return V([KW(L("ELSE")), makeBody(body)]);
             }
        if (Body a:= q) {
               if (`BEGIN <{Statement ";"}+ body>`:=a) {
                    return makeBody(body);
                    }
               }
         if (Declarations a:= q) {
               // rawPrintln("Declaration:");
               // rawPrintln(a);
               Tree consts = amb({});
               Tree typs = amb({});
               Tree vars = amb({});
               Tree procs = amb({});
               if (`<ConstSect? consts> <TypeSect? typs> <VarSect? vars> <{ProcedureDecl* procs}>`:=a) { 
                        VarSect vars = getOpt(vars);
                        return V(1,[evPt(vars)]+ evPt(procs));   
                   }
               }
          if (VarSect a:=q) {
                if (`VAR <VarDecl* vars>`:=a) return evPt(vars);
                }
          if (VarDecl a:=q) {
             // rawPrintln(a);
             return NULL();
             // if ((VarDecl) `<{Ident ","}*> names : <Type typ> ;`:=a) {return R([evPt(names), L(";"), evPt(\type)]);}
             }
        /* 
               syntax Declarations = decls: 
       		    ConstSect? consts
		        TypeSect? types
		        VarSect? vars
		         ProcedureDecl* procs; 
		         */
      return NULL();
}