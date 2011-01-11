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
   /* Size(bs) is uneven */
   Box b = V(0, [I([H(0, [bs[i], C(body, i), bs[i+1]])])|int i <-[0,2..(size(bs)-2)]]+I([H(0, [C(body,(size(bs)-2))]+[bs[size(bs)-1]])]));
   return b;
   }
   
Tree getOpt(Tree t) {
    if (/opt(_):= t) 
       return getFirst(t);
    return amb({});
    }

public Box getUserDefined(Tree q) {
     // println("User Defined");
     /* syntax Module = mod: "MODULE" Ident name ";" Declarations decls Body? body "END" Ident "."; */
      if (Module a:=q) {
          if (`MODULE <Ident id1> ; <Declarations decls> <Body? body> END <Ident id2> .`:=a) {
          return V(1, [H(1, [KW(L("Module")), evPt(id1), L(";")]), C(q, 2), evPt(decls), evPt(getOpt(body)), H(1, 
             [KW(L("END")), H(0, [evPt(id2), L(";")])])]);       
         }
         }
      if (Statement a:= q) {
         switch (a) {
               case `<Ident var> <Selector* sels>:= <Expression exp>`: {
                    list[Box] bs = getArgs(sels);
                    if (isEmpty(bs)) return H(1, [evPt(var), L(":="), evPt(exp)]);
                    else H(1, [H(0,evPt(var)+bs), L(":="), evPt(exp)]);
                    }
               case `<Ident name> <Actuals? actuals>`: return H(0, [evPt(name), evPt(getOpt(actuals))]);
               case `IF <Expression cond> THEN <{Statement ";"}+ body> <ElsIfPart* ei> <ElsePart? ep> END`: {
                     return V(0,  [H(1, [KW(L("IF")), evPt(cond), KW(L("THEN"))]), makeBody(body), evPt(getOpt(ep)), KW(L("END"))]);
                     }
               case `WHILE <Expression exp> DO <{Statement ";"}+ body> END`: {
                    return V(0,  [H(1, [KW(L("WHILE")), evPt(exp), KW(L("DO"))]), makeBody(body), KW(L("END"))]);
                    }
               }
             }
        /* syntax ElsePart = "ELSE" {Statement";"}+ body ; */
        if (ElsePart a:=q) {
             if (`ELSE <{Statement ";"}+ body>`:= a) return V([KW(L("ELSE")), makeBody(body)]);
             }
        /* syntax ElsIfPart = "ELSIF" Expression condition "THEN" {Statement";"}+ body ; */
        if (ElsIfPart a:=q) {
             if (`ELSIF <Expression condition> THEN <{Statement ";"}+ body>`:= a) 
                    return V(0, [H(1, [KW(L("ELSIF")), evPt(cond), KW(L("THEN"))]), makeBody(body)]);
             }
        if (Body a:= q) {
               if (`BEGIN <{Statement ";"}+ body>`:=a) {
                    return V(0, [KW(L("BEGIN")), makeBody(body)]);
                    }
               }
/* syntax Declarations = decls:ConstSect? cons TypeSect? type VarSect? vars
		                                               ProcedureDecl* procs; */
         if (Declarations a:= q) {
               Tree consts, typs, vars, procs;
               if (`<ConstSect? consts> <TypeSect? typs> <VarSect? vars> <ProcedureDecl* procs>`:=a) { 
                        return V(1, [evPt(getOpt(consts)), evPt(getOpt(typs)), evPt(getOpt(vars))]+getArgs(procs));   
                   }
               }
          /* syntax VarSect = "VAR" VarDecl* vars ; */
          if (VarSect a:=q) {
                if (`VAR <VarDecl* vars>`:=a) {          
                   return I([V(0,[KW(L("VAR")), I([A(getArgs(vars))])])]);
                   }
                }
          /* syntax ConstSect = "CONST" ConstDecl* consts ; */
          if (ConstSect a:=q) {
                if (`CONST <ConstDecl* consts>`:=a) {          
                   return I([V(0,[KW(L("CONST")), I([A(getArgs(consts))])])]);
                   }
                }
         /* syntax TypeSect = "TYPE" TypeDecl* types ; */
         if (TypeSect a:=q) {
                if (`TYPE <TypeDecl* typs>`:=a) {          
                   return I([V(0,[KW(L("TYPE")), I([A(getArgs(typs))])])]);
                   }
                }
          /* syntax VarDecl = varDecl: {Ident","}* names ":" Type type ";" */
          if (VarDecl a:=q) {
             if ((VarDecl) `<{Ident ","}* names> : <Type typ> ;`:=a) {
                         return R([evPt(names), L(":"), evPt(typ),L(";")]);
                         }
             }
          if (ConstDecl a:=q) {
             if ((ConstDecl) `<Ident name> = <Expression val> ;`:=a) {
                         return R([evPt(name), L("="), evPt(val),L(";")]);
                         }
             }
           
         if (TypeDecl a:=q) {
              if ((TypeDecl) `<Ident name> = <Type typ> ;`:=a) {
                   return R([evPt(name), L("="), evPt(typ),L(";")]);
                   }
             }
         if (ProcedureDecl a := q) {
      	 if (`PROCEDURE <Ident id1>  <Formals? formals> ; <Declarations decls> <Body? body> END <Ident id2> ;`:=a) {
      	    return V(0, [H(1, [KW(L("PROCEDURE")), H(0, [evPt(id1), evPt(formals), L(";")])]), evPt(decls), evPt(getOpt(body)),  
      	                      H(1, [KW(L("END")), H(0, [evPt(id2), L(";")])])]);
      	    }
      	   }
      	 if (Selector a := q) {
      	    if (`[ <Expression exp> ] `:= a) return H(0, [L("["), evPt(exp), L("]")]);
      	    if (`. <Ident id>` := a) return H(0,[L("."), evPt(id)]);
      	    }
      return NULL();
}