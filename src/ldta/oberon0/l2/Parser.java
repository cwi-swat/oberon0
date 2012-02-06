package ldta.oberon0.l2;

import java.io.IOException;
import java.io.StringReader;

import org.eclipse.imp.pdb.facts.type.TypeFactory;
import org.eclipse.imp.pdb.facts.IConstructor;
import org.eclipse.imp.pdb.facts.IValue;
import org.eclipse.imp.pdb.facts.IValueFactory;
import org.eclipse.imp.pdb.facts.exceptions.FactTypeUseException;
import org.eclipse.imp.pdb.facts.io.StandardTextReader;
import org.rascalmpl.parser.gtd.stack.*;
import org.rascalmpl.parser.gtd.stack.filter.*;
import org.rascalmpl.parser.gtd.stack.filter.follow.*;
import org.rascalmpl.parser.gtd.stack.filter.match.*;
import org.rascalmpl.parser.gtd.stack.filter.precede.*;
import org.rascalmpl.parser.gtd.preprocessing.ExpectBuilder;
import org.rascalmpl.parser.gtd.util.IntegerKeyedHashMap;
import org.rascalmpl.parser.gtd.util.IntegerList;
import org.rascalmpl.parser.gtd.util.IntegerMap;
import org.rascalmpl.values.ValueFactoryFactory;
import org.rascalmpl.values.uptr.Factory;

public class Parser extends org.rascalmpl.library.lang.rascal.syntax.RascalRascal {
  protected final static IValueFactory VF = ValueFactoryFactory.getValueFactory();
  
  private static final IntegerMap _resultStoreIdMappings;
  private static final IntegerKeyedHashMap<IntegerList> _dontNest;
	
  protected static void _putDontNest(IntegerKeyedHashMap<IntegerList> result, int parentId, int childId) {
    IntegerList donts = result.get(childId);
    if (donts == null) {
      donts = new IntegerList();
      result.put(childId, donts);
    }
    donts.add(parentId);
  }
    
  protected int getResultStoreId(int parentId) {
    return _resultStoreIdMappings.get(parentId);
  }
    
  protected static IntegerKeyedHashMap<IntegerList> _initDontNest() {
    IntegerKeyedHashMap<IntegerList> result = org.rascalmpl.library.lang.rascal.syntax.RascalRascal._initDontNest(); 
    
    
    
    
    _putDontNest(result, 362, 360);
    
    _putDontNest(result, 350, 380);
    
    _putDontNest(result, 352, 370);
    
    _putDontNest(result, 332, 330);
    
    _putDontNest(result, 322, 340);
    
    _putDontNest(result, 268, 278);
    
    _putDontNest(result, 298, 304);
    
    _putDontNest(result, 314, 288);
    
    _putDontNest(result, 360, 370);
    
    _putDontNest(result, 320, 330);
    
    _putDontNest(result, 288, 298);
    
    _putDontNest(result, 342, 380);
    
    _putDontNest(result, 258, 268);
    
    _putDontNest(result, 304, 350);
    
    _putDontNest(result, 330, 340);
    
    _putDontNest(result, 342, 340);
    
    _putDontNest(result, 330, 380);
    
    _putDontNest(result, 372, 370);
    
    _putDontNest(result, 268, 314);
    
    _putDontNest(result, 298, 288);
    
    _putDontNest(result, 350, 340);
    
    _putDontNest(result, 304, 298);
    
    _putDontNest(result, 278, 268);
    
    _putDontNest(result, 370, 360);
    
    _putDontNest(result, 314, 304);
    
    _putDontNest(result, 322, 380);
    
    _putDontNest(result, 340, 330);
    
    _putDontNest(result, 268, 258);
    
    _putDontNest(result, 380, 370);
    
    _putDontNest(result, 288, 350);
    
    _putDontNest(result, 260, 314);
    
    _putDontNest(result, 258, 304);
    
    _putDontNest(result, 330, 360);
    
    _putDontNest(result, 320, 370);
    
    _putDontNest(result, 360, 330);
    
    _putDontNest(result, 278, 288);
    
    _putDontNest(result, 268, 298);
    
    _putDontNest(result, 280, 350);
    
    _putDontNest(result, 322, 360);
    
    _putDontNest(result, 352, 330);
    
    _putDontNest(result, 304, 314);
    
    _putDontNest(result, 332, 370);
    
    _putDontNest(result, 370, 380);
    
    _putDontNest(result, 270, 304);
    
    _putDontNest(result, 260, 298);
    
    _putDontNest(result, 362, 340);
    
    _putDontNest(result, 268, 350);
    
    _putDontNest(result, 258, 288);
    
    _putDontNest(result, 350, 360);
    
    _putDontNest(result, 340, 370);
    
    _putDontNest(result, 380, 330);
    
    _putDontNest(result, 278, 304);
    
    _putDontNest(result, 362, 380);
    
    _putDontNest(result, 370, 340);
    
    _putDontNest(result, 260, 350);
    
    _putDontNest(result, 288, 314);
    
    _putDontNest(result, 342, 360);
    
    _putDontNest(result, 270, 288);
    
    _putDontNest(result, 372, 330);
    
    _putDontNest(result, 298, 360);
    
    _putDontNest(result, 288, 370);
    
    _putDontNest(result, 380, 350);
    
    _putDontNest(result, 278, 320);
    
    _putDontNest(result, 268, 330);
    
    _putDontNest(result, 258, 340);
    
    _putDontNest(result, 290, 360);
    
    _putDontNest(result, 278, 380);
    
    _putDontNest(result, 372, 350);
    
    _putDontNest(result, 270, 340);
    
    _putDontNest(result, 278, 248);
    
    _putDontNest(result, 260, 330);
    
    _putDontNest(result, 304, 370);
    
    _putDontNest(result, 280, 330);
    
    _putDontNest(result, 270, 380);
    
    _putDontNest(result, 314, 360);
    
    _putDontNest(result, 278, 340);
    
    _putDontNest(result, 258, 320);
    
    _putDontNest(result, 360, 350);
    
    _putDontNest(result, 258, 248);
    
    _putDontNest(result, 320, 314);
    
    _putDontNest(result, 306, 360);
    
    _putDontNest(result, 258, 380);
    
    _putDontNest(result, 352, 350);
    
    _putDontNest(result, 270, 320);
    
    _putDontNest(result, 260, 370);
    
    _putDontNest(result, 290, 340);
    
    _putDontNest(result, 270, 360);
    
    _putDontNest(result, 314, 380);
    
    _putDontNest(result, 320, 298);
    
    _putDontNest(result, 288, 330);
    
    _putDontNest(result, 258, 360);
    
    _putDontNest(result, 314, 320);
    
    _putDontNest(result, 340, 350);
    
    _putDontNest(result, 268, 370);
    
    _putDontNest(result, 298, 340);
    
    _putDontNest(result, 306, 380);
    
    _putDontNest(result, 332, 350);
    
    _putDontNest(result, 306, 340);
    
    _putDontNest(result, 298, 380);
    
    _putDontNest(result, 298, 320);
    
    _putDontNest(result, 280, 370);
    
    _putDontNest(result, 304, 330);
    
    _putDontNest(result, 320, 350);
    
    _putDontNest(result, 314, 340);
    
    _putDontNest(result, 290, 380);
    
    _putDontNest(result, 278, 360);
    
    _putDontNest(result, 224, 360);
    
    _putDontNest(result, 248, 360);
    
    _putDontNest(result, 250, 370);
    
    _putDontNest(result, 240, 360);
    
    _putDontNest(result, 240, 320);
    
    _putDontNest(result, 224, 340);
    
    _putDontNest(result, 248, 380);
    
    _putDontNest(result, 248, 320);
    
    _putDontNest(result, 240, 380);
    
    _putDontNest(result, 224, 320);
    
    _putDontNest(result, 250, 330);
    
    _putDontNest(result, 240, 340);
    
    _putDontNest(result, 248, 340);
    
    _putDontNest(result, 224, 380);
    
    _putDontNest(result, 224, 304);
    
    _putDontNest(result, 240, 288);
    
    _putDontNest(result, 250, 350);
    
    _putDontNest(result, 248, 288);
    
    _putDontNest(result, 224, 288);
    
    _putDontNest(result, 250, 298);
    
    _putDontNest(result, 240, 304);
    
    _putDontNest(result, 248, 304);
    
    _putDontNest(result, 250, 314);
    
    _putDontNest(result, 224, 268);
    
    _putDontNest(result, 248, 268);
    
    _putDontNest(result, 268, 268);
    
    _putDontNest(result, 298, 298);
    
    _putDontNest(result, 304, 288);
    
    _putDontNest(result, 360, 360);
    
    _putDontNest(result, 288, 304);
    
    _putDontNest(result, 330, 330);
    
    _putDontNest(result, 278, 258);
    
    _putDontNest(result, 320, 340);
    
    _putDontNest(result, 258, 278);
    
    _putDontNest(result, 314, 350);
    
    _putDontNest(result, 332, 340);
    
    _putDontNest(result, 352, 360);
    
    _putDontNest(result, 340, 380);
    
    _putDontNest(result, 362, 370);
    
    _putDontNest(result, 322, 330);
    
    _putDontNest(result, 278, 314);
    
    _putDontNest(result, 306, 350);
    
    _putDontNest(result, 288, 288);
    
    _putDontNest(result, 340, 340);
    
    _putDontNest(result, 314, 298);
    
    _putDontNest(result, 370, 370);
    
    _putDontNest(result, 332, 380);
    
    _putDontNest(result, 258, 258);
    
    _putDontNest(result, 278, 278);
    
    _putDontNest(result, 298, 350);
    
    _putDontNest(result, 350, 330);
    
    _putDontNest(result, 380, 360);
    
    _putDontNest(result, 270, 314);
    
    _putDontNest(result, 258, 314);
    
    _putDontNest(result, 320, 380);
    
    _putDontNest(result, 290, 350);
    
    _putDontNest(result, 342, 330);
    
    _putDontNest(result, 372, 360);
    
    _putDontNest(result, 314, 314);
    
    _putDontNest(result, 362, 330);
    
    _putDontNest(result, 380, 380);
    
    _putDontNest(result, 322, 370);
    
    _putDontNest(result, 270, 298);
    
    _putDontNest(result, 260, 304);
    
    _putDontNest(result, 332, 360);
    
    _putDontNest(result, 352, 340);
    
    _putDontNest(result, 278, 350);
    
    _putDontNest(result, 320, 360);
    
    _putDontNest(result, 372, 380);
    
    _putDontNest(result, 330, 370);
    
    _putDontNest(result, 258, 298);
    
    _putDontNest(result, 268, 304);
    
    _putDontNest(result, 360, 340);
    
    _putDontNest(result, 372, 340);
    
    _putDontNest(result, 298, 314);
    
    _putDontNest(result, 270, 350);
    
    _putDontNest(result, 342, 370);
    
    _putDontNest(result, 360, 380);
    
    _putDontNest(result, 260, 288);
    
    _putDontNest(result, 380, 340);
    
    _putDontNest(result, 370, 330);
    
    _putDontNest(result, 258, 350);
    
    _putDontNest(result, 278, 298);
    
    _putDontNest(result, 352, 380);
    
    _putDontNest(result, 350, 370);
    
    _putDontNest(result, 268, 288);
    
    _putDontNest(result, 340, 360);
    
    _putDontNest(result, 290, 370);
    
    _putDontNest(result, 260, 340);
    
    _putDontNest(result, 270, 330);
    
    _putDontNest(result, 280, 380);
    
    _putDontNest(result, 258, 330);
    
    _putDontNest(result, 298, 370);
    
    _putDontNest(result, 288, 360);
    
    _putDontNest(result, 268, 340);
    
    _putDontNest(result, 370, 350);
    
    _putDontNest(result, 268, 380);
    
    _putDontNest(result, 306, 370);
    
    _putDontNest(result, 268, 248);
    
    _putDontNest(result, 260, 320);
    
    _putDontNest(result, 362, 350);
    
    _putDontNest(result, 304, 360);
    
    _putDontNest(result, 260, 380);
    
    _putDontNest(result, 314, 370);
    
    _putDontNest(result, 268, 320);
    
    _putDontNest(result, 280, 340);
    
    _putDontNest(result, 278, 330);
    
    _putDontNest(result, 304, 320);
    
    _putDontNest(result, 320, 304);
    
    _putDontNest(result, 258, 370);
    
    _putDontNest(result, 298, 330);
    
    _putDontNest(result, 350, 350);
    
    _putDontNest(result, 288, 340);
    
    _putDontNest(result, 268, 360);
    
    _putDontNest(result, 342, 350);
    
    _putDontNest(result, 290, 330);
    
    _putDontNest(result, 260, 360);
    
    _putDontNest(result, 304, 380);
    
    _putDontNest(result, 270, 370);
    
    _putDontNest(result, 314, 330);
    
    _putDontNest(result, 320, 288);
    
    _putDontNest(result, 288, 320);
    
    _putDontNest(result, 280, 360);
    
    _putDontNest(result, 330, 350);
    
    _putDontNest(result, 278, 370);
    
    _putDontNest(result, 304, 340);
    
    _putDontNest(result, 306, 330);
    
    _putDontNest(result, 322, 350);
    
    _putDontNest(result, 288, 380);
    
    _putDontNest(result, 224, 370);
    
    _putDontNest(result, 240, 370);
    
    _putDontNest(result, 250, 360);
    
    _putDontNest(result, 248, 370);
    
    _putDontNest(result, 248, 248);
    
    _putDontNest(result, 250, 380);
    
    _putDontNest(result, 224, 330);
    
    _putDontNest(result, 250, 320);
    
    _putDontNest(result, 248, 330);
    
    _putDontNest(result, 240, 330);
    
    _putDontNest(result, 224, 248);
    
    _putDontNest(result, 250, 340);
    
    _putDontNest(result, 248, 350);
    
    _putDontNest(result, 224, 298);
    
    _putDontNest(result, 250, 288);
    
    _putDontNest(result, 240, 350);
    
    _putDontNest(result, 248, 298);
    
    _putDontNest(result, 240, 298);
    
    _putDontNest(result, 250, 304);
    
    _putDontNest(result, 224, 350);
    
    _putDontNest(result, 248, 314);
    
    _putDontNest(result, 224, 278);
    
    _putDontNest(result, 240, 314);
    
    _putDontNest(result, 248, 258);
    
    _putDontNest(result, 224, 258);
    
    _putDontNest(result, 224, 314);
    
    _putDontNest(result, 248, 278);
   return result;
  }
    
