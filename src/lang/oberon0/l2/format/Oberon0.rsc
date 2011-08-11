module ldta::oberon0::l2::format::Oberon0

extend ldta::oberon0::l1::format::Oberon0;
import ldta::oberon0::l2::ast::Oberon0;

import List;

public Box stat2box(forDo(n, f, t, b)) = V([
            H([KW(L("FOR")), id2box(n), L(":="), exp2box(f), KW(L("TO")), exp2box(t), KW(L("DO"))])[@hs=1],
             I([V(hsepList(b, ";", stat2box))]),
            KW(L("END"))
        ]);   

public Box stat2box(caseOf(e, cs, es)) = V([
	 	H([KW(L("CASE")), exp2box(e), KW(L("OF"))])[@hs=1],
	 		I([V(hsepList(cs, "|", case2box))]),
	 	KW(L("END"))
	]);
	
public Box case2box(guard(e, b)) = V([
		H([exp2box(e), L(":")])[@hs=0],
		I([V(hsepList(b, ";", stat2box))])
	]);
