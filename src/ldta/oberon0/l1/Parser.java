package ldta.oberon0.l1;

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
    
    
    
    
    _putDontNest(result, 330, 328);
    
    _putDontNest(result, 320, 338);
    
    _putDontNest(result, 300, 298);
    
    _putDontNest(result, 280, 318);
    
    _putDontNest(result, 256, 278);
    
    _putDontNest(result, 278, 256);
    
    _putDontNest(result, 290, 308);
    
    _putDontNest(result, 272, 262);
    
    _putDontNest(result, 262, 272);
    
    _putDontNest(result, 310, 288);
    
    _putDontNest(result, 328, 338);
    
    _putDontNest(result, 288, 298);
    
    _putDontNest(result, 298, 308);
    
    _putDontNest(result, 272, 318);
    
    _putDontNest(result, 318, 288);
    
    _putDontNest(result, 310, 308);
    
    _putDontNest(result, 290, 288);
    
    _putDontNest(result, 278, 272);
    
    _putDontNest(result, 256, 262);
    
    _putDontNest(result, 262, 256);
    
    _putDontNest(result, 272, 278);
    
    _putDontNest(result, 264, 318);
    
    _putDontNest(result, 318, 308);
    
    _putDontNest(result, 298, 288);
    
    _putDontNest(result, 338, 328);
    
    _putDontNest(result, 308, 298);
    
    _putDontNest(result, 256, 318);
    
    _putDontNest(result, 262, 308);
    
    _putDontNest(result, 264, 298);
    
    _putDontNest(result, 278, 288);
    
    _putDontNest(result, 256, 298);
    
    _putDontNest(result, 308, 318);
    
    _putDontNest(result, 300, 318);
    
    _putDontNest(result, 278, 308);
    
    _putDontNest(result, 280, 298);
    
    _putDontNest(result, 262, 288);
    
    _putDontNest(result, 272, 298);
    
    _putDontNest(result, 288, 318);
    
    _putDontNest(result, 256, 338);
    
    _putDontNest(result, 264, 338);
    
    _putDontNest(result, 262, 328);
    
    _putDontNest(result, 272, 338);
    
    _putDontNest(result, 328, 318);
    
    _putDontNest(result, 280, 338);
    
    _putDontNest(result, 278, 328);
    
    _putDontNest(result, 320, 318);
    
    _putDontNest(result, 288, 338);
    
    _putDontNest(result, 298, 328);
    
    _putDontNest(result, 338, 288);
    
    _putDontNest(result, 328, 298);
    
    _putDontNest(result, 256, 246);
    
    _putDontNest(result, 290, 328);
    
    _putDontNest(result, 320, 298);
    
    _putDontNest(result, 330, 308);
    
    _putDontNest(result, 300, 338);
    
    _putDontNest(result, 272, 246);
    
    _putDontNest(result, 308, 338);
    
    _putDontNest(result, 318, 328);
    
    _putDontNest(result, 338, 308);
    
    _putDontNest(result, 330, 288);
    
    _putDontNest(result, 310, 328);
    
    _putDontNest(result, 228, 246);
    
    _putDontNest(result, 198, 338);
    
    _putDontNest(result, 236, 246);
    
    _putDontNest(result, 226, 236);
    
    _putDontNest(result, 182, 216);
    
    _putDontNest(result, 206, 338);
    
    _putDontNest(result, 216, 328);
    
    _putDontNest(result, 216, 206);
    
    _putDontNest(result, 218, 338);
    
    _putDontNest(result, 208, 328);
    
    _putDontNest(result, 236, 226);
    
    _putDontNest(result, 182, 298);
    
    _putDontNest(result, 236, 206);
    
    _putDontNest(result, 206, 236);
    
    _putDontNest(result, 226, 338);
    
    _putDontNest(result, 182, 262);
    
    _putDontNest(result, 236, 328);
    
    _putDontNest(result, 216, 226);
    
    _putDontNest(result, 182, 318);
    
    _putDontNest(result, 238, 338);
    
    _putDontNest(result, 228, 328);
    
    _putDontNest(result, 182, 278);
    
    _putDontNest(result, 248, 328);
    
    _putDontNest(result, 208, 246);
    
    _putDontNest(result, 246, 338);
    
    _putDontNest(result, 216, 246);
    
    _putDontNest(result, 228, 308);
    
    _putDontNest(result, 198, 278);
    
    _putDontNest(result, 208, 256);
    
    _putDontNest(result, 238, 298);
    
    _putDontNest(result, 218, 318);
    
    _putDontNest(result, 236, 308);
    
    _putDontNest(result, 206, 278);
    
    _putDontNest(result, 248, 288);
    
    _putDontNest(result, 216, 256);
    
    _putDontNest(result, 226, 298);
    
    _putDontNest(result, 218, 262);
    
    _putDontNest(result, 208, 272);
    
    _putDontNest(result, 206, 318);
    
    _putDontNest(result, 198, 262);
    
    _putDontNest(result, 228, 288);
    
    _putDontNest(result, 182, 236);
    
    _putDontNest(result, 226, 216);
    
    _putDontNest(result, 198, 318);
    
    _putDontNest(result, 216, 272);
    
    _putDontNest(result, 206, 262);
    
    _putDontNest(result, 246, 298);
    
    _putDontNest(result, 218, 278);
    
    _putDontNest(result, 236, 288);
    
    _putDontNest(result, 248, 308);
    
    _putDontNest(result, 208, 288);
    
    _putDontNest(result, 246, 262);
    
    _putDontNest(result, 226, 278);
    
    _putDontNest(result, 206, 298);
    
    _putDontNest(result, 228, 272);
    
    _putDontNest(result, 216, 288);
    
    _putDontNest(result, 246, 318);
    
    _putDontNest(result, 236, 272);
    
    _putDontNest(result, 198, 298);
    
    _putDontNest(result, 238, 318);
    
    _putDontNest(result, 246, 278);
    
    _putDontNest(result, 218, 298);
    
    _putDontNest(result, 206, 216);
    
    _putDontNest(result, 208, 308);
    
    _putDontNest(result, 228, 256);
    
    _putDontNest(result, 226, 262);
    
    _putDontNest(result, 182, 338);
    
    _putDontNest(result, 226, 318);
    
    _putDontNest(result, 216, 308);
    
    _putDontNest(result, 236, 256);
    
    _putDontNest(result, 262, 278);
    
    _putDontNest(result, 298, 298);
    
    _putDontNest(result, 278, 262);
    
    _putDontNest(result, 272, 256);
    
    _putDontNest(result, 256, 272);
    
    _putDontNest(result, 328, 328);
    
    _putDontNest(result, 288, 308);
    
    _putDontNest(result, 308, 288);
    
    _putDontNest(result, 290, 298);
    
    _putDontNest(result, 278, 318);
    
    _putDontNest(result, 330, 338);
    
    _putDontNest(result, 320, 328);
    
    _putDontNest(result, 300, 308);
    
    _putDontNest(result, 272, 272);
    
    _putDontNest(result, 256, 256);
    
    _putDontNest(result, 338, 338);
    
    _putDontNest(result, 308, 308);
    
    _putDontNest(result, 288, 288);
    
    _putDontNest(result, 318, 298);
    
    _putDontNest(result, 262, 318);
    
    _putDontNest(result, 300, 288);
    
    _putDontNest(result, 310, 298);
    
    _putDontNest(result, 272, 288);
    
    _putDontNest(result, 318, 318);
    
    _putDontNest(result, 256, 308);
    
    _putDontNest(result, 310, 318);
    
    _putDontNest(result, 280, 288);
    
    _putDontNest(result, 262, 298);
    
    _putDontNest(result, 264, 308);
    
    _putDontNest(result, 256, 288);
    
    _putDontNest(result, 298, 318);
    
    _putDontNest(result, 272, 308);
    
    _putDontNest(result, 264, 288);
    
    _putDontNest(result, 280, 308);
    
    _putDontNest(result, 278, 298);
    
    _putDontNest(result, 290, 318);
    
    _putDontNest(result, 264, 328);
    
    _putDontNest(result, 262, 338);
    
    _putDontNest(result, 256, 328);
    
    _putDontNest(result, 338, 318);
    
    _putDontNest(result, 280, 328);
    
    _putDontNest(result, 278, 338);
    
    _putDontNest(result, 330, 318);
    
    _putDontNest(result, 272, 328);
    
    _putDontNest(result, 262, 246);
    
    _putDontNest(result, 330, 298);
    
    _putDontNest(result, 290, 338);
    
    _putDontNest(result, 300, 328);
    
    _putDontNest(result, 320, 308);
    
    _putDontNest(result, 288, 328);
    
    _putDontNest(result, 298, 338);
    
    _putDontNest(result, 328, 308);
    
    _putDontNest(result, 278, 246);
    
    _putDontNest(result, 320, 288);
    
    _putDontNest(result, 310, 338);
    
    _putDontNest(result, 338, 298);
    
    _putDontNest(result, 328, 288);
    
    _putDontNest(result, 318, 338);
    
    _putDontNest(result, 308, 328);
    
    _putDontNest(result, 206, 206);
    
    _putDontNest(result, 236, 236);
    
    _putDontNest(result, 182, 288);
    
    _putDontNest(result, 206, 328);
    
    _putDontNest(result, 226, 246);
    
    _putDontNest(result, 198, 328);
    
    _putDontNest(result, 218, 328);
    
    _putDontNest(result, 208, 338);
    
    _putDontNest(result, 182, 308);
    
    _putDontNest(result, 246, 246);
    
    _putDontNest(result, 226, 226);
    
    _putDontNest(result, 216, 338);
    
    _putDontNest(result, 198, 246);
    
    _putDontNest(result, 238, 328);
    
    _putDontNest(result, 228, 338);
    
    _putDontNest(result, 182, 256);
    
    _putDontNest(result, 226, 328);
    
    _putDontNest(result, 206, 246);
    
    _putDontNest(result, 236, 338);
    
    _putDontNest(result, 226, 206);
    
    _putDontNest(result, 182, 272);
    
    _putDontNest(result, 216, 236);
    
    _putDontNest(result, 248, 338);
    
    _putDontNest(result, 246, 328);
    
    _putDontNest(result, 218, 246);
    
    _putDontNest(result, 206, 226);
    
    _putDontNest(result, 208, 262);
    
    _putDontNest(result, 226, 308);
    
    _putDontNest(result, 198, 272);
    
    _putDontNest(result, 246, 288);
    
    _putDontNest(result, 216, 318);
    
    _putDontNest(result, 236, 298);
    
    _putDontNest(result, 182, 226);
    
    _putDontNest(result, 238, 308);
    
    _putDontNest(result, 218, 256);
    
    _putDontNest(result, 206, 272);
    
    _putDontNest(result, 216, 262);
    
    _putDontNest(result, 208, 318);
    
    _putDontNest(result, 228, 298);
    
    _putDontNest(result, 248, 298);
    
    _putDontNest(result, 246, 308);
    
    _putDontNest(result, 226, 288);
    
    _putDontNest(result, 182, 246);
    
    _putDontNest(result, 198, 256);
    
    _putDontNest(result, 208, 278);
    
    _putDontNest(result, 236, 216);
    
    _putDontNest(result, 218, 272);
    
    _putDontNest(result, 206, 256);
    
    _putDontNest(result, 238, 288);
    
    _putDontNest(result, 216, 278);
    
    _putDontNest(result, 228, 278);
    
    _putDontNest(result, 226, 272);
    
    _putDontNest(result, 198, 308);
    
    _putDontNest(result, 216, 216);
    
    _putDontNest(result, 248, 318);
    
    _putDontNest(result, 246, 256);
    
    _putDontNest(result, 236, 278);
    
    _putDontNest(result, 218, 288);
    
    _putDontNest(result, 206, 308);
    
    _putDontNest(result, 228, 262);
    
    _putDontNest(result, 216, 298);
    
    _putDontNest(result, 226, 256);
    
    _putDontNest(result, 236, 318);
    
    _putDontNest(result, 198, 288);
    
    _putDontNest(result, 246, 272);
    
    _putDontNest(result, 236, 262);
    
    _putDontNest(result, 208, 298);
    
    _putDontNest(result, 228, 318);
    
    _putDontNest(result, 182, 206);
    
    _putDontNest(result, 182, 328);
    
    _putDontNest(result, 206, 288);
    
    _putDontNest(result, 218, 308);
   return result;
  }
    
  protected static IntegerMap _initDontNestGroups() {
    IntegerMap result = org.rascalmpl.library.lang.rascal.syntax.RascalRascal._initDontNestGroups();
    int resultStoreId = result.size();
    
    
    ++resultStoreId;
    
    result.putUnsafe(238, resultStoreId);
    result.putUnsafe(318, resultStoreId);
    result.putUnsafe(300, resultStoreId);
    result.putUnsafe(298, resultStoreId);
    result.putUnsafe(330, resultStoreId);
    result.putUnsafe(328, resultStoreId);
    result.putUnsafe(264, resultStoreId);
    result.putUnsafe(248, resultStoreId);
    result.putUnsafe(280, resultStoreId);
    result.putUnsafe(310, resultStoreId);
    result.putUnsafe(308, resultStoreId);
    result.putUnsafe(338, resultStoreId);
    result.putUnsafe(290, resultStoreId);
    result.putUnsafe(288, resultStoreId);
    result.putUnsafe(320, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(218, resultStoreId);
    result.putUnsafe(246, resultStoreId);
    result.putUnsafe(198, resultStoreId);
    result.putUnsafe(228, resultStoreId);
    result.putUnsafe(256, resultStoreId);
    result.putUnsafe(272, resultStoreId);
    result.putUnsafe(208, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(262, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(278, resultStoreId);
    ++resultStoreId;
    
    result.putUnsafe(206, resultStoreId);
    result.putUnsafe(236, resultStoreId);
    result.putUnsafe(216, resultStoreId);
    result.putUnsafe(182, resultStoreId);
    result.putUnsafe(226, resultStoreId);
      
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
	
  private static final IConstructor prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"WHILE\"),[\\char-class([range(87,87)]),\\char-class([range(72,72)]),\\char-class([range(73,73)]),\\char-class([range(76,76)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_END_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__ElsIfPart__lit_ELSIF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ElsIfPart\"),[lit(\"ELSIF\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"THEN\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"neq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"#\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[\\char-class([range(0,39),range(41,41),range(43,16777215)])],{})", Factory.Production);
  private static final IConstructor prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[conditional(\\char-class([range(42,42)]),{\\not-follow(\\char-class([range(41,41)]))})],{})", Factory.Production);
  private static final IConstructor prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_ = (IConstructor) _read("prod(lex(\"CommentChar\"),[conditional(\\char-class([range(40,40)]),{\\not-follow(\\char-class([range(42,42)]))})],{})", Factory.Production);
  private static final IConstructor prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"or\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"OR\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__id_Ident__conditional__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122__delete__Keywords_ = (IConstructor) _read("prod(label(\"id\",lex(\"Ident\")),[conditional(seq([conditional(\\char-class([range(65,90),range(97,122)]),{\\not-precede(\\char-class([range(65,90),range(97,122)]))}),conditional(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])),{\\not-follow(\\char-class([range(48,57),range(65,90),range(97,122)]))})]),{delete(keywords(\"Keywords\"))})],{})", Factory.Production);
  private static final IConstructor prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"mod\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"MOD\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__mod_Module__lit_MODULE_layouts_Layouts_name_Ident_layouts_Layouts_lit___59_layouts_Layouts_decls_Declarations_layouts_Layouts_body_opt__Body_layouts_Layouts_lit_END_layouts_Layouts_Ident_layouts_Layouts_lit___46_ = (IConstructor) _read("prod(label(\"mod\",sort(\"Module\")),[lit(\"MODULE\"),layouts(\"Layouts\"),label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\"),label(\"decls\",sort(\"Declarations\")),layouts(\"Layouts\"),label(\"body\",opt(sort(\"Body\"))),layouts(\"Layouts\"),lit(\"END\"),layouts(\"Layouts\"),lex(\"Ident\"),layouts(\"Layouts\"),lit(\".\")],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__TypeDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"TypeDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right = (IConstructor) _read("prod(label(\"pos\",sort(\"Expression\")),[lit(\"+\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{assoc(right())})", Factory.Production);
  private static final IConstructor prod__CommentElt__Comment_ = (IConstructor) _read("prod(lex(\"CommentElt\"),[lex(\"Comment\")],{})", Factory.Production);
  private static final IConstructor regular__iter_star__Layout = (IConstructor) _read("regular(\\iter-star(lex(\"Layout\")))", Factory.Production);
  private static final IConstructor prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"whileDo\",sort(\"Statement\")),[lit(\"WHILE\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"DO\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
  private static final IConstructor prod__ElsePart__lit_ELSE_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ElsePart\"),[lit(\"ELSE\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_ = (IConstructor) _read("prod(label(\"not\",sort(\"Expression\")),[lit(\"~\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__lit___62_61__char_class___range__62_62_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"\\>=\"),[\\char-class([range(62,62)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"sub\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"-\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__lit___42_41__char_class___range__42_42_char_class___range__41_41_ = (IConstructor) _read("prod(lit(\"*)\"),[\\char-class([range(42,42)]),\\char-class([range(41,41)])],{})", Factory.Production);
  private static final IConstructor prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_ = (IConstructor) _read("prod(lit(\"BEGIN\"),[\\char-class([range(66,66)]),\\char-class([range(69,69)]),\\char-class([range(71,71)]),\\char-class([range(73,73)]),\\char-class([range(78,78)])],{})", Factory.Production);
  private static final IConstructor prod__constDecl_ConstDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_value_Expression_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"constDecl\",sort(\"ConstDecl\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"value\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"mul\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"*\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"amp\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"&\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"lt\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\<\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_ = (IConstructor) _read("prod(lit(\"THEN\"),[\\char-class([range(84,84)]),\\char-class([range(72,72)]),\\char-class([range(69,69)]),\\char-class([range(78,78)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_CONST_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"CONST\")],{})", Factory.Production);
  private static final IConstructor prod__TypeSect__lit_TYPE_layouts_Layouts_types_iter_star_seps__TypeDecl__layouts_Layouts_ = (IConstructor) _read("prod(sort(\"TypeSect\"),[lit(\"TYPE\"),layouts(\"Layouts\"),label(\"types\",\\iter-star-seps(sort(\"TypeDecl\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit___59__char_class___range__59_59_ = (IConstructor) _read("prod(lit(\";\"),[\\char-class([range(59,59)])],{})", Factory.Production);
  private static final IConstructor prod__lit_DO__char_class___range__68_68_char_class___range__79_79_ = (IConstructor) _read("prod(lit(\"DO\"),[\\char-class([range(68,68)]),\\char-class([range(79,79)])],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__ConstDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"ConstDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__layouts_$BACKTICKS__ = (IConstructor) _read("prod(layouts(\"$BACKTICKS\"),[],{})", Factory.Production);
  private static final IConstructor prod__lit___58__char_class___range__58_58_ = (IConstructor) _read("prod(lit(\":\"),[\\char-class([range(58,58)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_DIV_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"DIV\")],{})", Factory.Production);
  private static final IConstructor prod__lit___61__char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"=\"),[\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_DO_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"DO\")],{})", Factory.Production);
  private static final IConstructor prod__lit___60__char_class___range__60_60_ = (IConstructor) _read("prod(lit(\"\\<\"),[\\char-class([range(60,60)])],{})", Factory.Production);
  private static final IConstructor prod__lit___62__char_class___range__62_62_ = (IConstructor) _read("prod(lit(\"\\>\"),[\\char-class([range(62,62)])],{})", Factory.Production);
  private static final IConstructor prod__skip_Statement__ = (IConstructor) _read("prod(label(\"skip\",sort(\"Statement\")),[],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_IF_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"IF\")],{})", Factory.Production);
  private static final IConstructor regular__opt__TypeSect = (IConstructor) _read("regular(opt(sort(\"TypeSect\")))", Factory.Production);
  private static final IConstructor regular__iter_star__CommentElt = (IConstructor) _read("regular(\\iter-star(lex(\"CommentElt\")))", Factory.Production);
  private static final IConstructor prod__empty__ = (IConstructor) _read("prod(empty(),[],{})", Factory.Production);
  private static final IConstructor prod__lit___60_61__char_class___range__60_60_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\"\\<=\"),[\\char-class([range(60,60)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_ = (IConstructor) _read("prod(lit(\"MOD\"),[\\char-class([range(77,77)]),\\char-class([range(79,79)]),\\char-class([range(68,68)])],{})", Factory.Production);
  private static final IConstructor prod__lit___40_42__char_class___range__40_40_char_class___range__42_42_ = (IConstructor) _read("prod(lit(\"(*\"),[\\char-class([range(40,40)]),\\char-class([range(42,42)])],{})", Factory.Production);
  private static final IConstructor prod__nat_Expression__value_Natural_ = (IConstructor) _read("prod(label(\"nat\",sort(\"Expression\")),[label(\"value\",lex(\"Natural\"))],{})", Factory.Production);
  private static final IConstructor prod__Body__lit_BEGIN_layouts_Layouts_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts__tag__Foldable = (IConstructor) _read("prod(sort(\"Body\"),[lit(\"BEGIN\"),layouts(\"Layouts\"),\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])],{tag(Foldable())})", Factory.Production);
  private static final IConstructor prod__layouts_$default$__ = (IConstructor) _read("prod(layouts(\"$default$\"),[],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_OR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"OR\")],{})", Factory.Production);
  private static final IConstructor prod__lit___41__char_class___range__41_41_ = (IConstructor) _read("prod(lit(\")\"),[\\char-class([range(41,41)])],{})", Factory.Production);
  private static final IConstructor prod__lit___40__char_class___range__40_40_ = (IConstructor) _read("prod(lit(\"(\"),[\\char-class([range(40,40)])],{})", Factory.Production);
  private static final IConstructor prod__lit___43__char_class___range__43_43_ = (IConstructor) _read("prod(lit(\"+\"),[\\char-class([range(43,43)])],{})", Factory.Production);
  private static final IConstructor prod__lit___42__char_class___range__42_42_ = (IConstructor) _read("prod(lit(\"*\"),[\\char-class([range(42,42)])],{})", Factory.Production);
  private static final IConstructor regular__opt__ConstSect = (IConstructor) _read("regular(opt(sort(\"ConstSect\")))", Factory.Production);
  private static final IConstructor prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"eq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_MODULE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"MODULE\")],{})", Factory.Production);
  private static final IConstructor prod__lit____char_class___range__45_45_ = (IConstructor) _read("prod(lit(\"-\"),[\\char-class([range(45,45)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_IF__char_class___range__73_73_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"IF\"),[\\char-class([range(73,73)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__lit___44__char_class___range__44_44_ = (IConstructor) _read("prod(lit(\",\"),[\\char-class([range(44,44)])],{})", Factory.Production);
  private static final IConstructor prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket = (IConstructor) _read("prod(label(\"Bracket\",sort(\"Expression\")),[lit(\"(\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\")\")],{bracket()})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__lit___46__char_class___range__46_46_ = (IConstructor) _read("prod(lit(\".\"),[\\char-class([range(46,46)])],{})", Factory.Production);
  private static final IConstructor prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_ = (IConstructor) _read("prod(lit(\"ELSIF\"),[\\char-class([range(69,69)]),\\char-class([range(76,76)]),\\char-class([range(83,83)]),\\char-class([range(73,73)]),\\char-class([range(70,70)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_MOD_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"MOD\")],{})", Factory.Production);
  private static final IConstructor prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"ELSE\"),[\\char-class([range(69,69)]),\\char-class([range(76,76)]),\\char-class([range(83,83)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,50)]),\\char-class([range(48,49)]),\\char-class([range(48,52)]),\\char-class([range(48,55)]),\\char-class([range(48,52)]),\\char-class([range(48,56)]),\\char-class([range(48,51)]),\\char-class([range(48,54)]),\\char-class([range(48,52)]),conditional(\\char-class([range(48,55)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_VAR_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"VAR\")],{})", Factory.Production);
  private static final IConstructor prod__lit___35__char_class___range__35_35_ = (IConstructor) _read("prod(lit(\"#\"),[\\char-class([range(35,35)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"geq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\>=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"TYPE\"),[\\char-class([range(84,84)]),\\char-class([range(89,89)]),\\char-class([range(80,80)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__lit___38__char_class___range__38_38_ = (IConstructor) _read("prod(lit(\"&\"),[\\char-class([range(38,38)])],{})", Factory.Production);
  private static final IConstructor regular__iter__CommentChar = (IConstructor) _read("regular(iter(lex(\"CommentChar\")))", Factory.Production);
  private static final IConstructor prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_ = (IConstructor) _read("prod(lit(\"DIV\"),[\\char-class([range(68,68)]),\\char-class([range(73,73)]),\\char-class([range(86,86)])],{})", Factory.Production);
  private static final IConstructor prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_ = (IConstructor) _read("prod(lit(\"MODULE\"),[\\char-class([range(77,77)]),\\char-class([range(79,79)]),\\char-class([range(68,68)]),\\char-class([range(85,85)]),\\char-class([range(76,76)]),\\char-class([range(69,69)])],{})", Factory.Production);
  private static final IConstructor prod__lookup_Expression__var_Ident_ = (IConstructor) _read("prod(label(\"lookup\",sort(\"Expression\")),[label(\"var\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right = (IConstructor) _read("prod(label(\"neg\",sort(\"Expression\")),[lit(\"-\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{assoc(right())})", Factory.Production);
  private static final IConstructor prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"div\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"DIV\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_ELSE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"ELSE\")],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__lit_OR__char_class___range__79_79_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"OR\"),[\\char-class([range(79,79)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_ = (IConstructor) _read("prod(lit(\"VAR\"),[\\char-class([range(86,86)]),\\char-class([range(65,65)]),\\char-class([range(82,82)])],{})", Factory.Production);
  private static final IConstructor prod__start__Module__layouts_Layouts_top_Module_layouts_Layouts_ = (IConstructor) _read("prod(start(sort(\"Module\")),[layouts(\"Layouts\"),label(\"top\",sort(\"Module\")),layouts(\"Layouts\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_THEN_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"THEN\")],{})", Factory.Production);
  private static final IConstructor regular__iter_star__char_class___range__48_57_range__65_90_range__97_122 = (IConstructor) _read("regular(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])))", Factory.Production);
  private static final IConstructor prod__typeDecl_TypeDecl__name_Ident_layouts_Layouts_lit___61_layouts_Layouts_type_Type_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"typeDecl\",sort(\"TypeDecl\")),[label(\"name\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\"=\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor prod__CommentElt__iter__CommentChar_ = (IConstructor) _read("prod(lex(\"CommentElt\"),[iter(lex(\"CommentChar\"))],{})", Factory.Production);
  private static final IConstructor prod__Layout__Comment__tag__category___67_111_109_109_101_110_116 = (IConstructor) _read("prod(lex(\"Layout\"),[lex(\"Comment\")],{tag(category(\"Comment\"))})", Factory.Production);
  private static final IConstructor prod__VarSect__lit_VAR_layouts_Layouts_vars_iter_star_seps__VarDecl__layouts_Layouts__tag__Foldable = (IConstructor) _read("prod(sort(\"VarSect\"),[lit(\"VAR\"),layouts(\"Layouts\"),label(\"vars\",\\iter-star-seps(sort(\"VarDecl\"),[layouts(\"Layouts\")]))],{tag(Foldable())})", Factory.Production);
  private static final IConstructor regular__opt__Body = (IConstructor) _read("regular(opt(sort(\"Body\")))", Factory.Production);
  private static final IConstructor prod__decls_Declarations__consts_opt__ConstSect_layouts_Layouts_types_opt__TypeSect_layouts_Layouts_vars_opt__VarSect_ = (IConstructor) _read("prod(label(\"decls\",sort(\"Declarations\")),[label(\"consts\",opt(sort(\"ConstSect\"))),layouts(\"Layouts\"),label(\"types\",opt(sort(\"TypeSect\"))),layouts(\"Layouts\"),label(\"vars\",opt(sort(\"VarSect\")))],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_TYPE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"TYPE\")],{})", Factory.Production);
  private static final IConstructor prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_ = (IConstructor) _read("prod(lit(\"CONST\"),[\\char-class([range(67,67)]),\\char-class([range(79,79)]),\\char-class([range(78,78)]),\\char-class([range(83,83)]),\\char-class([range(84,84)])],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_BEGIN_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"BEGIN\")],{})", Factory.Production);
  private static final IConstructor prod__lit___126__char_class___range__126_126_ = (IConstructor) _read("prod(lit(\"~\"),[\\char-class([range(126,126)])],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_ = (IConstructor) _read("prod(label(\"assign\",sort(\"Statement\")),[label(\"var\",lex(\"Ident\")),layouts(\"Layouts\"),lit(\":=\"),layouts(\"Layouts\"),label(\"exp\",sort(\"Expression\"))],{})", Factory.Production);
  private static final IConstructor prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_ = (IConstructor) _read("prod(lex(\"Natural\"),[\\char-class([range(49,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),\\char-class([range(48,57)]),conditional(\\char-class([range(48,57)]),{\\not-follow(\\char-class([range(48,57)]))})],{})", Factory.Production);
  private static final IConstructor regular__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122 = (IConstructor) _read("regular(seq([conditional(\\char-class([range(65,90),range(97,122)]),{\\not-precede(\\char-class([range(65,90),range(97,122)]))}),conditional(\\iter-star(\\char-class([range(48,57),range(65,90),range(97,122)])),{\\not-follow(\\char-class([range(48,57),range(65,90),range(97,122)]))})]))", Factory.Production);
  private static final IConstructor regular__iter_star__char_class___range__9_10_range__13_13_range__32_32 = (IConstructor) _read("regular(\\iter-star(\\char-class([range(9,10),range(13,13),range(32,32)])))", Factory.Production);
  private static final IConstructor prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_ = (IConstructor) _read("prod(lit(\":=\"),[\\char-class([range(58,58)]),\\char-class([range(61,61)])],{})", Factory.Production);
  private static final IConstructor prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"leq\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\<=\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_ = (IConstructor) _read("prod(lex(\"Comment\"),[lit(\"(*\"),\\iter-star(lex(\"CommentElt\")),lit(\"*)\")],{})", Factory.Production);
  private static final IConstructor prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc = (IConstructor) _read("prod(label(\"gt\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"\\>\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(\\non-assoc())})", Factory.Production);
  private static final IConstructor prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left = (IConstructor) _read("prod(label(\"add\",sort(\"Expression\")),[label(\"lhs\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"+\"),layouts(\"Layouts\"),label(\"rhs\",sort(\"Expression\"))],{assoc(left())})", Factory.Production);
  private static final IConstructor prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_ = (IConstructor) _read("prod(label(\"whitespace\",lex(\"Layout\")),[\\char-class([range(9,10),range(13,13),range(32,32)])],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__ElsIfPart__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"ElsIfPart\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__user_Type__name_Ident_ = (IConstructor) _read("prod(label(\"user\",sort(\"Type\")),[label(\"name\",lex(\"Ident\"))],{})", Factory.Production);
  private static final IConstructor prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_ = (IConstructor) _read("prod(lit(\"END\"),[\\char-class([range(69,69)]),\\char-class([range(78,78)]),\\char-class([range(68,68)])],{})", Factory.Production);
  private static final IConstructor prod__layouts_Layouts__conditional__iter_star__Layout__not_follow__char_class___range__9_10_range__13_13_range__32_32_not_follow__lit___40_42_ = (IConstructor) _read("prod(layouts(\"Layouts\"),[conditional(\\iter-star(lex(\"Layout\")),{\\not-follow(\\char-class([range(9,10),range(13,13),range(32,32)])),\\not-follow(lit(\"(*\"))})],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_ELSIF_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"ELSIF\")],{})", Factory.Production);
  private static final IConstructor prod__Keywords__lit_WHILE_ = (IConstructor) _read("prod(keywords(\"Keywords\"),[lit(\"WHILE\")],{})", Factory.Production);
  private static final IConstructor regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts = (IConstructor) _read("regular(\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__varDecl_VarDecl__names_iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts_layouts_Layouts_lit___58_layouts_Layouts_type_Type_layouts_Layouts_lit___59_ = (IConstructor) _read("prod(label(\"varDecl\",sort(\"VarDecl\")),[label(\"names\",\\iter-star-seps(lex(\"Ident\"),[layouts(\"Layouts\"),lit(\",\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),lit(\":\"),layouts(\"Layouts\"),label(\"type\",sort(\"Type\")),layouts(\"Layouts\"),lit(\";\")],{})", Factory.Production);
  private static final IConstructor regular__opt__ElsePart = (IConstructor) _read("regular(opt(sort(\"ElsePart\")))", Factory.Production);
  private static final IConstructor prod__ConstSect__lit_CONST_layouts_Layouts_consts_iter_star_seps__ConstDecl__layouts_Layouts_ = (IConstructor) _read("prod(sort(\"ConstSect\"),[lit(\"CONST\"),layouts(\"Layouts\"),label(\"consts\",\\iter-star-seps(sort(\"ConstDecl\"),[layouts(\"Layouts\")]))],{})", Factory.Production);
  private static final IConstructor prod__layouts_$QUOTES__conditional__iter_star__char_class___range__9_10_range__13_13_range__32_32__not_follow__char_class___range__9_10_range__13_13_range__32_32_ = (IConstructor) _read("prod(layouts(\"$QUOTES\"),[conditional(\\iter-star(\\char-class([range(9,10),range(13,13),range(32,32)])),{\\not-follow(\\char-class([range(9,10),range(13,13),range(32,32)]))})],{})", Factory.Production);
  private static final IConstructor regular__iter_star_seps__VarDecl__layouts_Layouts = (IConstructor) _read("regular(\\iter-star-seps(sort(\"VarDecl\"),[layouts(\"Layouts\")]))", Factory.Production);
  private static final IConstructor prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_ = (IConstructor) _read("prod(label(\"ifThen\",sort(\"Statement\")),[lit(\"IF\"),layouts(\"Layouts\"),label(\"condition\",sort(\"Expression\")),layouts(\"Layouts\"),lit(\"THEN\"),layouts(\"Layouts\"),label(\"body\",\\iter-seps(sort(\"Statement\"),[layouts(\"Layouts\"),lit(\";\"),layouts(\"Layouts\")])),layouts(\"Layouts\"),\\iter-star-seps(sort(\"ElsIfPart\"),[layouts(\"Layouts\")]),layouts(\"Layouts\"),opt(sort(\"ElsePart\")),layouts(\"Layouts\"),lit(\"END\")],{})", Factory.Production);
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
      
      tmp[14] = new LiteralStackNode(48, 14, prod__lit___46__char_class___range__46_46_, new int[] {46}, null, null);
      tmp[13] = new NonTerminalStackNode(46, 13, "layouts_Layouts", null, null);
      tmp[12] = new NonTerminalStackNode(44, 12, "Ident", null, null);
      tmp[11] = new NonTerminalStackNode(42, 11, "layouts_Layouts", null, null);
      tmp[10] = new LiteralStackNode(40, 10, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[9] = new NonTerminalStackNode(38, 9, "layouts_Layouts", null, null);
      tmp[8] = new OptionalStackNode(34, 8, regular__opt__Body, new NonTerminalStackNode(36, 0, "Body", null, null), null, null);
      tmp[7] = new NonTerminalStackNode(32, 7, "layouts_Layouts", null, null);
      tmp[6] = new NonTerminalStackNode(30, 6, "Declarations", null, null);
      tmp[5] = new NonTerminalStackNode(28, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(26, 4, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[3] = new NonTerminalStackNode(24, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(22, 2, "Ident", null, null);
      tmp[1] = new NonTerminalStackNode(20, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(18, 0, prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_, new int[] {77,79,68,85,76,69}, null, null);
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
      
      tmp[6] = new LiteralStackNode(62, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(60, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(58, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(56, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(54, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[1] = new NonTerminalStackNode(52, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(50, 0, "Ident", null, null);
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
      
      tmp[2] = new NonTerminalStackNode(98, 2, "layouts_Layouts", null, null);
      tmp[1] = new NonTerminalStackNode(96, 1, "Module", null, null);
      tmp[0] = new NonTerminalStackNode(94, 0, "layouts_Layouts", null, null);
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
      
      tmp[2] = new SeparatedListStackNode(108, 2, regular__iter_star_seps__ConstDecl__layouts_Layouts, new NonTerminalStackNode(110, 0, "ConstDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(112, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(106, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(104, 0, prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_, new int[] {67,79,78,83,84}, null, null);
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
      
      tmp[6] = new LiteralStackNode(126, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(124, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(122, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(120, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(118, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[1] = new NonTerminalStackNode(116, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(114, 0, "Ident", null, null);
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
      
      tmp[0] = new CharStackNode(134, 0, new int[][]{{9,10},{13,13},{32,32}}, null, null);
      builder.addAlternative(Parser.prod__whitespace_Layout__char_class___range__9_10_range__13_13_range__32_32_, tmp);
	}
    protected static final void _init_prod__Layout__Comment__tag__category___67_111_109_109_101_110_116(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(136, 0, "Comment", null, null);
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
      
      tmp[0] = new ListStackNode(146, 0, regular__iter_star__Layout, new NonTerminalStackNode(148, 0, "Layout", null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{9,10},{13,13},{32,32}}), new StringFollowRestriction(new int[] {40,42})});
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
      
      tmp[2] = new SeparatedListStackNode(160, 2, regular__iter_star_seps__TypeDecl__layouts_Layouts, new NonTerminalStackNode(162, 0, "TypeDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(164, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(158, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(156, 0, prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_, new int[] {84,89,80,69}, null, null);
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
      
      tmp[0] = new SequenceStackNode(342, 0, regular__seq___conditional__char_class___range__65_90_range__97_122__not_precede__char_class___range__65_90_range__97_122_conditional__iter_star__char_class___range__48_57_range__65_90_range__97_122__not_follow__char_class___range__48_57_range__65_90_range__97_122, new AbstractStackNode[]{new CharStackNode(344, 0, new int[][]{{65,90},{97,122}}, new IEnterFilter[] {new CharPrecedeRestriction(new int[][]{{65,90},{97,122}})}, null), new ListStackNode(346, 1, regular__iter_star__char_class___range__48_57_range__65_90_range__97_122, new CharStackNode(348, 0, new int[][]{{48,57},{65,90},{97,122}}, null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57},{65,90},{97,122}})})}, null, new ICompletionFilter[] {new StringMatchRestriction(new int[] {86,65,82}), new StringMatchRestriction(new int[] {68,73,86}), new StringMatchRestriction(new int[] {87,72,73,76,69}), new StringMatchRestriction(new int[] {77,79,68}), new StringMatchRestriction(new int[] {67,79,78,83,84}), new StringMatchRestriction(new int[] {79,82}), new StringMatchRestriction(new int[] {77,79,68,85,76,69}), new StringMatchRestriction(new int[] {84,72,69,78}), new StringMatchRestriction(new int[] {73,70}), new StringMatchRestriction(new int[] {66,69,71,73,78}), new StringMatchRestriction(new int[] {69,76,83,73,70}), new StringMatchRestriction(new int[] {69,76,83,69}), new StringMatchRestriction(new int[] {84,89,80,69}), new StringMatchRestriction(new int[] {68,79}), new StringMatchRestriction(new int[] {69,78,68})});
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
      
      tmp[4] = new NonTerminalStackNode(318, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(316, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(314, 2, prod__lit___35__char_class___range__35_35_, new int[] {35}, null, null);
      tmp[1] = new NonTerminalStackNode(312, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(310, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__neq_Expression__lhs_Expression_layouts_Layouts_lit___35_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__lookup_Expression__var_Ident_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(194, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__lookup_Expression__var_Ident_, tmp);
	}
    protected static final void _init_prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[0] = new NonTerminalStackNode(264, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(266, 1, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(268, 2, prod__lit_OR__char_class___range__79_79_char_class___range__82_82_, new int[] {79,82}, null, null);
      tmp[3] = new NonTerminalStackNode(270, 3, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(272, 4, "Expression", null, null);
      builder.addAlternative(Parser.prod__or_Expression__lhs_Expression_layouts_Layouts_lit_OR_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(226, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(224, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(222, 2, prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_, new int[] {68,73,86}, null, null);
      tmp[1] = new NonTerminalStackNode(220, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(218, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__div_Expression__lhs_Expression_layouts_Layouts_lit_DIV_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(262, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(260, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(258, 0, prod__lit____char_class___range__45_45_, new int[] {45}, null, null);
      builder.addAlternative(Parser.prod__neg_Expression__lit___layouts_Layouts_exp_Expression__assoc__right, tmp);
	}
    protected static final void _init_prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(236, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(234, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(232, 2, prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_, new int[] {77,79,68}, null, null);
      tmp[1] = new NonTerminalStackNode(230, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(228, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__mod_Expression__lhs_Expression_layouts_Layouts_lit_MOD_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(278, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(276, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(274, 0, prod__lit___43__char_class___range__43_43_, new int[] {43}, null, null);
      builder.addAlternative(Parser.prod__pos_Expression__lit___43_layouts_Layouts_exp_Expression__assoc__right, tmp);
	}
    protected static final void _init_prod__nat_Expression__value_Natural_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new NonTerminalStackNode(196, 0, "Natural", null, null);
      builder.addAlternative(Parser.prod__nat_Expression__value_Natural_, tmp);
	}
    protected static final void _init_prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new NonTerminalStackNode(182, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(180, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(178, 0, prod__lit___126__char_class___range__126_126_, new int[] {126}, null, null);
      builder.addAlternative(Parser.prod__not_Expression__lit___126_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(288, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(286, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(284, 2, prod__lit___60_61__char_class___range__60_60_char_class___range__61_61_, new int[] {60,61}, null, null);
      tmp[1] = new NonTerminalStackNode(282, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(280, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__leq_Expression__lhs_Expression_layouts_Layouts_lit___60_61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(246, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(244, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(242, 2, prod__lit____char_class___range__45_45_, new int[] {45}, null, null);
      tmp[1] = new NonTerminalStackNode(240, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(238, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__sub_Expression__lhs_Expression_layouts_Layouts_lit___layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(298, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(296, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(294, 2, prod__lit___62__char_class___range__62_62_, new int[] {62}, null, null);
      tmp[1] = new NonTerminalStackNode(292, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(290, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__gt_Expression__lhs_Expression_layouts_Layouts_lit___62_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(308, 4, "Expression", null, null);
      tmp[0] = new NonTerminalStackNode(300, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(302, 1, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(304, 2, prod__lit___61__char_class___range__61_61_, new int[] {61}, null, null);
      tmp[3] = new NonTerminalStackNode(306, 3, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__eq_Expression__lhs_Expression_layouts_Layouts_lit___61_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(256, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(254, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(252, 2, prod__lit___43__char_class___range__43_43_, new int[] {43}, null, null);
      tmp[1] = new NonTerminalStackNode(250, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(248, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__add_Expression__lhs_Expression_layouts_Layouts_lit___43_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new LiteralStackNode(192, 4, prod__lit___41__char_class___range__41_41_, new int[] {41}, null, null);
      tmp[3] = new NonTerminalStackNode(190, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(188, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(186, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(184, 0, prod__lit___40__char_class___range__40_40_, new int[] {40}, null, null);
      builder.addAlternative(Parser.prod__Bracket_Expression__lit___40_layouts_Layouts_exp_Expression_layouts_Layouts_lit___41__bracket, tmp);
	}
    protected static final void _init_prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(206, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(204, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(202, 2, prod__lit___42__char_class___range__42_42_, new int[] {42}, null, null);
      tmp[1] = new NonTerminalStackNode(200, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(198, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__mul_Expression__lhs_Expression_layouts_Layouts_lit___42_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(328, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(326, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(324, 2, prod__lit___60__char_class___range__60_60_, new int[] {60}, null, null);
      tmp[1] = new NonTerminalStackNode(322, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(320, 0, "Expression", null, null);
      builder.addAlternative(Parser.prod__lt_Expression__lhs_Expression_layouts_Layouts_lit___60_layouts_Layouts_rhs_Expression__assoc__non_assoc, tmp);
	}
    protected static final void _init_prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(216, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(214, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(212, 2, prod__lit___38__char_class___range__38_38_, new int[] {38}, null, null);
      tmp[0] = new NonTerminalStackNode(208, 0, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(210, 1, "layouts_Layouts", null, null);
      builder.addAlternative(Parser.prod__amp_Expression__lhs_Expression_layouts_Layouts_lit___38_layouts_Layouts_rhs_Expression__assoc__left, tmp);
	}
    protected static final void _init_prod__geq_Expression__lhs_Expression_layouts_Layouts_lit___62_61_layouts_Layouts_rhs_Expression__assoc__non_assoc(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[4] = new NonTerminalStackNode(338, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(336, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(334, 2, prod__lit___62_61__char_class___range__62_62_char_class___range__61_61_, new int[] {62,61}, null, null);
      tmp[1] = new NonTerminalStackNode(332, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(330, 0, "Expression", null, null);
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
      
      tmp[0] = new ListStackNode(350, 0, regular__iter_star__char_class___range__9_10_range__13_13_range__32_32, new CharStackNode(352, 0, new int[][]{{9,10},{13,13},{32,32}}, null, null), false, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{9,10},{13,13},{32,32}})});
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
      
      tmp[2] = new SeparatedListStackNode(370, 2, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(372, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(374, 1, "layouts_Layouts", null, null), new LiteralStackNode(376, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(378, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(368, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(366, 0, prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_, new int[] {66,69,71,73,78}, null, null);
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
      
      tmp[4] = new NonTerminalStackNode(390, 4, "Expression", null, null);
      tmp[3] = new NonTerminalStackNode(388, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(386, 2, prod__lit___58_61__char_class___range__58_58_char_class___range__61_61_, new int[] {58,61}, null, null);
      tmp[1] = new NonTerminalStackNode(384, 1, "layouts_Layouts", null, null);
      tmp[0] = new NonTerminalStackNode(382, 0, "Ident", null, null);
      builder.addAlternative(Parser.prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_, tmp);
	}
    protected static final void _init_prod__skip_Statement__(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new EpsilonStackNode(392, 0);
      builder.addAlternative(Parser.prod__skip_Statement__, tmp);
	}
    protected static final void _init_prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[9];
      
      tmp[8] = new LiteralStackNode(418, 8, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[7] = new NonTerminalStackNode(416, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(406, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(408, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(410, 1, "layouts_Layouts", null, null), new LiteralStackNode(412, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(414, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(404, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(402, 4, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      tmp[3] = new NonTerminalStackNode(400, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(398, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(396, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(394, 0, prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_, new int[] {87,72,73,76,69}, null, null);
      builder.addAlternative(Parser.prod__whileDo_Statement__lit_WHILE_layouts_Layouts_condition_Expression_layouts_Layouts_lit_DO_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_lit_END_, tmp);
	}
    protected static final void _init_prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[13];
      
      tmp[12] = new LiteralStackNode(458, 12, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      tmp[11] = new NonTerminalStackNode(456, 11, "layouts_Layouts", null, null);
      tmp[10] = new OptionalStackNode(452, 10, regular__opt__ElsePart, new NonTerminalStackNode(454, 0, "ElsePart", null, null), null, null);
      tmp[9] = new NonTerminalStackNode(450, 9, "layouts_Layouts", null, null);
      tmp[8] = new SeparatedListStackNode(444, 8, regular__iter_star_seps__ElsIfPart__layouts_Layouts, new NonTerminalStackNode(446, 0, "ElsIfPart", null, null), new AbstractStackNode[]{new NonTerminalStackNode(448, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[7] = new NonTerminalStackNode(442, 7, "layouts_Layouts", null, null);
      tmp[6] = new SeparatedListStackNode(432, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(434, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(436, 1, "layouts_Layouts", null, null), new LiteralStackNode(438, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(440, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(430, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(428, 4, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      tmp[3] = new NonTerminalStackNode(426, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(424, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(422, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(420, 0, prod__lit_IF__char_class___range__73_73_char_class___range__70_70_, new int[] {73,70}, null, null);
      builder.addAlternative(Parser.prod__ifThen_Statement__lit_IF_layouts_Layouts_condition_Expression_layouts_Layouts_lit_THEN_layouts_Layouts_body_iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts_layouts_Layouts_iter_star_seps__ElsIfPart__layouts_Layouts_layouts_Layouts_opt__ElsePart_layouts_Layouts_lit_END_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__assign_Statement__var_Ident_layouts_Layouts_lit___58_61_layouts_Layouts_exp_Expression_(builder);
      
        _init_prod__skip_Statement__(builder);
      
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
    
    protected static final void _init_prod__Keywords__lit_THEN_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(460, 0, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_THEN_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_DIV_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(462, 0, prod__lit_DIV__char_class___range__68_68_char_class___range__73_73_char_class___range__86_86_, new int[] {68,73,86}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_DIV_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_MODULE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(464, 0, prod__lit_MODULE__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_char_class___range__85_85_char_class___range__76_76_char_class___range__69_69_, new int[] {77,79,68,85,76,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_MODULE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_DO_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(466, 0, prod__lit_DO__char_class___range__68_68_char_class___range__79_79_, new int[] {68,79}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_DO_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_BEGIN_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(468, 0, prod__lit_BEGIN__char_class___range__66_66_char_class___range__69_69_char_class___range__71_71_char_class___range__73_73_char_class___range__78_78_, new int[] {66,69,71,73,78}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_BEGIN_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ELSIF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(470, 0, prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_, new int[] {69,76,83,73,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ELSIF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_END_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(472, 0, prod__lit_END__char_class___range__69_69_char_class___range__78_78_char_class___range__68_68_, new int[] {69,78,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_END_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_MOD_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(474, 0, prod__lit_MOD__char_class___range__77_77_char_class___range__79_79_char_class___range__68_68_, new int[] {77,79,68}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_MOD_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_IF_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(476, 0, prod__lit_IF__char_class___range__73_73_char_class___range__70_70_, new int[] {73,70}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_IF_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_WHILE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(478, 0, prod__lit_WHILE__char_class___range__87_87_char_class___range__72_72_char_class___range__73_73_char_class___range__76_76_char_class___range__69_69_, new int[] {87,72,73,76,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_WHILE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_VAR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(480, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_VAR_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_ELSE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(482, 0, prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_, new int[] {69,76,83,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_ELSE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_TYPE_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(484, 0, prod__lit_TYPE__char_class___range__84_84_char_class___range__89_89_char_class___range__80_80_char_class___range__69_69_, new int[] {84,89,80,69}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_TYPE_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_CONST_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(486, 0, prod__lit_CONST__char_class___range__67_67_char_class___range__79_79_char_class___range__78_78_char_class___range__83_83_char_class___range__84_84_, new int[] {67,79,78,83,84}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_CONST_, tmp);
	}
    protected static final void _init_prod__Keywords__lit_OR_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new LiteralStackNode(488, 0, prod__lit_OR__char_class___range__79_79_char_class___range__82_82_, new int[] {79,82}, null, null);
      builder.addAlternative(Parser.prod__Keywords__lit_OR_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Keywords__lit_THEN_(builder);
      
        _init_prod__Keywords__lit_DIV_(builder);
      
        _init_prod__Keywords__lit_MODULE_(builder);
      
        _init_prod__Keywords__lit_DO_(builder);
      
        _init_prod__Keywords__lit_BEGIN_(builder);
      
        _init_prod__Keywords__lit_ELSIF_(builder);
      
        _init_prod__Keywords__lit_END_(builder);
      
        _init_prod__Keywords__lit_MOD_(builder);
      
        _init_prod__Keywords__lit_IF_(builder);
      
        _init_prod__Keywords__lit_WHILE_(builder);
      
        _init_prod__Keywords__lit_VAR_(builder);
      
        _init_prod__Keywords__lit_ELSE_(builder);
      
        _init_prod__Keywords__lit_TYPE_(builder);
      
        _init_prod__Keywords__lit_CONST_(builder);
      
        _init_prod__Keywords__lit_OR_(builder);
      
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
      
      tmp[2] = new LiteralStackNode(516, 2, prod__lit___42_41__char_class___range__42_42_char_class___range__41_41_, new int[] {42,41}, null, null);
      tmp[1] = new ListStackNode(512, 1, regular__iter_star__CommentElt, new NonTerminalStackNode(514, 0, "CommentElt", null, null), false, null, null);
      tmp[0] = new LiteralStackNode(510, 0, prod__lit___40_42__char_class___range__40_40_char_class___range__42_42_, new int[] {40,42}, null, null);
      builder.addAlternative(Parser.prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_, tmp);
	}
    public static void init(ExpectBuilder builder){
      
      
        _init_prod__Comment__lit___40_42_iter_star__CommentElt_lit___42_41_(builder);
      
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
      
      tmp[6] = new LiteralStackNode(550, 6, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null);
      tmp[5] = new NonTerminalStackNode(548, 5, "layouts_Layouts", null, null);
      tmp[4] = new NonTerminalStackNode(546, 4, "Type", null, null);
      tmp[3] = new NonTerminalStackNode(544, 3, "layouts_Layouts", null, null);
      tmp[2] = new LiteralStackNode(542, 2, prod__lit___58__char_class___range__58_58_, new int[] {58}, null, null);
      tmp[1] = new NonTerminalStackNode(540, 1, "layouts_Layouts", null, null);
      tmp[0] = new SeparatedListStackNode(530, 0, regular__iter_star_seps__Ident__layouts_Layouts_lit___44_layouts_Layouts, new NonTerminalStackNode(532, 0, "Ident", null, null), new AbstractStackNode[]{new NonTerminalStackNode(534, 1, "layouts_Layouts", null, null), new LiteralStackNode(536, 2, prod__lit___44__char_class___range__44_44_, new int[] {44}, null, null), new NonTerminalStackNode(538, 3, "layouts_Layouts", null, null)}, false, null, null);
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
      
      tmp[6] = new SeparatedListStackNode(576, 6, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(578, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(580, 1, "layouts_Layouts", null, null), new LiteralStackNode(582, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(584, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[5] = new NonTerminalStackNode(574, 5, "layouts_Layouts", null, null);
      tmp[4] = new LiteralStackNode(572, 4, prod__lit_THEN__char_class___range__84_84_char_class___range__72_72_char_class___range__69_69_char_class___range__78_78_, new int[] {84,72,69,78}, null, null);
      tmp[3] = new NonTerminalStackNode(570, 3, "layouts_Layouts", null, null);
      tmp[2] = new NonTerminalStackNode(568, 2, "Expression", null, null);
      tmp[1] = new NonTerminalStackNode(566, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(564, 0, prod__lit_ELSIF__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__73_73_char_class___range__70_70_, new int[] {69,76,83,73,70}, null, null);
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
      
      tmp[0] = new CharStackNode(596, 0, new int[][]{{40,40}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{42,42}})});
      builder.addAlternative(Parser.prod__CommentChar__conditional__char_class___range__40_40__not_follow__char_class___range__42_42_, tmp);
	}
    protected static final void _init_prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(598, 0, new int[][]{{42,42}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{41,41}})});
      builder.addAlternative(Parser.prod__CommentChar__conditional__char_class___range__42_42__not_follow__char_class___range__41_41_, tmp);
	}
    protected static final void _init_prod__CommentChar__char_class___range__0_39_range__41_41_range__43_16777215_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(600, 0, new int[][]{{0,39},{41,41},{43,16777215}}, null, null);
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
      
      tmp[0] = new NonTerminalStackNode(602, 0, "Ident", null, null);
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
      
      tmp[4] = new OptionalStackNode(618, 4, regular__opt__VarSect, new NonTerminalStackNode(620, 0, "VarSect", null, null), null, null);
      tmp[3] = new NonTerminalStackNode(616, 3, "layouts_Layouts", null, null);
      tmp[2] = new OptionalStackNode(612, 2, regular__opt__TypeSect, new NonTerminalStackNode(614, 0, "TypeSect", null, null), null, null);
      tmp[1] = new NonTerminalStackNode(610, 1, "layouts_Layouts", null, null);
      tmp[0] = new OptionalStackNode(606, 0, regular__opt__ConstSect, new NonTerminalStackNode(608, 0, "ConstSect", null, null), null, null);
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
      
      tmp[8] = new CharStackNode(644, 8, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[7] = new CharStackNode(642, 7, new int[][]{{48,57}}, null, null);
      tmp[6] = new CharStackNode(640, 6, new int[][]{{48,57}}, null, null);
      tmp[5] = new CharStackNode(638, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(636, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(634, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(632, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(630, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(628, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[5];
      
      tmp[0] = new CharStackNode(646, 0, new int[][]{{49,57}}, null, null);
      tmp[1] = new CharStackNode(648, 1, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(650, 2, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(652, 3, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(654, 4, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[4];
      
      tmp[3] = new CharStackNode(662, 3, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[2] = new CharStackNode(660, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(658, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(656, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[3];
      
      tmp[2] = new CharStackNode(668, 2, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[1] = new CharStackNode(666, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(664, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[10];
      
      tmp[9] = new CharStackNode(688, 9, new int[][]{{48,55}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[8] = new CharStackNode(686, 8, new int[][]{{48,52}}, null, null);
      tmp[7] = new CharStackNode(684, 7, new int[][]{{48,54}}, null, null);
      tmp[6] = new CharStackNode(682, 6, new int[][]{{48,51}}, null, null);
      tmp[5] = new CharStackNode(680, 5, new int[][]{{48,56}}, null, null);
      tmp[4] = new CharStackNode(678, 4, new int[][]{{48,52}}, null, null);
      tmp[3] = new CharStackNode(676, 3, new int[][]{{48,55}}, null, null);
      tmp[2] = new CharStackNode(674, 2, new int[][]{{48,52}}, null, null);
      tmp[1] = new CharStackNode(672, 1, new int[][]{{48,49}}, null, null);
      tmp[0] = new CharStackNode(670, 0, new int[][]{{49,50}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_50_char_class___range__48_49_char_class___range__48_52_char_class___range__48_55_char_class___range__48_52_char_class___range__48_56_char_class___range__48_51_char_class___range__48_54_char_class___range__48_52_conditional__char_class___range__48_55__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[6];
      
      tmp[5] = new CharStackNode(700, 5, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[4] = new CharStackNode(698, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(696, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(694, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(692, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(690, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[7];
      
      tmp[6] = new CharStackNode(714, 6, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[5] = new CharStackNode(712, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(710, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(708, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(706, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(704, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(702, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[1];
      
      tmp[0] = new CharStackNode(716, 0, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      builder.addAlternative(Parser.prod__Natural__conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[8];
      
      tmp[7] = new CharStackNode(732, 7, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[6] = new CharStackNode(730, 6, new int[][]{{48,57}}, null, null);
      tmp[5] = new CharStackNode(728, 5, new int[][]{{48,57}}, null, null);
      tmp[4] = new CharStackNode(726, 4, new int[][]{{48,57}}, null, null);
      tmp[3] = new CharStackNode(724, 3, new int[][]{{48,57}}, null, null);
      tmp[2] = new CharStackNode(722, 2, new int[][]{{48,57}}, null, null);
      tmp[1] = new CharStackNode(720, 1, new int[][]{{48,57}}, null, null);
      tmp[0] = new CharStackNode(718, 0, new int[][]{{49,57}}, null, null);
      builder.addAlternative(Parser.prod__Natural__char_class___range__49_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_char_class___range__48_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_, tmp);
	}
    protected static final void _init_prod__Natural__char_class___range__49_57_conditional__char_class___range__48_57__not_follow__char_class___range__48_57_(ExpectBuilder builder) {
      AbstractStackNode[] tmp = new AbstractStackNode[2];
      
      tmp[1] = new CharStackNode(736, 1, new int[][]{{48,57}}, null, new ICompletionFilter[] {new CharFollowRestriction(new int[][]{{48,57}})});
      tmp[0] = new CharStackNode(734, 0, new int[][]{{49,57}}, null, null);
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
      
      tmp[2] = new SeparatedListStackNode(760, 2, regular__iter_seps__Statement__layouts_Layouts_lit___59_layouts_Layouts, new NonTerminalStackNode(762, 0, "Statement", null, null), new AbstractStackNode[]{new NonTerminalStackNode(764, 1, "layouts_Layouts", null, null), new LiteralStackNode(766, 2, prod__lit___59__char_class___range__59_59_, new int[] {59}, null, null), new NonTerminalStackNode(768, 3, "layouts_Layouts", null, null)}, true, null, null);
      tmp[1] = new NonTerminalStackNode(758, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(756, 0, prod__lit_ELSE__char_class___range__69_69_char_class___range__76_76_char_class___range__83_83_char_class___range__69_69_, new int[] {69,76,83,69}, null, null);
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
      
      tmp[2] = new SeparatedListStackNode(784, 2, regular__iter_star_seps__VarDecl__layouts_Layouts, new NonTerminalStackNode(786, 0, "VarDecl", null, null), new AbstractStackNode[]{new NonTerminalStackNode(788, 1, "layouts_Layouts", null, null)}, false, null, null);
      tmp[1] = new NonTerminalStackNode(782, 1, "layouts_Layouts", null, null);
      tmp[0] = new LiteralStackNode(780, 0, prod__lit_VAR__char_class___range__86_86_char_class___range__65_65_char_class___range__82_82_, new int[] {86,65,82}, null, null);
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
      
      tmp[0] = new EpsilonStackNode(804, 0);
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
      
      tmp[0] = new EpsilonStackNode(832, 0);
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