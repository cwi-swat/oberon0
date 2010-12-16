module languages::oberon0::check::Types

import List;
import languages::oberon0::ast::Oberon0;

data OType =
	  Integer()
	| Boolean()
	| Array(OType elementType, int size)
	| Record(list[tuple[OType fieldType, Ident fieldName]] fields)
	| User(Ident typeName)
	| Invalid()
	;
	
public str prettyPrint(OType t) {
	str printFields(list[tuple[OType fieldType, Ident fieldName]] fields) {
		str res = "";
		if (size(fields) > 0) {
			for (n <- [0..size(fields)-1]) {
				res = res + "<fields[n].fieldName.name>: <prettyPrint(fields[n].fieldType)>";
				if (n != size(fields)-1) res = res + "; ";
			}
		}
		return res;
	}
	
	switch(t) {
		case Integer() : return "INTEGER";
		
		case Boolean() : return "BOOLEAN";
		
		case Array(et,s) : return "ARRAY <s> OF <prettyPrint(et)>";
		
		case Record(fs) : return "RECORD <printFields(fs)> END";
		
		case User(n) : return "<n.name>";
		
		case Invalid() : return "INVALID TYPE";
	}
}
