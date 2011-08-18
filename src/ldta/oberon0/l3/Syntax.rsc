module ldta::oberon0::l3::Syntax

extend ldta::oberon0::l2::Syntax;

syntax Statement = call: Ident name Actuals? actuals;

syntax Actuals = "(" {Expression ","}* expressions ")";

// NB: procs is + so as not to be ambiguous with earlier decls.
syntax Declarations = decls: ConstSect? consts TypeSect? types VarSect? vars ProcedureDecl+ procs;

syntax ProcedureDecl = @Foldable proc: "PROCEDURE" Ident name Formals? formals ";" Declarations decls Body? body "END" Ident ";"; 

syntax Formal = formal: "VAR"? hasVar {Ident ","}+ params ":" Type type;

syntax Formals = "(" {Formal ";"}* formals ")";

keyword Keywords = "PROCEDURE";

	