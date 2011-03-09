module lang::oberon0::l1::syntax::Statements

import lang::oberon0::l1::syntax::Layout;
import lang::oberon0::l1::syntax::Lexical;
import lang::oberon0::l1::syntax::Expressions;


syntax Statement 
	= assign: Ident var ":=" Expression exp
	| ifThen: "IF" Expression condition "THEN" {Statement ";"}+ body ElsIfPart* ElsePart? "END"
	| whileDo: "WHILE" Expression condition "DO" {Statement ";"}+ body "END"
	;


syntax ElsIfPart 
	= "ELSIF" Expression condition "THEN" {Statement ";"}+ body 
	;

syntax ElsePart 
	= "ELSE" {Statement ";"}+ body
	;

syntax Keywords 
	= "IF" 
	| "THEN" 
	| "ELSE" 
	| "ELSIF" 
	| "DO" 
	| "WHILE" 
	| "END" 
	;
	
syntax "IF" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "THEN" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "ELSE" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "ELSIF" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "DO" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "WHILE" 
	= ... # [A-Za-z0-9] 
	;
	
syntax "END" 
	= ... # [A-Za-z0-9] 
	;
	
