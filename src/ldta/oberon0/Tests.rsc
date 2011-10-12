module ldta::oberon0::Tests

import ldta::oberon0::Testers;
import ldta::oberon0::A1;
import ldta::oberon0::A2a;
import ldta::oberon0::A2b;
import ldta::oberon0::A3;
import ldta::oberon0::A4;

public test bool NEG_bind_L1_rascal_4_undecl_const_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/4_undecl-const.ob|) == 4; 

public test bool NEG_bind_L1_rascal_4_undecl_type_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/4_undecl-type.ob|) == 4; 

public test bool NEG_bind_L1_rascal_4_undecl_var_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/4_undecl-var.ob|) == 4; 

public test bool NEG_bind_L1_rascal_7_assign_const_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_assign_const.ob|) == 7; 

public test bool NEG_bind_L1_rascal_7_assign_type_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_assign_type.ob|) == 7; 

public test bool NEG_bind_L1_rascal_7_dupl_id_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_dupl-id.ob|) == 7; 

public test bool NEG_bind_L1_rascal_7_dupl_id2_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_dupl-id2.ob|) == 7; 

public test bool NEG_bind_L1_rascal_7_undecl_id_ob() = 
  tryBind(bindL1, |project://oberon0/tests/rascal/negative/name_errors/L1/7_undecl-id.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_for1_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-for1.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_for2_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-for2.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_for3_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-for3.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_for4_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-for4.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_in_case1_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-in-case1.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_in_case2_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-in-case2.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_in_case3_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-in-case3.ob|) == 7; 

public test bool NEG_bind_L2_rascal_7_undecl_in_for_ob() = 
  tryBind(bindL2, |project://oberon0/tests/rascal/negative/name_errors/L2/7_undecl-in-for.ob|) == 7; 

public test bool NEG_parse_L1_rascal_empty_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/empty.ob|) != -1; 

public test bool NEG_parse_L1_rascal_module_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/module.ob|) != -1; 

public test bool NEG_parse_L1_rascal_no_semi_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/no-semi.ob|) != -1; 

public test bool NEG_parse_L1_rascal_no_trailing_id_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/no-trailing-id.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc1_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc1.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc2_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc2.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc3_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc3.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc4_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc4.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc5_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc5.ob|) != -1; 

public test bool NEG_parse_L1_rascal_non_assoc6_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/non-assoc6.ob|) != -1; 

public test bool NEG_parse_L1_rascal_reserved1_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/reserved1.ob|) != -1; 

public test bool NEG_parse_L1_rascal_reserved2_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/reserved2.ob|) != -1; 

public test bool NEG_parse_L1_rascal_reserved3_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/reserved3.ob|) != -1; 

public test bool NEG_parse_L1_rascal_trailing_semi1_ob() = 
  tryParse(parseL1, |project://oberon0/tests/rascal/negative/parse_errors/L1/trailing-semi1.ob|) != -1; 

public test bool NEG_parse_L2_rascal_case_of_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/case-of.ob|) != -1; 

public test bool NEG_parse_L2_rascal_case_reserved_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/case-reserved.ob|) != -1; 

public test bool NEG_parse_L2_rascal_case_semi_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/case-semi.ob|) != -1; 

public test bool NEG_parse_L2_rascal_case_sep_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/case-sep.ob|) != -1; 

public test bool NEG_parse_L2_rascal_for_reserved_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/for-reserved.ob|) != -1; 

public test bool NEG_parse_L2_rascal_forloop_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/forloop.ob|) != -1; 

public test bool NEG_parse_L2_rascal_forloop2_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/forloop2.ob|) != -1; 

public test bool NEG_parse_L2_rascal_of_reserved_ob() = 
  tryParse(parseL2, |project://oberon0/tests/rascal/negative/parse_errors/L2/of-reserved.ob|) != -1; 

public test bool NEG_parse_L3_rascal_formals1_ob() = 
  tryParse(parseL3, |project://oberon0/tests/rascal/negative/parse_errors/L3/formals1.ob|) != -1; 

public test bool NEG_parse_L3_rascal_formals2_ob() = 
  tryParse(parseL3, |project://oberon0/tests/rascal/negative/parse_errors/L3/formals2.ob|) != -1; 

public test bool NEG_parse_L3_rascal_proc_reserved_ob() = 
  tryParse(parseL3, |project://oberon0/tests/rascal/negative/parse_errors/L3/proc-reserved.ob|) != -1; 

public test bool POS_parse_L3_rascal_factorial_ob() = 
  tryParse(parseL3, |project://oberon0/tests/rascal/positive/L3/factorial.ob|) == -1; 

public test bool POS_parse_L4_rascal_collatz_ob() = 
  tryParse(parseL4, |project://oberon0/tests/rascal/positive/L4/collatz.ob|) == -1; 

public test bool POS_parse_L4_rascal_quicksort_ob() = 
  tryParse(parseL4, |project://oberon0/tests/rascal/positive/L4/quicksort.ob|) == -1; 

public test bool POS_bind_L3_rascal_factorial_ob() = 
  tryBind(bindL3, |project://oberon0/tests/rascal/positive/L3/factorial.ob|) == -1; 

public test bool POS_bind_L4_rascal_collatz_ob() = 
  tryBind(bindL4, |project://oberon0/tests/rascal/positive/L4/collatz.ob|) == -1; 

public test bool POS_bind_L4_rascal_quicksort_ob() = 
  tryBind(bindL4, |project://oberon0/tests/rascal/positive/L4/quicksort.ob|) == -1; 

public test bool POS_check_L3_rascal_factorial_ob() = 
  tryCheck(checkL3, |project://oberon0/tests/rascal/positive/L3/factorial.ob|) == -1; 

public test bool POS_check_L4_rascal_collatz_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/rascal/positive/L4/collatz.ob|) == -1; 

public test bool POS_check_L4_rascal_quicksort_ob() = 
  tryCheck(checkL4, |project://oberon0/tests/rascal/positive/L4/quicksort.ob|) == -1; 

