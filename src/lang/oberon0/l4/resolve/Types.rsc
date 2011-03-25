module lang::oberon0::l4::resolve::Types

extend lang::oberon0::l1::resolve::Types;

import List;

data OType 
	= Array(OType elementType, int size)
	| Record(list[tuple[OType fieldType, Ident fieldName]] fields)
	;
	
public str prettyPrint(Array(et, s)) = "ARRAY <s> OF <prettyPrint(et)>";
public str prettyPrint(Record(fs)) = "RECORD <printFields(fs)> END";

public str printFields(list[tuple[OType fieldType, Ident fieldName]] fields) {
	return intercalate("; ", [ "<fn.name>: <prettyPrint(ft)>" | <ft, fn> <- fields ]);
}