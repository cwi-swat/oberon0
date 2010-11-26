module languages::oberon0::format::UserDefined

import languages::oberon0::syntax::Oberon0;
import box::Box;
import box::Concrete;
import ParseTree;

Box makeBody(Tree body) {
   list[Box] bs = getArgs(body);
   Box b = V(0, [I([H(0, [bs[i], bs[i+1]])])|int i <-[0,2..(size(bs)-1)]]);
   return b;
   }

public Box getUserDefined(Tree q) {
      /*
      if (ProcedureDecl a := q) {
      	 if (`PROCEDURE <Ident id1>  <Formals? formals> ; <Declarations decls> <Body? body> END <Ident id2> ;`:=a) {
      	    return V(0, [H(1, [KW(L("PROCEDURE")), H(0, [evPt(id1), evPt(formals), L(";")])]), evPt(decls), evPt(body) ,  
      	                      H(1, [KW(L("END")), H(0, [evPt(id2), L(";")])])]);
      	    }
      }
      */
      if (Statement a:= q) {
         switch (a) {
               case `<Variable var> := <Expression exp>`: return H(1, evPt(var), L(":="), evPt(exp));
               // case `<Variable var> <Actuals? actuals>`: return H(0, evPt(var), evPt(actuals));
               case `IF <Expression cond> THEN <{Statement ";"}+ body1> <ElsIfPart* ei> <ElsePart? ep> END`: {
                     Box b1 = makeBody(body1);
                     if (`ELSE <{Statement ";"}+ body2>`:= ep) {
                         Box b2 = makeBody(body2);
                         return V(0,  [H(1, [KW(L("IF")), evPt(cond), KW(L("THEN"))]), b1,  KW(L("ELSE")), b2, KW(L("END"))]);
                         }
                     else
                     return V(0,  [H(1, [KW(L("IF")), evPt(cond), KW(L("THEN"))]), b1, KW(L("END"))]);
               }
               case `WHILE <Expression exp> DO <{Statement ";"}+ body> END`: {
                    Box b = makeBody(body);
                    return V(0,  [H(1, [KW(L("WHILE")), evPt(cond), KW(L("DO"))]), b, KW(L("END"))]);
                    }
         }
      }   
      return NULL;
}