  protected static IntegerMap _initDontNestGroups() {
    IntegerMap result = org.rascalmpl.library.lang.rascal.syntax.RascalRascal._initDontNestGroups();
    int resultStoreId = result.size();
    
    
    ++resultStoreId;
    
    result.putUnsafe(268, resultStoreId);
    result.putUnsafe(248, resultStoreId);
    result.putUnsafe(278, resultStoreId);
    result.putUnsafe(258, resultStoreId);
    result.putUnsafe(224, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(270, resultStoreId);
    result.putUnsafe(250, resultStoreId);
    result.putUnsafe(314, resultStoreId);
    result.putUnsafe(298, resultStoreId);
    result.putUnsafe(260, resultStoreId);
    result.putUnsafe(288, resultStoreId);
    result.putUnsafe(240, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(320, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(304, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(350, resultStoreId);
    result.putUnsafe(380, resultStoreId);
    result.putUnsafe(332, resultStoreId);
    result.putUnsafe(330, resultStoreId);
    result.putUnsafe(362, resultStoreId);
    result.putUnsafe(280, resultStoreId);
    result.putUnsafe(360, resultStoreId);
    result.putUnsafe(342, resultStoreId);
    result.putUnsafe(340, resultStoreId);
    result.putUnsafe(372, resultStoreId);
    result.putUnsafe(290, resultStoreId);
    result.putUnsafe(322, resultStoreId);
    result.putUnsafe(306, resultStoreId);
    result.putUnsafe(370, resultStoreId);
    result.putUnsafe(352, resultStoreId);
      
    return result;
  }
  
  protected boolean hasNestingRestrictions(String name){
		return (_dontNest.size() != 0); // TODO Make more specific.
  }
    
  protected IntegerList getFilteredParents(int childId) {
		return _dontNest.get(childId);
  }
    
  // initialize priorities     
  static {
    _dontNest = _initDontNest();
    _resultStoreIdMappings = _initDontNestGroups();
  }
    
  // Production declarations
	
  private static final IConstructor prod__Keywords__lit_END_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ElsIfPart\"),[lit(\"ELSIF\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"THEN\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"neq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"#\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[\\char-class([range(0,39),range(41,41),range(43,16777215)])],{})", Factory.Production);
  private static final IConstructor prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"mod\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"MOD\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"forDo\",sort(\"Statement\")),[lit(\"FOR\"),layouts(\"Layouts\"),label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\":=\"),layouts(\"Layouts\"),label(\"from\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"TO\"),layouts(\"Layouts\"),label(\"to\",sort(\"Expression\")),layouts(\"Layouts\"),opt(seq([lit(\"BY\"),layouts(\"Layouts\"),sort(\"Expression\")])),layouts(\"Layouts\"),lit(\"DO\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__TypeDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"TypeDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right = (IConstructor) _read("prod(label(\"pos\",sort(\"Expression\")),[lit(\"+\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{assoc(right())})", Factory.Production);
  private static final IConstructor prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ElsePart\"),[lit(\"ELSE\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__lit___62_61__char_class___range__62_62_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"\\>=\"),[\\char-class([range(62,62)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"sub\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"-\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_ = (IConstructor) _read("prod(lit(\"BEGIN\"),[\\char-class([range(66,66)]),\\char-class([range(69,69)]),\\char-class([range(71,71)]),\\char-class([range(73,73)]),\\char-class([range(78,78)])],{})", Factory.Production);
  private static final IConstructor prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"constDecl\",sort(\"ConstDecl\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"value\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"lt\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\<\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_ = (IConstructor) _read("prod(lit(\"THEN\"),[\\char-class([range(84,84)]),\\char-class([range(72,72)]),\\char-class([range(69,69)]),\\char-class([range(78,78)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_DO__char_class___range__68_68_char_class___range__79_79_ = (IConstructor) _read("prod(lit(\"DO\"),[\\char-class([range(68,68)]),\\char-class([range(79,79)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_BY_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"BY\")],{})", Factory.Production);
  private static final IConstructor prod__layouts_$BACKTICKS__ = (IConstructor) _read("prod(layouts(\"$BACKTICKS\"),[],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_DIV_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"DIV\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_DO_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"DO\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_IF_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"IF\")],{})", Factory.Production);
  private static final IConstructor prod__lit_REPEAT__char_class___range__82_82_char_class___range__69_69_char_class___range__80_80_char_class___range__69_69_char_class___range__65_65_char_class___range__84_84_ = (IConstructor) _read("prod(lit(\"REPEAT\"),[\\char-class([range(82,82)]),\\char-class([range(69,69)]),\\char-class([range(80,80)]),\\char-class([range(69,69)]),\\char-class([range(65,65)]),\\char-class([range(84,84)])],{})", Factory.Production);
  private static final IConstructor regular__iter_star__CommentElt = (IConstructor) _read("regular(\\iter-star(lex(\"CommentElt\")))", Factory.Production);
  private static final IConstructor prod__lit___60_61__char_class___range__60_60_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"\\<=\"),[\\char-class([range(60,60)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_ = (IConstructor) _read("prod(lit(\"MOD\"),[\\char-class([range(77,77)]),\\char-class([range(79,79)]),\\char-class([range(68,68)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_OF_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"OF\")],{})", Factory.Production);
  private static final IConstructor prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable = (IConstructor) _read("prod(sort(\"Body\"),[lit(\"BEGIN\"),layouts(\"Layouts\"),\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])],{tag(Foldable())})", Factory.Production);
  private static final IConstructor prod__layouts_$default$__ = (IConstructor) _read("prod(layouts(\"$default$\"),[],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_OR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"OR\")],{})", Factory.Production);
  private static final IConstructor prod__lit_CASE__char_class___range__67_67_char_class___range__65_65_char_class___range__83_83_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"CASE\"),[\\char-class([range(67,67)]),\\char-class([range(65,65)]),\\char-class([range(83,83)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_TO_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"TO\")],{})", Factory.Production);
  private static final IConstructor regular__opt__ConstSect = (IConstructor) _read("regular(opt(sort(\"ConstSect\")))", Factory.Production);
  private static final IConstructor prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"eq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"ELSIF\"),[\\char-class([range(69,69)]),\\char-class([range(76,76)]),\\char-class([range(83,83)]),\\char-class([range(73,73)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_MOD_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"MOD\")],{})", Factory.Production);
  private static final IConstructor prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"ELSE\"),[\\char-class([range(69,69)]),\\char-class([range(76,76)]),\\char-class([range(83,83)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_VAR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"VAR\")],{})", Factory.Production);
  private static final IConstructor prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"geq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\>=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"TYPE\"),[\\char-class([range(84,84)]),\\char-class([range(89,89)]),\\char-class([range(80,80)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_ELSE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"ELSE\")],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_OR__char_class___range__79_79_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"OR\"),[\\char-class([range(79,79)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_THEN_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"THEN\")],{})", Factory.Production);
  private static final IConstructor prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(label(\"guard\",sort(\"Case\")),[\\iter-seps(sort(\"Label\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]),layouts(\"Layouts\"),lit(\":\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor regular__iter_star__char_class___range__48_57_range__65_90_range__97_122 = (IConstructor) _read("regular(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])))", Factory.Production);
  private static final IConstructor prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"typeDecl\",sort(\"TypeDecl\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_ = (IConstructor) _read("prod(label(\"decls\",sort(\"Declarations\")),[label(\"consts\",opt(sort(\"ConstSect\"))),layouts(\"Layouts\"),label(\"types\",opt(sort(\"TypeSect\"))),layouts(\"Layouts\"),label(\"vars\",opt(sort(\"VarSect\")))],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_UNTIL_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"UNTIL\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_TYPE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"TYPE\")],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Label\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_BEGIN_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"BEGIN\")],{})", Factory.Production);
  private static final IConstructor prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_ = (IConstructor) _read("prod(label(\"assign\",sort(\"Statement\")),[label(\"var\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\":=\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"FOR\"),[\\char-class([range(70,70)]),\\char-class([range(79,79)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_REPEAT_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"REPEAT\")],{})", Factory.Production);
  private static final IConstructor prod__lit___46_46__char_class___range__46_46_char_class___range__46_46_ = (IConstructor) _read("prod(lit(\"..\"),[\\char-class([range(46,46)]),\\char-class([range(46,46)])],{})", Factory.Production);
  private static final IConstructor regular__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122 = (IConstructor) _read("regular(seq([conditional(\\char-class([range(65,90),range(97,122)]),{\\not-precede(\\char-class([range(65,90),range(97,122)]))}),conditional(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])),{\\not-follow(\\char-class([range(48,57),range(65,90),range(97,122)]))})]))", Factory.Production);
  private static final IConstructor regular__iter_star__char_class___range__9_10_range__13_13_range__32_32 = (IConstructor) _read("regular(\\iter-star(\\char-class([range(9,10),range(13,13),range(32,32)])))", Factory.Production);
  private static final IConstructor prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"leq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\<=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"gt\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\>\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__ElsIfPart__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"ElsIfPart\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_ELSIF_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"ELSIF\")],{})", Factory.Production);
  private static final IConstructor prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_ = (IConstructor) _read("prod(lit(\"END\"),[\\char-class([range(69,69)]),\\char-class([range(78,78)]),\\char-class([range(68,68)])],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__VarDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"VarDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit_OF__char_class___range__79_79_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"OF\"),[\\char-class([range(79,79)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"ifThen\",sort(\"Statement\")),[lit(\"IF\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"THEN\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),\\iter-star-seps(sort(\"ElsIfPart\"),[layouts(\"Layouts\")]),layouts(\"Layouts\"),opt(sort(\"ElsePart\")),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"WHILE\"),[\\char-class([range(87,87)]),\\char-class([range(72,72)]),\\char-class([range(73,73)]),\\char-class([range(76,76)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[conditional(\\char-class([range(42,42)]),{\\not-follow(\\char-class([range(41,41)]))})],{})", Factory.Production);
  private static final IConstructor prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[conditional(\\char-class([range(40,40)]),{\\not-follow(\\char-class([range(42,42)]))})],{})", Factory.Production);
  private static final IConstructor prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"or\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"OR\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_ = (IConstructor) _read("prod(label(\"id\",lex(\"Ident\")),[conditional(seq([conditional(\\char-class([range(65,90),range(97,122)]),{\\not-precede(\\char-class([range(65,90),range(97,122)]))}),conditional(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])),{\\not-follow(\\char-class([range(48,57),range(65,90),range(97,122)]))})]),{delete(keywords(\"Keywords\"))})],{})", Factory.Production);
  private static final IConstructor prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_ = (IConstructor) _read("prod(label(\"mod\",sort(\"Module\")),[lit(\"MODULE\"),layouts(\"Layouts\"),label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\"),label(\"decls\",sort(\"Declarations\")),layouts(\"Layouts\"),label(\"body\",opt(sort(\"Body\"))),layouts(\"Layouts\"),lit(\"END\"),layouts(\"Layouts\"),lex(\"Ident\"),layouts(\"Layouts\"),lit(\".\")],{})", Factory.Production);
  private static final IConstructor prod__CommentElt__Comment_ = (IConstructor) _read("prod(lex(\"CommentElt\"),[lex(\"Comment\")],{})", Factory.Production);
  private static final IConstructor regular__iter_star__Layout = (IConstructor) _read("regular(\\iter-star(lex(\"Layout\")))", Factory.Production);
  private static final IConstructor prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"whileDo\",sort(\"Statement\")),[lit(\"WHILE\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"DO\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_ = (IConstructor) _read("prod(label(\"not\",sort(\"Expression\")),[lit(\"~\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__lit___42_41__char_class___range__42_42_char_class___range__41_41_ = (IConstructor) _read("prod(lit(\"*)\"),[\\char-class([range(42,42)]),\\char-class([range(41,41)])],{})", Factory.Production);
  private static final IConstructor prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"mul\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"*\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"amp\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"&\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_CONST_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"CONST\")],{})", Factory.Production);
  private static final IConstructor prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_ = (IConstructor) _read("prod(sort(\"TypeSect\"),[lit(\"TYPE\"),layouts(\"Layouts\"),label(\"types\",\\iter-star-seps(sort(\"TypeDecl\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__ConstDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"ConstDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit___59__char_class___range__59_59_ = (IConstructor) _read("prod(lit(\";\"),[\\char-class([range(59,59)])],{})", Factory.Production);
  private static final IConstructor prod__lit___58__char_class___range__58_58_ = (IConstructor) _read("prod(lit(\":\"),[\\char-class([range(58,58)])],{})", Factory.Production);
  private static final IConstructor prod__lit___61__char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"=\"),[\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__lit___60__char_class___range__60_60_ = (IConstructor) _read("prod(lit(\"\\<\"),[\\char-class([range(60,60)])],{})", Factory.Production);
  private static final IConstructor prod__lit___62__char_class___range__62_62_ = (IConstructor) _read("prod(lit(\"\\>\"),[\\char-class([range(62,62)])],{})", Factory.Production);
  private static final IConstructor prod__skip_Statement__ = (IConstructor) _read("prod(label(\"skip\",sort(\"Statement\")),[],{})", Factory.Production);
  private static final IConstructor prod__lit_UNTIL__char_class___range__85_85_char_class___range__78_78_char_class___range__84_84_char_class___range__73_73_char_class___range__76_76_ = (IConstructor) _read("prod(lit(\"UNTIL\"),[\\char-class([range(85,85)]),\\char-class([range(78,78)]),\\char-class([range(84,84)]),\\char-class([range(73,73)]),\\char-class([range(76,76)])],{})", Factory.Production);
  private static final IConstructor regular__seq___lit_BY_layouts_Layouts_Expression = (IConstructor) _read("regular(seq([lit(\"BY\"),layouts(\"Layouts\"),sort(\"Expression\")]))", Factory.Production);
  private static final IConstructor regular__opt__TypeSect = (IConstructor) _read("regular(opt(sort(\"TypeSect\")))", Factory.Production);
  private static final IConstructor prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_ = (IConstructor) _read("prod(label(\"range\",sort(\"Label\")),[label(\"from\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"..\"),layouts(\"Layouts\"),label(\"to\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__empty__ = (IConstructor) _read("prod(empty(),[],{})", Factory.Production);
  private static final IConstructor prod__nat_Expression__value_Natural_ = (IConstructor) _read("prod(label(\"nat\",sort(\"Expression\")),[label(\"value\",lex(\"Natural\"))],{})", Factory.Production);
  private static final IConstructor prod__lit___40_42__char_class___range__40_40_char_class___range__42_42_ = (IConstructor) _read("prod(lit(\"(*\"),[\\char-class([range(40,40)]),\\char-class([range(42,42)])],{})", Factory.Production);
  private static final IConstructor prod__lit___41__char_class___range__41_41_ = (IConstructor) _read("prod(lit(\")\"),[\\char-class([range(41,41)])],{})", Factory.Production);
  private static final IConstructor prod__lit___40__char_class___range__40_40_ = (IConstructor) _read("prod(lit(\"(\"),[\\char-class([range(40,40)])],{})", Factory.Production);
  private static final IConstructor prod__lit___43__char_class___range__43_43_ = (IConstructor) _read("prod(lit(\"+\"),[\\char-class([range(43,43)])],{})", Factory.Production);
  private static final IConstructor prod__lit___42__char_class___range__42_42_ = (IConstructor) _read("prod(lit(\"*\"),[\\char-class([range(42,42)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_MODULE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"MODULE\")],{})", Factory.Production);
  private static final IConstructor prod__lit____char_class___range__45_45_ = (IConstructor) _read("prod(lit(\"-\"),[\\char-class([range(45,45)])],{})", Factory.Production);
  private static final IConstructor prod__lit_IF__char_class___range__73_73_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"IF\"),[\\char-class([range(73,73)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__lit___44__char_class___range__44_44_ = (IConstructor) _read("prod(lit(\",\"),[\\char-class([range(44,44)])],{})", Factory.Production);
  private static final IConstructor prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket = (IConstructor) _read("prod(label(\"Bracket\",sort(\"Expression\")),[lit(\"(\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\")\")],{bracket()})", Factory.Production);
  private static final IConstructor prod__lit___46__char_class___range__46_46_ = (IConstructor) _read("prod(lit(\".\"),[\\char-class([range(46,46)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,50)]),\\char-class([range(48,49)]),\\char-class([range(48,52)]),\\char-class([range(48,55)]),\\char-class([range(48,52)]),\\char-class([range(48,56)]),\\char-class([range(48,51)]),\\char-class([range(48,54)]),\\char-class([range(48,52)]),conditional(\\char-class([range(48,55)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___35__char_class___range__35_35_ = (IConstructor) _read("prod(lit(\"#\"),[\\char-class([range(35,35)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___38__char_class___range__38_38_ = (IConstructor) _read("prod(lit(\"&\"),[\\char-class([range(38,38)])],{})", Factory.Production);
  private static final IConstructor regular__iter__CommentChar = (IConstructor) _read("regular(iter(lex(\"CommentChar\")))", Factory.Production);
  private static final IConstructor prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_ = (IConstructor) _read("prod(lit(\"DIV\"),[\\char-class([range(68,68)]),\\char-class([range(73,73)]),\\char-class([range(86,86)])],{})", Factory.Production);
  private static final IConstructor prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"MODULE\"),[\\char-class([range(77,77)]),\\char-class([range(79,79)]),\\char-class([range(68,68)]),\\char-class([range(85,85)]),\\char-class([range(76,76)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"caseOf\",sort(\"Statement\")),[lit(\"CASE\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"OF\"),layouts(\"Layouts\"),label(\"cases\",\\iter-seps(sort(\"Case\"),[layouts(\"Layouts\"),lit(\"|\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),label(\"elsePart\",opt(sort(\"ElsePart\"))),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__lookup_Expression__var_Ident_ = (IConstructor) _read("prod(label(\"lookup\",sort(\"Expression\")),[label(\"var\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right = (IConstructor) _read("prod(label(\"neg\",sort(\"Expression\")),[lit(\"-\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{assoc(right())})", Factory.Production);
  private static final IConstructor prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"div\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"DIV\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"VAR\"),[\\char-class([range(86,86)]),\\char-class([range(65,65)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_ = (IConstructor) _read("prod(start(sort(\"Module\")),[layouts(\"Layouts\"),label(\"top\",sort(\"Module\")),layouts(\"Layouts\")],{})", Factory.Production);
  private static final IConstructor prod__expression_Label__exp_Expression_ = (IConstructor) _read("prod(label(\"expression\",sort(\"Label\")),[label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__lit_TO__char_class___range__84_84_char_class___range__79_79_ = (IConstructor) _read("prod(lit(\"TO\"),[\\char-class([range(84,84)]),\\char-class([range(79,79)])],{})", Factory.Production);
  private static final IConstructor prod__CommentElt__iter__CommentChar_ = (IConstructor) _read("prod(lex(\"CommentElt\"),[iter(lex(\"CommentChar\"))],{})", Factory.Production);
  private static final IConstructor prod__Layout__Comment__tag__category___67_111_109_109_101_110_116 = (IConstructor) _read("prod(lex(\"Layout\"),[lex(\"Comment\")],{tag(category(\"Comment\"))})", Factory.Production);
  private static final IConstructor prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable = (IConstructor) _read("prod(sort(\"VarSect\"),[lit(\"VAR\"),layouts(\"Layouts\"),label(\"vars\",\\iter-star-seps(sort(\"VarDecl\"),[layouts(\"Layouts\")]))],{tag(Foldable())})", Factory.Production);
  private static final IConstructor regular__opt__Body = (IConstructor) _read("regular(opt(sort(\"Body\")))", Factory.Production);
  private static final IConstructor regular__opt__seq___lit_BY_layouts_Layouts_Expression = (IConstructor) _read("regular(opt(seq([lit(\"BY\"),layouts(\"Layouts\"),sort(\"Expression\")])))", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_ = (IConstructor) _read("prod(lit(\"CONST\"),[\\char-class([range(67,67)]),\\char-class([range(79,79)]),\\char-class([range(78,78)]),\\char-class([range(83,83)]),\\char-class([range(84,84)])],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Case\"),[layouts(\"Layouts\"),lit(\"|\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__Keywords__lit_FOR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"FOR\")],{})", Factory.Production);
  private static final IConstructor prod__lit___126__char_class___range__126_126_ = (IConstructor) _read("prod(lit(\"~\"),[\\char-class([range(126,126)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___124__char_class___range__124_124_ = (IConstructor) _read("prod(lit(\"|\"),[\\char-class([range(124,124)])],{})", Factory.Production);
  private static final IConstructor prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\":=\"),[\\char-class([range(58,58)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_ = (IConstructor) _read("prod(lex(\"Comment\"),[lit(\"(*\"),\\iter-star(lex(\"CommentElt\")),lit(\"*)\")],{})", Factory.Production);
  private static final IConstructor prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_ = (IConstructor) _read("prod(label(\"whitespace\",lex(\"Layout\")),[\\char-class([range(9,10),range(13,13),range(32,32)])],{})", Factory.Production);
  private static final IConstructor prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"add\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"+\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__user_Type__name_Ident_ = (IConstructor) _read("prod(label(\"user\",sort(\"Type\")),[label(\"name\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_ = (IConstructor) _read("prod(layouts(\"Layouts\"),[conditional(\\iter-star(lex(\"Layout\")),{\\not-follow(\\char-class([range(9,10),range(13,13),range(32,32)])),\\not-follow(lit(\"(*\"))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_WHILE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"WHILE\")],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"varDecl\",sort(\"VarDecl\")),[label(\"names\",\\iter-star-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\":\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_CASE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"CASE\")],{})", Factory.Production);
  private static final IConstructor regular__opt__ElsePart = (IConstructor) _read("regular(opt(sort(\"ElsePart\")))", Factory.Production);
  private static final IConstructor prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ConstSect\"),[lit(\"CONST\"),layouts(\"Layouts\"),label(\"consts\",\\iter-star-seps(sort(\"ConstDecl\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_ = (IConstructor) _read("prod(layouts(\"$QUOTES\"),[conditional(\\iter-star(\\char-class([range(9,10),range(13,13),range(32,32)])),{\\not-follow(\\char-class([range(9,10),range(13,13),range(32,32)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_BY__char_class___range__66_66_char_class___range__89_89_ = (IConstructor) _read("prod(lit(\"BY\"),[\\char-class([range(66,66)]),\\char-class([range(89,89)])],{})", Factory.Production);
  private static final IConstructor regular__opt__VarSect = (IConstructor) _read("regular(opt(sort(\"VarSect\")))", Factory.Production);
    
  // Item declarations
	
	
  protected static class CommentElt {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__CommentElt__iter__CommentChar_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new ListStackNode(10, 0, regular__iter__CommentChar, new NonTerminalStackNode(12, 0, "CommentChar", null, null), true, null, null);
      builder.addAlternative(Parser.prod__CommentElt__iter__CommentChar_, tmp);
	}
    protected static final void _init_prod__CommentElt__Comment_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(14, 0, "Comment", null, null);
      builder.addAlternative(Parser.prod__CommentElt__Comment_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__CommentElt__iter__CommentChar_(builder);
      
        _init_prod__CommentElt__Comment_(builder);
      
    }
  }
	
  protected static class Module {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[15];
      
      tmp[14] = new LiteralStackNode(56, 14, prod__lit___46__char_class___range__46_46_, new int[] {46}, null, null);
      tmp[13] = new NonTerminalStackNode(54, 13, "layouts_Layouts", null, null);
      tmp[12] = new NonTerminalStackNode(52, 12, "Ident", null, null);
      tmp[11] = new NonTerminalStackNode(50, 11, "layouts_Layouts", null, null);
      tmp[10] = new LiteralStackNode(48, 10, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[9] = new NonTerminalStackNode(46, 9, "layouts_Layouts", null, null);
      tmp[8] = new OptionalStackNode(42, 8, regular__opt__Body, new NonTerminalStackNode(44, 0, "Body", null, null), null, null);
      tmp[7] = new NonTerminalStackNode(40, 7, "layouts_Layouts", null, null);
      tmp[6] = new NonTerminalStackNode(38, 6, "Declarations", null, null);
      tmp[5] = new NonTerminalStackNode(36, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(34, 4, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[3] = new NonTerminalStackNode(32, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(30, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(28, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(26, 0, prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_, new int[] {77,79,68,85,76,69}, null, null);
      builder.addAlternative(Parser.prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_(builder);
      
    }
  }
	
  protected static class ConstDecl {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new LiteralStackNode(70, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(68, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(66, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(64, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(62, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[1] = new NonTerminalStackNode(60, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(58, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_(builder);
      
    }
  }
	
  protected static class start__Module {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(126, 2, "layouts_Layouts", null, null);
      tmp[1] = new NonTerminalStackNode(124, 1, "Module", null, null);
      tmp[0] = new NonTerminalStackNode(122, 0, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_(builder);
      
    }
  }
	
  protected static class ConstSect {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(136, 2, regular__iter_star_seps__ConstDecl__layouts_Layouts, new NonTerminalStackNode(138, 0, "ConstDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(140, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(134, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(132, 0, prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_, new int[] {67,79,78,83,84}, null, null);
      builder.addAlternative(Parser.prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_(builder);
      
    }
  }
	
  protected static class TypeDecl {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new LiteralStackNode(154, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(152, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(150, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(148, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(146, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[1] = new NonTerminalStackNode(144, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(142, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_(builder);
      
    }
  }
	
  protected static class Layout {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(162, 0, new int[][]{{9,10},{13,13},{32,32}}, null, null);
      builder.addAlternative(Parser.prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_, tmp);
	}
    protected static final void _init_prod__Layout__Comment__tag__category___67_111_109_109_101_110_116(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(164, 0, "Comment", null, null);
      builder.addAlternative(Parser.prod__Layout__Comment__tag__category___67_111_109_109_101_110_116, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_(builder);
      
        _init_prod__Layout__Comment__tag__category___67_111_109_109_101_110_116(builder);
      
    }
  }
	
  protected static class layouts_Layouts {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new ListStackNode(180, 0, regular__iter_star__Layout, new NonTerminalStackNode(182, 0, "Layout", null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{9,10},{13,13},{32,32}}), new StringFollowRestriction(new int[] {40,42})});
      builder.addAlternative(Parser.prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_(builder);
      
    }
  }
	
  protected static class TypeSect {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(202, 2, regular__iter_star_seps__TypeDecl__layouts_Layouts, new NonTerminalStackNode(204, 0, "TypeDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(206, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(200, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(198, 0, prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_, new int[] {84,89,80,69}, null, null);
      builder.addAlternative(Parser.prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_(builder);
      
    }
  }
	
  protected static class Ident {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new SequenceStackNode(384, 0, regular__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122, new AbstractStackNode[]{new CharStackNode(386, 0, new int[][]{{65,90},{97,122}}, new IEnterFilter[] {new CharPrecedeRestriction(new int[][]{{65,90},{97,122}})}, null), new ListStackNode(388, 1, regular__iter_star__char_class___range__48_57_range__65_90_range__97_122, new CharStackNode(390, 0, new int[][]{{48,57},{65,90},{97,122}}, null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57},{65,90},{97,122}})})}, null, new ICompletionFilter[] {new StringMatchRestriction(new int[] {86,65,82}), new StringMatchRestriction(new int[] {77,79,68}), new StringMatchRestriction(new int[] {79,82}), new StringMatchRestriction(new int[] {67,79,78,83,84}), new StringMatchRestriction(new int[] {77,79,68,85,76,69}), new StringMatchRestriction(new int[] {66,69,71,73,78}), new StringMatchRestriction(new int[] {70,79,82}), new StringMatchRestriction(new int[] {69,76,83,73,70}), new StringMatchRestriction(new int[] {68,79}), new StringMatchRestriction(new int[] {79,70}), new StringMatchRestriction(new int[] {66,89}), new StringMatchRestriction(new int[] {67,65,83,69}), new StringMatchRestriction(new int[] {68,73,86}), new StringMatchRestriction(new int[] {87,72,73,76,69}), new StringMatchRestriction(new int[] {73,70}), new StringMatchRestriction(new int[] {84,72,69,78}), new StringMatchRestriction(new int[] {85,78,84,73,76}), new StringMatchRestriction(new int[] {69,76,83,69}), new StringMatchRestriction(new int[] {84,89,80,69}), new StringMatchRestriction(new int[] {84,79}), new StringMatchRestriction(new int[] {82,69,80,69,65,84}), new StringMatchRestriction(new int[] {69,78,68})});
      builder.addAlternative(Parser.prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_(builder);
      
    }
  }
	
  protected static class Expression {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(360, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(358, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(356, 2, prod__lit___35__char_class___range__35_35_, new int[] {35}, null, null);
      tmp[1] = new NonTerminalStackNode(354, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(352, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__lookup_Expression__var_Ident_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(236, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__lookup_Expression__var_Ident_, tmp);
	}
    protected static final void _init_prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[0] = new NonTerminalStackNode(306, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(308, 1, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(310, 2, prod__lit_OR__char_class___range__79_79_char_class___range__82_82_, new int[] {79,82}, null, null);
      tmp[3] = new NonTerminalStackNode(312, 3, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(314, 4, "Expression", null, null);
      builder.addAlternative(Parser.prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(268, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(266, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(264, 2, prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_, new int[] {68,73,86}, null, null);
      tmp[1] = new NonTerminalStackNode(262, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(260, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(304, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(302, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(300, 0, prod__lit____char_class___range__45_45_, new int[] {45}, null, null);
      builder.addAlternative(Parser.prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right, tmp);
	}
    protected static final void _init_prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(278, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(276, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(274, 2, prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_, new int[] {77,79,68}, null, null);
      tmp[1] = new NonTerminalStackNode(272, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(270, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(320, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(318, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(316, 0, prod__lit___43__char_class___range__43_43_, new int[] {43}, null, null);
      builder.addAlternative(Parser.prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right, tmp);
	}
    protected static final void _init_prod__nat_Expression__value_Natural_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(238, 0, "Natural", null, null);
      builder.addAlternative(Parser.prod__nat_Expression__value_Natural_, tmp);
	}
    protected static final void _init_prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(224, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(222, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(220, 0, prod__lit___126__char_class___range__126_126_, new int[] {126}, null, null);
      builder.addAlternative(Parser.prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(330, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(328, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(326, 2, prod__lit___60_61__char_class___range__60_60_char_class___range__61_61_, new int[] {60,61}, null, null);
      tmp[1] = new NonTerminalStackNode(324, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(322, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(288, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(286, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(284, 2, prod__lit____char_class___range__45_45_, new int[] {45}, null, null);
      tmp[1] = new NonTerminalStackNode(282, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(280, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(340, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(338, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(336, 2, prod__lit___62__char_class___range__62_62_, new int[] {62}, null, null);
      tmp[1] = new NonTerminalStackNode(334, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(332, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(350, 4, "Expression", null, null);
      tmp[0] = new NonTerminalStackNode(342, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(344, 1, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(346, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[3] = new NonTerminalStackNode(348, 3, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(298, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(296, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(294, 2, prod__lit___43__char_class___range__43_43_, new int[] {43}, null, null);
      tmp[1] = new NonTerminalStackNode(292, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(290, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new LiteralStackNode(234, 4, prod__lit___41__char_class___range__41_41_, new int[] {41}, null, null);
      tmp[3] = new NonTerminalStackNode(232, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(230, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(228, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(226, 0, prod__lit___40__char_class___range__40_40_, new int[] {40}, null, null);
      builder.addAlternative(Parser.prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket, tmp);
	}
    protected static final void _init_prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(248, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(246, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(244, 2, prod__lit___42__char_class___range__42_42_, new int[] {42}, null, null);
      tmp[1] = new NonTerminalStackNode(242, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(240, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(370, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(368, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(366, 2, prod__lit___60__char_class___range__60_60_, new int[] {60}, null, null);
      tmp[1] = new NonTerminalStackNode(364, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(362, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(258, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(256, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(254, 2, prod__lit___38__char_class___range__38_38_, new int[] {38}, null, null);
      tmp[0] = new NonTerminalStackNode(250, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(252, 1, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(380, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(378, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(376, 2, prod__lit___62_61__char_class___range__62_62_char_class___range__61_61_, new int[] {62,61}, null, null);
      tmp[1] = new NonTerminalStackNode(374, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(372, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__lookup_Expression__var_Ident_(builder);
      
        _init_prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right(builder);
      
        _init_prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right(builder);
      
        _init_prod__nat_Expression__value_Natural_(builder);
      
        _init_prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_(builder);
      
        _init_prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket(builder);
      
        _init_prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
        _init_prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left(builder);
      
        _init_prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(builder);
      
    }
  }
	
  protected static class layouts_$QUOTES {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new ListStackNode(392, 0, regular__iter_star__char_class___range__9_10_range__13_13_range__32_32, new CharStackNode(394, 0, new int[][]{{9,10},{13,13},{32,32}}, null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{9,10},{13,13},{32,32}})});
      builder.addAlternative(Parser.prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_(builder);
      
    }
  }
	
  protected static class Body {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(418, 2, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(420, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(422, 1, "layouts_Layouts", null, null), new LiteralStackNode(424, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(426, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(416, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(414, 0, prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_, new int[] {66,69,71,73,78}, null, null);
      builder.addAlternative(Parser.prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable(builder);
      
    }
  }
	
  protected static class Statement {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(450, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(448, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(446, 2, prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_, new int[] {58,61}, null, null);
      tmp[1] = new NonTerminalStackNode(444, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(442, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__skip_Statement__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(484, 0);
      builder.addAlternative(Parser.prod__skip_Statement__, tmp);
	}
    protected static final void _init_prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[11];
      
      tmp[10] = new LiteralStackNode(482, 10, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[9] = new NonTerminalStackNode(480, 9, "layouts_Layouts", null, null);
      tmp[8] = new OptionalStackNode(476, 8, regular__opt__ElsePart, new NonTerminalStackNode(478, 0, "ElsePart", null, null), null, null);
      tmp[7] = new NonTerminalStackNode(474, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(464, 6, regular__iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts, new NonTerminalStackNode(466, 0, "Case", null, null), new AbstractStackNode[]{new NonTerminalStackNode(468, 1, "layouts_Layouts", null, null), new LiteralStackNode(470, 2, prod__lit___124__char_class___range__124_124_, new int[] {124}, null, null), new NonTerminalStackNode(472, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(462, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(460, 4, prod__lit_OF__char_class___range__79_79_char_class___range__70_70_, new int[] {79,70}, null, null);
      tmp[3] = new NonTerminalStackNode(458, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(456, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(454, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(452, 0, prod__lit_CASE__char_class___range__67_67_char_class___range__65_65_char_class___range__83_83_char_class___range__69_69_, new int[] {67,65,83,69}, null, null);
      builder.addAlternative(Parser.prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[19];
      
      tmp[18] = new LiteralStackNode(538, 18, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[17] = new NonTerminalStackNode(536, 17, "layouts_Layouts", null, null);
      tmp[16] = new SeparatedListStackNode(526, 16, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(528, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(530, 1, "layouts_Layouts", null, null), new LiteralStackNode(532, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(534, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[15] = new NonTerminalStackNode(524, 15, "layouts_Layouts", null, null);
      tmp[14] = new LiteralStackNode(522, 14, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      tmp[13] = new NonTerminalStackNode(520, 13, "layouts_Layouts", null, null);
      tmp[12] = new OptionalStackNode(510, 12, regular__opt__seq___lit_BY_layouts_Layouts_Expression, new SequenceStackNode(512, 0, regular__seq___lit_BY_layouts_Layouts_Expression, new AbstractStackNode[]{new LiteralStackNode(514, 0, prod__lit_BY__char_class___range__66_66_char_class___range__89_89_, new int[] {66,89}, null, null), new NonTerminalStackNode(516, 1, "layouts_Layouts", null, null), new NonTerminalStackNode(518, 2, "Expression", null, null)}, null, null), null, null);
      tmp[11] = new NonTerminalStackNode(508, 11, "layouts_Layouts", null, null);
      tmp[10] = new NonTerminalStackNode(506, 10, "Expression", null, null);
      tmp[9] = new NonTerminalStackNode(504, 9, "layouts_Layouts", null, null);
      tmp[8] = new LiteralStackNode(502, 8, prod__lit_TO__char_class___range__84_84_char_class___range__79_79_, new int[] {84,79}, null, null);
      tmp[7] = new NonTerminalStackNode(500, 7, "layouts_Layouts", null, null);
      tmp[6] = new NonTerminalStackNode(498, 6, "Expression", null, null);
      tmp[5] = new NonTerminalStackNode(496, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(494, 4, prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_, new int[] {58,61}, null, null);
      tmp[3] = new NonTerminalStackNode(492, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(490, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(488, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(486, 0, prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_, new int[] {70,79,82}, null, null);
      builder.addAlternative(Parser.prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[9];
      
      tmp[8] = new LiteralStackNode(564, 8, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[7] = new NonTerminalStackNode(562, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(552, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(554, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(556, 1, "layouts_Layouts", null, null), new LiteralStackNode(558, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(560, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(550, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(548, 4, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      tmp[3] = new NonTerminalStackNode(546, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(544, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(542, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(540, 0, prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_, new int[] {87,72,73,76,69}, null, null);
      builder.addAlternative(Parser.prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[13];
      
      tmp[12] = new LiteralStackNode(604, 12, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[11] = new NonTerminalStackNode(602, 11, "layouts_Layouts", null, null);
      tmp[10] = new OptionalStackNode(598, 10, regular__opt__ElsePart, new NonTerminalStackNode(600, 0, "ElsePart", null, null), null, null);
      tmp[9] = new NonTerminalStackNode(596, 9, "layouts_Layouts", null, null);
      tmp[8] = new SeparatedListStackNode(590, 8, regular__iter_star_seps__ElsIfPart__layouts_Layouts, new NonTerminalStackNode(592, 0, "ElsIfPart", null, null), new AbstractStackNode[]{new NonTerminalStackNode(594, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[7] = new NonTerminalStackNode(588, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(578, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(580, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(582, 1, "layouts_Layouts", null, null), new LiteralStackNode(584, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(586, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(576, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(574, 4, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      tmp[3] = new NonTerminalStackNode(572, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(570, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(568, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(566, 0, prod__lit_IF__char_class___range__73_73_char_class___range__70_70_, new int[] {73,70}, null, null);
      builder.addAlternative(Parser.prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_(builder);
      
        _init_prod__skip_Statement__(builder);
      
        _init_prod__caseOf_Statement__lit_CASE_layouts_Layouts_exp_Expression_layouts_Layouts_lit_OF_layouts_Layouts_cases_iter_seps__Case__layouts_Layouts_lit___124_layouts_Layouts_layouts_Layouts_elsePart_opt__ElsePart_layouts_Layouts_lit_END_(builder);
      
        _init_prod__forDo_Statement__lit_FOR_layouts_Layouts_name_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_from_Expression_layouts_Layouts_lit_TO_layouts_Layouts_to_Expression_layouts_Layouts_opt__seq___lit_BY_layouts_Layouts_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(builder);
      
        _init_prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(builder);
      
        _init_prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_(builder);
      
    }
  }
	
  protected static class Keywords {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Keywords__lit_BY_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(606, 0, prod__lit_BY__char_class___range__66_66_char_class___range__89_89_, new int[] {66,89}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_BY_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_DIV_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(608, 0, prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_, new int[] {68,73,86}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_DIV_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_DO_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(610, 0, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_DO_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_BEGIN_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(612, 0, prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_, new int[] {66,69,71,73,78}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_BEGIN_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(614, 0, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_END_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_FOR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(616, 0, prod__lit_FOR__char_class___range__70_70_char_class___range__79_79_char_class___range__82_82_, new int[] {70,79,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_FOR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_IF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(618, 0, prod__lit_IF__char_class___range__73_73_char_class___range__70_70_, new int[] {73,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_IF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ELSE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(620, 0, prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_, new int[] {69,76,83,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ELSE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_REPEAT_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(622, 0, prod__lit_REPEAT__char_class___range__82_82_char_class___range__69_69_char_class___range__80_80_char_class___range__69_69_char_class___range__65_65_char_class___range__84_84_, new int[] {82,69,80,69,65,84}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_REPEAT_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_OF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(624, 0, prod__lit_OF__char_class___range__79_79_char_class___range__70_70_, new int[] {79,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_OF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_OR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(626, 0, prod__lit_OR__char_class___range__79_79_char_class___range__82_82_, new int[] {79,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_OR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_THEN_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(628, 0, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_THEN_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_MODULE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(630, 0, prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_, new int[] {77,79,68,85,76,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_MODULE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_TO_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(632, 0, prod__lit_TO__char_class___range__84_84_char_class___range__79_79_, new int[] {84,79}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_TO_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ELSIF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(634, 0, prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_, new int[] {69,76,83,73,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ELSIF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_MOD_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(636, 0, prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_, new int[] {77,79,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_MOD_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_WHILE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(638, 0, prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_, new int[] {87,72,73,76,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_WHILE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_VAR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(640, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_VAR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_TYPE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(642, 0, prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_, new int[] {84,89,80,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_TYPE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_CASE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(644, 0, prod__lit_CASE__char_class___range__67_67_char_class___range__65_65_char_class___range__83_83_char_class___range__69_69_, new int[] {67,65,83,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_CASE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_UNTIL_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(646, 0, prod__lit_UNTIL__char_class___range__85_85_char_class___range__78_78_char_class___range__84_84_char_class___range__73_73_char_class___range__76_76_, new int[] {85,78,84,73,76}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_UNTIL_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_CONST_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(648, 0, prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_, new int[] {67,79,78,83,84}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_CONST_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Keywords__lit_BY_(builder);
      
        _init_prod__Keywords__lit_DIV_(builder);
      
        _init_prod__Keywords__lit_DO_(builder);
      
        _init_prod__Keywords__lit_BEGIN_(builder);
      
        _init_prod__Keywords__lit_END_(builder);
      
        _init_prod__Keywords__lit_FOR_(builder);
      
        _init_prod__Keywords__lit_IF_(builder);
      
        _init_prod__Keywords__lit_ELSE_(builder);
      
        _init_prod__Keywords__lit_REPEAT_(builder);
      
        _init_prod__Keywords__lit_OF_(builder);
      
        _init_prod__Keywords__lit_OR_(builder);
      
        _init_prod__Keywords__lit_THEN_(builder);
      
        _init_prod__Keywords__lit_MODULE_(builder);
      
        _init_prod__Keywords__lit_TO_(builder);
      
        _init_prod__Keywords__lit_ELSIF_(builder);
      
        _init_prod__Keywords__lit_MOD_(builder);
      
        _init_prod__Keywords__lit_WHILE_(builder);
      
        _init_prod__Keywords__lit_VAR_(builder);
      
        _init_prod__Keywords__lit_TYPE_(builder);
      
        _init_prod__Keywords__lit_CASE_(builder);
      
        _init_prod__Keywords__lit_UNTIL_(builder);
      
        _init_prod__Keywords__lit_CONST_(builder);
      
    }
  }
	
  protected static class Comment {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new LiteralStackNode(676, 2, prod__lit___42_41__char_class___range__42_42_char_class___range__41_41_, new int[] {42,41}, null, null);
      tmp[1] = new ListStackNode(672, 1, regular__iter_star__CommentElt, new NonTerminalStackNode(674, 0, "CommentElt", null, null), false, null, null);
      tmp[0] = new LiteralStackNode(670, 0, prod__lit___40_42__char_class___range__40_40_char_class___range__42_42_, new int[] {40,42}, null, null);
      builder.addAlternative(Parser.prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_(builder);
      
    }
  }
	
  protected static class Label {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(686, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(684, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(682, 2, prod__lit___46_46__char_class___range__46_46_char_class___range__46_46_, new int[] {46,46}, null, null);
      tmp[1] = new NonTerminalStackNode(680, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(678, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_, tmp);
	}
    protected static final void _init_prod__expression_Label__exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(688, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__expression_Label__exp_Expression_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__range_Label__from_Expression_layouts_Layouts_lit___46_46_layouts_Layouts_to_Expression_(builder);
      
        _init_prod__expression_Label__exp_Expression_(builder);
      
    }
  }
	
  protected static class Case {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new SeparatedListStackNode(718, 4, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(720, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(722, 1, "layouts_Layouts", null, null), new LiteralStackNode(724, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(726, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[3] = new NonTerminalStackNode(716, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(714, 2, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[1] = new NonTerminalStackNode(712, 1, "layouts_Layouts", null, null);
      tmp[0] = new SeparatedListStackNode(702, 0, regular__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(704, 0, "Label", null, null), new AbstractStackNode[]{new NonTerminalStackNode(706, 1, "layouts_Layouts", null, null), new LiteralStackNode(708, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(710, 3, "layouts_Layouts", null, null)}, true, null, null);
      builder.addAlternative(Parser.prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__guard_Case__iter_seps__Label__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(builder);
      
    }
  }
	
  protected static class VarDecl {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new LiteralStackNode(748, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(746, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(744, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(742, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(740, 2, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[1] = new NonTerminalStackNode(738, 1, "layouts_Layouts", null, null);
      tmp[0] = new SeparatedListStackNode(728, 0, regular__iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(730, 0, "Ident", null, null), new AbstractStackNode[]{new NonTerminalStackNode(732, 1, "layouts_Layouts", null, null), new LiteralStackNode(734, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(736, 3, "layouts_Layouts", null, null)}, false, null, null);
      builder.addAlternative(Parser.prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_(builder);
      
    }
  }
	
  protected static class ElsIfPart {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new SeparatedListStackNode(774, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(776, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(778, 1, "layouts_Layouts", null, null), new LiteralStackNode(780, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(782, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(772, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(770, 4, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      tmp[3] = new NonTerminalStackNode(768, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(766, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(764, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(762, 0, prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_, new int[] {69,76,83,73,70}, null, null);
      builder.addAlternative(Parser.prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(builder);
      
    }
  }
	
  protected static class CommentChar {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(794, 0, new int[][]{{40,40}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{42,42}})});
      builder.addAlternative(Parser.prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_, tmp);
	}
    protected static final void _init_prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(796, 0, new int[][]{{42,42}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{41,41}})});
      builder.addAlternative(Parser.prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_, tmp);
	}
    protected static final void _init_prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(798, 0, new int[][]{{0,39},{41,41},{43,16777215}}, null, null);
      builder.addAlternative(Parser.prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_(builder);
      
        _init_prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_(builder);
      
        _init_prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_(builder);
      
    }
  }
	
  protected static class Type {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__user_Type__name_Ident_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(800, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__user_Type__name_Ident_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__user_Type__name_Ident_(builder);
      
    }
  }
	
  protected static class Declarations {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new OptionalStackNode(816, 4, regular__opt__VarSect, new NonTerminalStackNode(818, 0, "VarSect", null, null), null, null);
      tmp[3] = new NonTerminalStackNode(814, 3, "layouts_Layouts", null, null);
      tmp[2] = new OptionalStackNode(810, 2, regular__opt__TypeSect, new NonTerminalStackNode(812, 0, "TypeSect", null, null), null, null);
      tmp[1] = new NonTerminalStackNode(808, 1, "layouts_Layouts", null, null);
      tmp[0] = new OptionalStackNode(804, 0, regular__opt__ConstSect, new NonTerminalStackNode(806, 0, "ConstSect", null, null), null, null);
      builder.addAlternative(Parser.prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_(builder);
      
    }
  }
	
  protected static class Natural {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[9];
      
      tmp[8] = new CharStackNode(850, 8, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[7] = new CharStackNode(848, 7, new int[][]{{48,57}}, null, null);
      tmp[6] = new CharStackNode(846, 6, new int[][]{{48,57}}, null, null);
      tmp[5] = new CharStackNode(844, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(842, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(840, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(838, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(836, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(834, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[0] = new CharStackNode(852, 0, new int[][]{{49,57}}, null, null);
      tmp[1] = new CharStackNode(854, 1, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(856, 2, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(858, 3, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(860, 4, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[4];
      
      tmp[3] = new CharStackNode(868, 3, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[2] = new CharStackNode(866, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(864, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(862, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new CharStackNode(874, 2, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[1] = new CharStackNode(872, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(870, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[10];
      
      tmp[9] = new CharStackNode(894, 9, new int[][]{{48,55}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[8] = new CharStackNode(892, 8, new int[][]{{48,52}}, null, null);
      tmp[7] = new CharStackNode(890, 7, new int[][]{{48,54}}, null, null);
      tmp[6] = new CharStackNode(888, 6, new int[][]{{48,51}}, null, null);
      tmp[5] = new CharStackNode(886, 5, new int[][]{{48,56}}, null, null);
      tmp[4] = new CharStackNode(884, 4, new int[][]{{48,52}}, null, null);
      tmp[3] = new CharStackNode(882, 3, new int[][]{{48,55}}, null, null);
      tmp[2] = new CharStackNode(880, 2, new int[][]{{48,52}}, null, null);
      tmp[1] = new CharStackNode(878, 1, new int[][]{{48,49}}, null, null);
      tmp[0] = new CharStackNode(876, 0, new int[][]{{49,50}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[6];
      
      tmp[5] = new CharStackNode(906, 5, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[4] = new CharStackNode(904, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(902, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(900, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(898, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(896, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new CharStackNode(920, 6, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[5] = new CharStackNode(918, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(916, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(914, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(912, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(910, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(908, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(922, 0, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      builder.addAlternative(Parser.prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[8];
      
      tmp[7] = new CharStackNode(938, 7, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[6] = new CharStackNode(936, 6, new int[][]{{48,57}}, null, null);
      tmp[5] = new CharStackNode(934, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(932, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(930, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(928, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(926, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(924, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[2];
      
      tmp[1] = new CharStackNode(942, 1, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[0] = new CharStackNode(940, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
        _init_prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(builder);
      
    }
  }
	
  protected static class ElsePart {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(966, 2, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(968, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(970, 1, "layouts_Layouts", null, null), new LiteralStackNode(972, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(974, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(964, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(962, 0, prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_, new int[] {69,76,83,69}, null, null);
      builder.addAlternative(Parser.prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_(builder);
      
    }
  }
	
  protected static class VarSect {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new SeparatedListStackNode(1000, 2, regular__iter_star_seps__VarDecl__layouts_Layouts, new NonTerminalStackNode(1002, 0, "VarDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(1004, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(998, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(996, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null);
      builder.addAlternative(Parser.prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable(builder);
      
    }
  }
	
  protected static class layouts_$BACKTICKS {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__layouts_$BACKTICKS__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(1020, 0);
      builder.addAlternative(Parser.prod__layouts_$BACKTICKS__, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_$BACKTICKS__(builder);
      
    }
  }
	
  protected static class layouts_$default$ {
    public final static AbstractStackNode[] EXPECTS;
    static{
      ExpectBuilder builder = new ExpectBuilder(_resultStoreIdMappings);
      init(builder);
      EXPECTS = builder.buildExpectArray();
    }
    
    protected static final void _init_prod__layouts_$default$__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(1054, 0);
      builder.addAlternative(Parser.prod__layouts_$default$__, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__layouts_$default$__(builder);
      
    }
  }
	
  public Parser() {
    super();
  }

  // Parse methods    
  
  public AbstractStackNode[] CommentElt() {
    return CommentElt.EXPECTS;
  }
  public AbstractStackNode[] Module() {
    return Module.EXPECTS;
  }
  public AbstractStackNode[] ConstDecl() {
    return ConstDecl.EXPECTS;
  }
  public AbstractStackNode[] start__Module() {
    return start__Module.EXPECTS;
  }
  public AbstractStackNode[] ConstSect() {
    return ConstSect.EXPECTS;
  }
  public AbstractStackNode[] TypeDecl() {
    return TypeDecl.EXPECTS;
  }
  public AbstractStackNode[] Layout() {
    return Layout.EXPECTS;
  }
  public AbstractStackNode[] layouts_Layouts() {
    return layouts_Layouts.EXPECTS;
  }
  public AbstractStackNode[] TypeSect() {
    return TypeSect.EXPECTS;
  }
  public AbstractStackNode[] Expression() {
    return Expression.EXPECTS;
  }
  public AbstractStackNode[] Ident() {
    return Ident.EXPECTS;
  }
  public AbstractStackNode[] layouts_$QUOTES() {
    return layouts_$QUOTES.EXPECTS;
  }
  public AbstractStackNode[] Body() {
    return Body.EXPECTS;
  }
  public AbstractStackNode[] Statement() {
    return Statement.EXPECTS;
  }
  public AbstractStackNode[] Keywords() {
    return Keywords.EXPECTS;
  }
  public AbstractStackNode[] Comment() {
    return Comment.EXPECTS;
  }
  public AbstractStackNode[] Label() {
    return Label.EXPECTS;
  }
  public AbstractStackNode[] Case() {
    return Case.EXPECTS;
  }
  public AbstractStackNode[] VarDecl() {
    return VarDecl.EXPECTS;
  }
  public AbstractStackNode[] ElsIfPart() {
    return ElsIfPart.EXPECTS;
  }
  public AbstractStackNode[] CommentChar() {
    return CommentChar.EXPECTS;
  }
  public AbstractStackNode[] Type() {
    return Type.EXPECTS;
  }
  public AbstractStackNode[] Declarations() {
    return Declarations.EXPECTS;
  }
  public AbstractStackNode[] Natural() {
    return Natural.EXPECTS;
  }
  public AbstractStackNode[] ElsePart() {
    return ElsePart.EXPECTS;
  }
  public AbstractStackNode[] VarSect() {
    return VarSect.EXPECTS;
  }
  public AbstractStackNode[] layouts_$BACKTICKS() {
    return layouts_$BACKTICKS.EXPECTS;
  }
  public AbstractStackNode[] layouts_$default$() {
    return layouts_$default$.EXPECTS;
  }
}