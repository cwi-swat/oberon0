module lang::oberon0::l2::format::Oberon0

extend lang::oberon0::l1::format::Oberon0;
import lang::oberon0::l2::ast::Oberon0;

import List;

public Box stat2box(forDo(n, f, t, b)) = V([
            H([L("FOR"), id2box(n), L(":="), exp2box(f), KW(L("TO")), exp2box(t), L("DO")])[@hs=1],
             I([V(hsepList(b, ";", stat2box))]),
            KW(L("END"))
        ]);   

public Box stat2box(repeatUntil(b, c)) = V([
            L("REPEAT"),
               I([V(hsepList(b, ";", stat2box))]),
            H([KW(L("UNTIL")), exp2box(c)])[@hs=1]
        ]);   
