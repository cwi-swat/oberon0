module languages::oberon0::syntax::Expressions

import languages::oberon0::syntax::Layout;
import languages::oberon0::syntax::Lexical;

syntax Expression 
	= nat: Natural value
	| lookup: Ident var Selector* selectors
	| bracket Bracket: "(" Expression exp ")"
	| not: "~" Expression exp
	> 
	left (
		mul: Expression lhs "*" Expression rhs
		| div: Expression lhs "DIV" Expression rhs
		| mod: Expression lhs "MOD" Expression rhs
		| amp: Expression lhs "&" Expression rhs
	) 
	>
	left (
		pos: "+" Expression exp
		| neg: "-" Expression exp
		| add: Expression lhs "+" Expression rhs
		| sub: Expression lhs "-" Expression rhs
		| or: Expression lhs "OR" Expression rhs
	)
	> 
	non-assoc (
		eq: Expression lhs "=" Expression rhs
		| neq: Expression lhs "#" Expression rhs
		| lt: Expression lhs "\<" Expression rhs
		| leq: Expression lhs "\<=" Expression rhs
		| gt: Expression lhs "\>" Expression rhs
		| geq: Expression lhs "\>=" Expression rhs
	)
	;

syntax Selector 
	= field: "." Ident field
	| subscript: "[" Expression exp "]" 
	;
