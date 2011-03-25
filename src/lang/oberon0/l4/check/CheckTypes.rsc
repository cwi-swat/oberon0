module lang::oberon0::l4::check::CheckTypes

extend lang::oberon0::l3::check::CheckTypes;

import lang::oberon0::l4::ast::Oberon0;
import lang::oberon0::l4::resolve::Types;
import lang::oberon0::l3::resolve::SymbolTable;


bool expIsWritable(lookup(v, _)) = isWritableKind(v@item);

public Expression checkExp(e:lookup(v, sels), SymbolTable st) 	= e[@otype = getTypeFor(v, sels, e@location)];

public void checkStat(s:assign(v, sels, e), SymbolTable st) {
	Item vItem = v@item;
	if (Constant(_,_,_) := vItem) 
		errors += error(s@location, "A constant cannot be an assignment target");
	else {
		OType ot = getTypeFor(v, sels, s@location, st);
		if (Invalid() != ot && Invalid() != e@otype && ot != e@otype) 
			errors += error(s@location, "Cannot assign value of type <prettyPrint(e@otype)>, expected type <prettyPrint(ot)>"); 
	}		
}

public OType unwind(Array(et, n), Item ctx, SymbolTable st) = Array(unwind(et,ctx),n);
public OType unwind(Record(fs), Item ctx, SymbolTable st) = Record([<unwind(ft,ctx),fn> | <ft,fn> <- fs]);


//OType getTypeFor(t:Array(_, _), loc l, Item ctx, SymbolTable st) = t; 
//OType getTypeFor(t:Record(_), loc l, Item ctx, SymbolTable st) = t; 

//
// Get the type for an item. This is in the context of lvalues, so these are items that 
// can be assigned into and read from, i.e., not names representing types, modules, or 
// procedures. Variables and Formal Parameters can represent records and arrays, while
// constants cannot, so we check here to make sure the selectors for a constant are
// empty (and give an error if they are not).
//
OType getTypeFor(Ident v, list[Selector] selectors, loc l) {
	Item item = v@item;
	switch (item) {
		case Variable(_,ot,_): return getTypeFor(ot,selectors,l,item);
		case Constant(_,_,_): {
			if (selectors == []) {
				return Integer();
			}
			errors = errors + < l, "<v.name> is a constant INTEGER, no selectors should be used" >;
			return Invalid();
		}
		case FormalParameter(_,ot,_,_): return getTypeFor(ot,selectors,l,item);
		default: { 
			errors = errors + < l, "<v.name> is not a variable, constant, or formal parameter, and cannot be used in this context: <item>" >;
			return Invalid();
		}
	}
}

OType getTypeFor(OType ot, list[Selector] selectors, loc l, Item ctx) {
	switch (ot) {
		case Integer(): {
		// INTEGER: There should be no selectors.
			if (size(selectors) == 0) {
				return ot;
			}
			errors = errors + < l, "You cannot use subscripts or fields with values of type integer" >;
			return Invalid();
		}
		case Array(ota,n): {
			// ARRAY: There should either be no selectors, or the first selector
			// should be a subscript with expression evaluating to type INTEGER,
			// in which case we recurse on the array element type and the remaining
			// selectors.
			if (size(selectors) == 0) {
				return unwind(ot,ctx);
			}
			switch (head(selectors)) {
				case subscript(se): 
					if (se@otype == Integer()) {
						return getTypeFor(ota,tail(selectors),l,ctx);
					}
					else {
						errors = errors + < l, "You cannot use a non-INTEGER subscript to access an array" >;
						return Invalid();
					}
				default: {
					errors = errors + < l, "You cannot use fields on values of array type" >;
					return Invalid();
				}
			}
		}
		case Record(fs): {
			// RECORD: There should either be no selectors, or the first selector
			// should be a field, and that field should be one of the defined
			// fields for the record, in which case we will recurse on the type
			// of the field and the remaining selectors.
			if (size(selectors) == 0) {
				return unwind(ot,ctx);
			} 
			if (size(selectors) > 0 && field(fid) := head(selectors)) {
				list[OType] flds = { f.fieldType | f <- fs, f.fieldName == fid };
				if (size(flds) == 0) {
					errors = errors + < l, "Field <fid.name> not defined in record type" >;
					return Invalid();
				} 
				if (size(flds) == 1) {
					return getTypeFor(flds[0], tail(selectors), l, ctx);
				}		
				errors = errors + < l, "Multiple fields with name <fid.name> defined in record type" >;
				return Invalid();
			} 
			errors = errors + < l, "You cannot use subscripts on values of record type" >;
			return Invalid();
		}
		case User(tid): {
			OType unwound = unwind(ot);
			if (Invalid() := unwound) {
				errors = errors + < l, "Named type <tid.name> cannot be resolved to a valid Oberon type" >;
				return Invalid();
			}
			return unwound;
		}
		case Boolean(): {
			if (size(selectors) == 0) {
				return ot;
			}
			errors = errors + < l, "You cannot use subscripts or fields with values of type integer" >;
			return Invalid();
		}
		case Invalid(): return ot;
		default: throw "Unhandled type: <ot>";
	}
}