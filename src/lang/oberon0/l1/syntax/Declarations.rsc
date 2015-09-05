module lang::oberon0::l1::\syntax::Declarations

import lang::oberon0::l1::\syntax::Layout;
import lang::oberon0::l1::\syntax::Statements;
import lang::oberon0::l1::\syntax::Types;
import lang::oberon0::l1::\syntax::Lexical;
import lang::oberon0::l1::\syntax::Expressions;

syntax Declarations 
	= decls: ConstSect? consts TypeSect? types VarSect? vars
	;

syntax ConstDecl 
	= constDecl: Ident name "=" Expression value ";"
	;
	
syntax ConstSect 
	= "CONST" ConstDecl* consts
	;

syntax TypeDecl 
	= typeDecl: Ident name "=" Type type ";"
	;

syntax TypeSect 
	= "TYPE" TypeDecl* types
	;

syntax VarDecl 
	= varDecl: {Ident ","}* names ":" Type type ";"
	;
	
syntax VarSect 
	= @Foldable "VAR" VarDecl* vars
	;

keyword Keywords 
	= "VAR" 
	| "TYPE" 
	| "CONST" 
	;
	