module lang::oberon0::l1::syntax::Expressions

import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;

syntax Expression 
	= nat: Natural value
	| \true: "TRUE"
	| \false: "FALSE"
	| lookup: Ident var 
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

syntax Keywords 
	= "DIV" 
	| "MOD" 
	| "OR" 
	| "TRUE" 
	| "FALSE"
	; 
	
syntax "DIV" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "MOD" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "OR" 
	= ... # [A-Za-z0-9] 
	;

syntax "TRUE" 
	= ... # [A-Za-z0-9] 
	;

syntax "FALSE" 
	= ... # [A-Za-z0-9] 
	;
	
