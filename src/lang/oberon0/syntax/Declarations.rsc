module lang::oberon0::syntax::Declarations

import lang::oberon0::syntax::Layout;
import lang::oberon0::syntax::Statements;
import lang::oberon0::syntax::Types;
import lang::oberon0::syntax::Lexical;
import lang::oberon0::syntax::Expressions;

syntax Declarations 
	= decls: ConstSect? consts TypeSect? types VarSect? vars ProcedureDecl* procs
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

syntax ProcedureDecl 
	= @Foldable proc: "PROCEDURE" Ident name Formals? formals ";" Declarations decls Body? body "END" Ident ";"
	; 


syntax Formal 
	= formal: "VAR"? hasVar {Ident ","}+ params ":" Type type
	;

syntax Formals 
	= "(" {Formal ";"}* formals ")"
	;

syntax Body 
	= @Foldable "BEGIN" {Statement ";"}+ statements
	;






