module languages::oberon0::format::Oberon0

import box::Box;
import List;
import languages::oberon0::ast::Oberon0;

public Module sampleAST =
mod(id("Sample"),decls([],[],[],[proc(id("Multiply")[@location=|project://oberon0/src/sample.oberon0|(38,8,<6,10>,<6,18>)],[],decls([],[],[varDecl([id("x")[@location=|project://oberon0/src/sample.oberon0|(55,1,<7,6>,<7,7>)],id("y")[@location=|project://oberon0/src/sample.oberon0|(58,1,<7,9>,<7,10>)],id("z")[@location=|project://oberon0/src/sample.oberon0|(61,1,<7,12>,<7,13>)]],user(id("INTEGER")[@location=|project://oberon0/src/sample.oberon0|(64,7,<7,15>,<7,22>)])[@location=|project://oberon0/src/sample.oberon0|(64,7,<7,15>,<7,22>)])[@location=|project://oberon0/src/sample.oberon0|(55,17,<7,6>,<7,23>)]],[])[@location=|project://oberon0/src/sample.oberon0|(51,22,<7,2>,<8,0>)],[call(id("Read")[@location=|project://oberon0/src/sample.oberon0|(82,4,<9,2>,<9,6>)],[lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(87,1,<9,7>,<9,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(87,1,<9,7>,<9,8>)]])[@location=|project://oberon0/src/sample.oberon0|(82,7,<9,2>,<9,9>)],call(id("Read")[@location=|project://oberon0/src/sample.oberon0|(94,4,<10,2>,<10,6>)],[lookup(id("y")[@location=|project://oberon0/src/sample.oberon0|(99,1,<10,7>,<10,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(99,1,<10,7>,<10,8>)]])[@location=|project://oberon0/src/sample.oberon0|(94,7,<10,2>,<10,9>)],assign(id("z")[@location=|project://oberon0/src/sample.oberon0|(106,1,<11,2>,<11,3>)],[],nat(0)[@location=|project://oberon0/src/sample.oberon0|(111,1,<11,7>,<11,8>)])[@location=|project://oberon0/src/sample.oberon0|(106,6,<11,2>,<11,8>)],whileDo(gt(lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(123,1,<12,8>,<12,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(123,2,<12,8>,<12,10>)],nat(0)[@location=|project://oberon0/src/sample.oberon0|(127,1,<12,12>,<12,13>)])[@location=|project://oberon0/src/sample.oberon0|(123,5,<12,8>,<12,13>)],[ifThen(eq(mod(lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(139,1,<13,7>,<13,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(139,2,<13,7>,<13,9>)],nat(2)[@location=|project://oberon0/src/sample.oberon0|(145,1,<13,13>,<13,14>)])[@location=|project://oberon0/src/sample.oberon0|(139,7,<13,7>,<13,14>)],nat(1)[@location=|project://oberon0/src/sample.oberon0|(149,1,<13,17>,<13,18>)])[@location=|project://oberon0/src/sample.oberon0|(139,11,<13,7>,<13,18>)],[assign(id("z")[@location=|project://oberon0/src/sample.oberon0|(163,1,<14,6>,<14,7>)],[],add(lookup(id("z")[@location=|project://oberon0/src/sample.oberon0|(168,1,<14,11>,<14,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(168,2,<14,11>,<14,13>)],lookup(id("y")[@location=|project://oberon0/src/sample.oberon0|(172,1,<14,15>,<14,16>)],[])[@location=|project://oberon0/src/sample.oberon0|(172,7,<14,15>,<15,4>)])[@location=|project://oberon0/src/sample.oberon0|(168,11,<14,11>,<15,4>)])[@location=|project://oberon0/src/sample.oberon0|(163,16,<14,6>,<15,4>)]],[],[])[@location=|project://oberon0/src/sample.oberon0|(136,46,<13,4>,<15,7>)],assign(id("y")[@location=|project://oberon0/src/sample.oberon0|(189,1,<16,4>,<16,5>)],[],mul(nat(2)[@location=|project://oberon0/src/sample.oberon0|(194,1,<16,9>,<16,10>)],lookup(id("y")[@location=|project://oberon0/src/sample.oberon0|(196,1,<16,11>,<16,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(196,1,<16,11>,<16,12>)])[@location=|project://oberon0/src/sample.oberon0|(194,3,<16,9>,<16,12>)])[@location=|project://oberon0/src/sample.oberon0|(189,8,<16,4>,<16,12>)],assign(id("x")[@location=|project://oberon0/src/sample.oberon0|(204,1,<17,4>,<17,5>)],[],div(lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(209,1,<17,9>,<17,10>)],[])[@location=|project://oberon0/src/sample.oberon0|(209,2,<17,9>,<17,11>)],nat(2)[@location=|project://oberon0/src/sample.oberon0|(215,1,<17,15>,<17,16>)])[@location=|project://oberon0/src/sample.oberon0|(209,7,<17,9>,<17,16>)])[@location=|project://oberon0/src/sample.oberon0|(204,12,<17,4>,<17,16>)]])[@location=|project://oberon0/src/sample.oberon0|(117,103,<12,2>,<17,20>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(225,5,<18,3>,<18,8>)],[lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(231,1,<18,9>,<18,10>)],[])[@location=|project://oberon0/src/sample.oberon0|(231,1,<18,9>,<18,10>)]])[@location=|project://oberon0/src/sample.oberon0|(225,8,<18,3>,<18,11>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(239,5,<19,3>,<19,8>)],[lookup(id("y")[@location=|project://oberon0/src/sample.oberon0|(245,1,<19,9>,<19,10>)],[])[@location=|project://oberon0/src/sample.oberon0|(245,1,<19,9>,<19,10>)]])[@location=|project://oberon0/src/sample.oberon0|(239,8,<19,3>,<19,11>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(253,5,<20,3>,<20,8>)],[lookup(id("z")[@location=|project://oberon0/src/sample.oberon0|(259,1,<20,9>,<20,10>)],[])[@location=|project://oberon0/src/sample.oberon0|(259,1,<20,9>,<20,10>)]])[@location=|project://oberon0/src/sample.oberon0|(253,8,<20,3>,<20,11>)],call(id("WriteLn")[@location=|project://oberon0/src/sample.oberon0|(267,7,<21,3>,<21,10>)],[])[@location=|project://oberon0/src/sample.oberon0|(267,9,<21,3>,<22,0>)]],id("Multiply")[@location=|project://oberon0/src/sample.oberon0|(280,8,<22,4>,<22,12>)])[@location=|project://oberon0/src/sample.oberon0|(28,261,<6,0>,<22,13>)],proc(id("Divide")[@location=|project://oberon0/src/sample.oberon0|(302,6,<25,10>,<25,16>)],[],decls([],[],[varDecl([id("x")[@location=|project://oberon0/src/sample.oberon0|(317,1,<26,6>,<26,7>)],id("y")[@location=|project://oberon0/src/sample.oberon0|(320,1,<26,9>,<26,10>)],id("r")[@location=|project://oberon0/src/sample.oberon0|(323,1,<26,12>,<26,13>)],id("q")[@location=|project://oberon0/src/sample.oberon0|(326,1,<26,15>,<26,16>)],id("w")[@location=|project://oberon0/src/sample.oberon0|(329,1,<26,18>,<26,19>)]],user(id("INTEGER")[@location=|project://oberon0/src/sample.oberon0|(332,7,<26,21>,<26,28>)])[@location=|project://oberon0/src/sample.oberon0|(332,7,<26,21>,<26,28>)])[@location=|project://oberon0/src/sample.oberon0|(317,23,<26,6>,<26,29>)]],[])[@location=|project://oberon0/src/sample.oberon0|(313,28,<26,2>,<27,0>)],[call(id("Read")[@location=|project://oberon0/src/sample.oberon0|(350,4,<28,2>,<28,6>)],[lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(355,1,<28,7>,<28,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(355,1,<28,7>,<28,8>)]])[@location=|project://oberon0/src/sample.oberon0|(350,7,<28,2>,<28,9>)],call(id("Read")[@location=|project://oberon0/src/sample.oberon0|(362,4,<29,2>,<29,6>)],[lookup(id("y")[@location=|project://oberon0/src/sample.oberon0|(367,1,<29,7>,<29,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(367,1,<29,7>,<29,8>)]])[@location=|project://oberon0/src/sample.oberon0|(362,7,<29,2>,<29,9>)],assign(id("r")[@location=|project://oberon0/src/sample.oberon0|(374,1,<30,2>,<30,3>)],[],lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(379,1,<30,7>,<30,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(379,1,<30,7>,<30,8>)])[@location=|project://oberon0/src/sample.oberon0|(374,6,<30,2>,<30,8>)],assign(id("q")[@location=|project://oberon0/src/sample.oberon0|(385,1,<31,2>,<31,3>)],[],nat(0)[@location=|project://oberon0/src/sample.oberon0|(390,1,<31,7>,<31,8>)])[@location=|project://oberon0/src/sample.oberon0|(385,6,<31,2>,<31,8>)],assign(id("w")[@location=|project://oberon0/src/sample.oberon0|(396,1,<32,2>,<32,3>)],[],lookup(id("y")[@location=|project://oberon0/src/sample.oberon0|(401,1,<32,7>,<32,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(401,1,<32,7>,<32,8>)])[@location=|project://oberon0/src/sample.oberon0|(396,6,<32,2>,<32,8>)],whileDo(leq(lookup(id("w")[@location=|project://oberon0/src/sample.oberon0|(413,1,<33,8>,<33,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(413,2,<33,8>,<33,10>)],lookup(id("r")[@location=|project://oberon0/src/sample.oberon0|(418,1,<33,13>,<33,14>)],[])[@location=|project://oberon0/src/sample.oberon0|(418,2,<33,13>,<33,15>)])[@location=|project://oberon0/src/sample.oberon0|(413,7,<33,8>,<33,15>)],[assign(id("w")[@location=|project://oberon0/src/sample.oberon0|(428,1,<34,4>,<34,5>)],[],mul(nat(2)[@location=|project://oberon0/src/sample.oberon0|(433,1,<34,9>,<34,10>)],lookup(id("w")[@location=|project://oberon0/src/sample.oberon0|(435,1,<34,11>,<34,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(435,5,<34,11>,<35,2>)])[@location=|project://oberon0/src/sample.oberon0|(433,7,<34,9>,<35,2>)])[@location=|project://oberon0/src/sample.oberon0|(428,12,<34,4>,<35,2>)]])[@location=|project://oberon0/src/sample.oberon0|(407,36,<33,2>,<35,5>)],whileDo(gt(lookup(id("w")[@location=|project://oberon0/src/sample.oberon0|(454,1,<36,8>,<36,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(454,2,<36,8>,<36,10>)],lookup(id("y")[@location=|project://oberon0/src/sample.oberon0|(458,1,<36,12>,<36,13>)],[])[@location=|project://oberon0/src/sample.oberon0|(458,2,<36,12>,<36,14>)])[@location=|project://oberon0/src/sample.oberon0|(454,6,<36,8>,<36,14>)],[assign(id("q")[@location=|project://oberon0/src/sample.oberon0|(467,1,<37,4>,<37,5>)],[],mul(nat(2)[@location=|project://oberon0/src/sample.oberon0|(472,1,<37,9>,<37,10>)],lookup(id("q")[@location=|project://oberon0/src/sample.oberon0|(474,1,<37,11>,<37,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(474,1,<37,11>,<37,12>)])[@location=|project://oberon0/src/sample.oberon0|(472,3,<37,9>,<37,12>)])[@location=|project://oberon0/src/sample.oberon0|(467,8,<37,4>,<37,12>)],assign(id("w")[@location=|project://oberon0/src/sample.oberon0|(482,1,<38,4>,<38,5>)],[],div(lookup(id("w")[@location=|project://oberon0/src/sample.oberon0|(487,1,<38,9>,<38,10>)],[])[@location=|project://oberon0/src/sample.oberon0|(487,2,<38,9>,<38,11>)],nat(2)[@location=|project://oberon0/src/sample.oberon0|(493,1,<38,15>,<38,16>)])[@location=|project://oberon0/src/sample.oberon0|(487,7,<38,9>,<38,16>)])[@location=|project://oberon0/src/sample.oberon0|(482,12,<38,4>,<38,16>)],ifThen(leq(lookup(id("w")[@location=|project://oberon0/src/sample.oberon0|(503,1,<39,7>,<39,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(503,2,<39,7>,<39,9>)],lookup(id("r")[@location=|project://oberon0/src/sample.oberon0|(508,1,<39,12>,<39,13>)],[])[@location=|project://oberon0/src/sample.oberon0|(508,2,<39,12>,<39,14>)])[@location=|project://oberon0/src/sample.oberon0|(503,7,<39,7>,<39,14>)],[assign(id("r")[@location=|project://oberon0/src/sample.oberon0|(522,1,<40,6>,<40,7>)],[],sub(lookup(id("r")[@location=|project://oberon0/src/sample.oberon0|(527,1,<40,11>,<40,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(527,2,<40,11>,<40,13>)],lookup(id("w")[@location=|project://oberon0/src/sample.oberon0|(531,1,<40,15>,<40,16>)],[])[@location=|project://oberon0/src/sample.oberon0|(531,1,<40,15>,<40,16>)])[@location=|project://oberon0/src/sample.oberon0|(527,5,<40,11>,<40,16>)])[@location=|project://oberon0/src/sample.oberon0|(522,10,<40,6>,<40,16>)],assign(id("q")[@location=|project://oberon0/src/sample.oberon0|(541,1,<41,6>,<41,7>)],[],add(lookup(id("q")[@location=|project://oberon0/src/sample.oberon0|(546,1,<41,11>,<41,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(546,2,<41,11>,<41,13>)],nat(1)[@location=|project://oberon0/src/sample.oberon0|(550,1,<41,15>,<41,16>)])[@location=|project://oberon0/src/sample.oberon0|(546,5,<41,11>,<41,16>)])[@location=|project://oberon0/src/sample.oberon0|(541,10,<41,6>,<41,16>)]],[],[])[@location=|project://oberon0/src/sample.oberon0|(500,60,<39,4>,<42,7>)]])[@location=|project://oberon0/src/sample.oberon0|(448,119,<36,2>,<43,5>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(571,5,<44,2>,<44,7>)],[lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(577,1,<44,8>,<44,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(577,1,<44,8>,<44,9>)]])[@location=|project://oberon0/src/sample.oberon0|(571,8,<44,2>,<44,10>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(584,5,<45,2>,<45,7>)],[lookup(id("y")[@location=|project://oberon0/src/sample.oberon0|(590,1,<45,8>,<45,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(590,1,<45,8>,<45,9>)]])[@location=|project://oberon0/src/sample.oberon0|(584,8,<45,2>,<45,10>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(596,5,<46,2>,<46,7>)],[lookup(id("q")[@location=|project://oberon0/src/sample.oberon0|(602,1,<46,8>,<46,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(602,1,<46,8>,<46,9>)]])[@location=|project://oberon0/src/sample.oberon0|(596,8,<46,2>,<46,10>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(608,5,<47,2>,<47,7>)],[lookup(id("r")[@location=|project://oberon0/src/sample.oberon0|(614,1,<47,8>,<47,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(614,1,<47,8>,<47,9>)]])[@location=|project://oberon0/src/sample.oberon0|(608,8,<47,2>,<47,10>)],call(id("WriteLn")[@location=|project://oberon0/src/sample.oberon0|(620,7,<48,2>,<48,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(620,8,<48,2>,<49,0>)]],id("Divide")[@location=|project://oberon0/src/sample.oberon0|(632,6,<49,4>,<49,10>)])[@location=|project://oberon0/src/sample.oberon0|(292,347,<25,0>,<49,11>)],proc(id("BinSearch")[@location=|project://oberon0/src/sample.oberon0|(651,9,<51,10>,<51,19>)],[],decls([],[],[varDecl([id("i")[@location=|project://oberon0/src/sample.oberon0|(673,1,<53,4>,<53,5>)],id("j")[@location=|project://oberon0/src/sample.oberon0|(676,1,<53,7>,<53,8>)],id("k")[@location=|project://oberon0/src/sample.oberon0|(679,1,<53,10>,<53,11>)],id("n")[@location=|project://oberon0/src/sample.oberon0|(682,1,<53,13>,<53,14>)],id("x")[@location=|project://oberon0/src/sample.oberon0|(685,1,<53,16>,<53,17>)]],user(id("INTEGER")[@location=|project://oberon0/src/sample.oberon0|(688,7,<53,19>,<53,26>)])[@location=|project://oberon0/src/sample.oberon0|(688,7,<53,19>,<53,26>)])[@location=|project://oberon0/src/sample.oberon0|(673,23,<53,4>,<53,27>)],varDecl([id("a")[@location=|project://oberon0/src/sample.oberon0|(701,1,<54,4>,<54,5>)]],array(nat(32)[@location=|project://oberon0/src/sample.oberon0|(710,2,<54,13>,<54,15>)],user(id("INTEGER")[@location=|project://oberon0/src/sample.oberon0|(716,7,<54,19>,<54,26>)])[@location=|project://oberon0/src/sample.oberon0|(716,7,<54,19>,<54,26>)])[@location=|project://oberon0/src/sample.oberon0|(704,19,<54,7>,<54,26>)])[@location=|project://oberon0/src/sample.oberon0|(701,23,<54,4>,<54,27>)]],[])[@location=|project://oberon0/src/sample.oberon0|(664,62,<52,2>,<55,0>)],[call(id("Read")[@location=|project://oberon0/src/sample.oberon0|(735,4,<56,2>,<56,6>)],[lookup(id("n")[@location=|project://oberon0/src/sample.oberon0|(740,1,<56,7>,<56,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(740,1,<56,7>,<56,8>)]])[@location=|project://oberon0/src/sample.oberon0|(735,7,<56,2>,<56,9>)],assign(id("k")[@location=|project://oberon0/src/sample.oberon0|(744,1,<56,11>,<56,12>)],[],nat(0)[@location=|project://oberon0/src/sample.oberon0|(749,1,<56,16>,<56,17>)])[@location=|project://oberon0/src/sample.oberon0|(744,6,<56,11>,<56,17>)],whileDo(lt(lookup(id("k")[@location=|project://oberon0/src/sample.oberon0|(760,1,<57,8>,<57,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(760,2,<57,8>,<57,10>)],lookup(id("n")[@location=|project://oberon0/src/sample.oberon0|(764,1,<57,12>,<57,13>)],[])[@location=|project://oberon0/src/sample.oberon0|(764,2,<57,12>,<57,14>)])[@location=|project://oberon0/src/sample.oberon0|(760,6,<57,8>,<57,14>)],[call(id("Read")[@location=|project://oberon0/src/sample.oberon0|(773,4,<58,4>,<58,8>)],[lookup(id("a")[@location=|project://oberon0/src/sample.oberon0|(778,1,<58,9>,<58,10>)],[subscript(lookup(id("k")[@location=|project://oberon0/src/sample.oberon0|(780,1,<58,11>,<58,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(780,1,<58,11>,<58,12>)])[@location=|project://oberon0/src/sample.oberon0|(779,3,<58,10>,<58,13>)]])[@location=|project://oberon0/src/sample.oberon0|(778,4,<58,9>,<58,13>)]])[@location=|project://oberon0/src/sample.oberon0|(773,10,<58,4>,<58,14>)],assign(id("k")[@location=|project://oberon0/src/sample.oberon0|(790,1,<59,4>,<59,5>)],[],add(lookup(id("k")[@location=|project://oberon0/src/sample.oberon0|(795,1,<59,9>,<59,10>)],[])[@location=|project://oberon0/src/sample.oberon0|(795,2,<59,9>,<59,11>)],nat(1)[@location=|project://oberon0/src/sample.oberon0|(799,1,<59,13>,<59,14>)])[@location=|project://oberon0/src/sample.oberon0|(795,5,<59,9>,<59,14>)])[@location=|project://oberon0/src/sample.oberon0|(790,10,<59,4>,<59,14>)]])[@location=|project://oberon0/src/sample.oberon0|(754,53,<57,2>,<60,5>)],call(id("Read")[@location=|project://oberon0/src/sample.oberon0|(812,4,<61,2>,<61,6>)],[lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(817,1,<61,7>,<61,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(817,1,<61,7>,<61,8>)]])[@location=|project://oberon0/src/sample.oberon0|(812,7,<61,2>,<61,9>)],assign(id("i")[@location=|project://oberon0/src/sample.oberon0|(824,1,<62,2>,<62,3>)],[],nat(0)[@location=|project://oberon0/src/sample.oberon0|(829,1,<62,7>,<62,8>)])[@location=|project://oberon0/src/sample.oberon0|(824,6,<62,2>,<62,8>)],assign(id("j")[@location=|project://oberon0/src/sample.oberon0|(835,1,<63,2>,<63,3>)],[],lookup(id("n")[@location=|project://oberon0/src/sample.oberon0|(840,1,<63,7>,<63,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(840,1,<63,7>,<63,8>)])[@location=|project://oberon0/src/sample.oberon0|(835,6,<63,2>,<63,8>)],whileDo(lt(lookup(id("i")[@location=|project://oberon0/src/sample.oberon0|(852,1,<64,8>,<64,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(852,2,<64,8>,<64,10>)],lookup(id("j")[@location=|project://oberon0/src/sample.oberon0|(856,1,<64,12>,<64,13>)],[])[@location=|project://oberon0/src/sample.oberon0|(856,2,<64,12>,<64,14>)])[@location=|project://oberon0/src/sample.oberon0|(852,6,<64,8>,<64,14>)],[assign(id("k")[@location=|project://oberon0/src/sample.oberon0|(865,1,<65,4>,<65,5>)],[],div(add(lookup(id("i")[@location=|project://oberon0/src/sample.oberon0|(871,1,<65,10>,<65,11>)],[])[@location=|project://oberon0/src/sample.oberon0|(871,1,<65,10>,<65,11>)],lookup(id("j")[@location=|project://oberon0/src/sample.oberon0|(873,1,<65,12>,<65,13>)],[])[@location=|project://oberon0/src/sample.oberon0|(873,1,<65,12>,<65,13>)])[@location=|project://oberon0/src/sample.oberon0|(871,3,<65,10>,<65,13>)],nat(2)[@location=|project://oberon0/src/sample.oberon0|(880,1,<65,19>,<65,20>)])[@location=|project://oberon0/src/sample.oberon0|(870,11,<65,9>,<65,20>)])[@location=|project://oberon0/src/sample.oberon0|(865,16,<65,4>,<65,20>)],ifThen(lt(lookup(id("x")[@location=|project://oberon0/src/sample.oberon0|(890,1,<66,7>,<66,8>)],[])[@location=|project://oberon0/src/sample.oberon0|(890,2,<66,7>,<66,9>)],lookup(id("a")[@location=|project://oberon0/src/sample.oberon0|(894,1,<66,11>,<66,12>)],[subscript(lookup(id("k")[@location=|project://oberon0/src/sample.oberon0|(896,1,<66,13>,<66,14>)],[])[@location=|project://oberon0/src/sample.oberon0|(896,1,<66,13>,<66,14>)])[@location=|project://oberon0/src/sample.oberon0|(895,3,<66,12>,<66,15>)]])[@location=|project://oberon0/src/sample.oberon0|(894,4,<66,11>,<66,15>)])[@location=|project://oberon0/src/sample.oberon0|(890,8,<66,7>,<66,15>)],[assign(id("j")[@location=|project://oberon0/src/sample.oberon0|(911,1,<67,6>,<67,7>)],[],lookup(id("k")[@location=|project://oberon0/src/sample.oberon0|(916,1,<67,11>,<67,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(916,6,<67,11>,<68,4>)])[@location=|project://oberon0/src/sample.oberon0|(911,11,<67,6>,<68,4>)]],[],[assign(id("i")[@location=|project://oberon0/src/sample.oberon0|(934,1,<69,6>,<69,7>)],[],add(lookup(id("k")[@location=|project://oberon0/src/sample.oberon0|(939,1,<69,11>,<69,12>)],[])[@location=|project://oberon0/src/sample.oberon0|(939,1,<69,11>,<69,12>)],nat(1)[@location=|project://oberon0/src/sample.oberon0|(941,1,<69,13>,<69,14>)])[@location=|project://oberon0/src/sample.oberon0|(939,3,<69,11>,<69,14>)])[@location=|project://oberon0/src/sample.oberon0|(934,8,<69,6>,<69,14>)]])[@location=|project://oberon0/src/sample.oberon0|(887,64,<66,4>,<70,7>)]])[@location=|project://oberon0/src/sample.oberon0|(846,112,<64,2>,<71,5>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(962,5,<72,2>,<72,7>)],[lookup(id("i")[@location=|project://oberon0/src/sample.oberon0|(968,1,<72,8>,<72,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(968,1,<72,8>,<72,9>)]])[@location=|project://oberon0/src/sample.oberon0|(962,8,<72,2>,<72,10>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(975,5,<73,2>,<73,7>)],[lookup(id("j")[@location=|project://oberon0/src/sample.oberon0|(981,1,<73,8>,<73,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(981,1,<73,8>,<73,9>)]])[@location=|project://oberon0/src/sample.oberon0|(975,8,<73,2>,<73,10>)],call(id("Write")[@location=|project://oberon0/src/sample.oberon0|(988,5,<74,2>,<74,7>)],[lookup(id("a")[@location=|project://oberon0/src/sample.oberon0|(994,1,<74,8>,<74,9>)],[subscript(lookup(id("j")[@location=|project://oberon0/src/sample.oberon0|(996,1,<74,10>,<74,11>)],[])[@location=|project://oberon0/src/sample.oberon0|(996,1,<74,10>,<74,11>)])[@location=|project://oberon0/src/sample.oberon0|(995,3,<74,9>,<74,12>)]])[@location=|project://oberon0/src/sample.oberon0|(994,4,<74,8>,<74,12>)]])[@location=|project://oberon0/src/sample.oberon0|(988,11,<74,2>,<74,13>)],call(id("WriteLn")[@location=|project://oberon0/src/sample.oberon0|(1004,7,<75,2>,<75,9>)],[])[@location=|project://oberon0/src/sample.oberon0|(1004,9,<75,2>,<76,0>)]],id("BinSearch")[@location=|project://oberon0/src/sample.oberon0|(1017,9,<76,4>,<76,13>)])[@location=|project://oberon0/src/sample.oberon0|(641,386,<51,0>,<76,14>)]]),[],id("Sample"));


public Box id2box(Ident id) {
  return VAR(L(id.name));
}

public Box sel2box(Selector sel) {
  switch (sel) {
    case field(Ident field): return H([L("."),id2box(field)])[@hs=0];
    case subscript(Expression exp): return H([L("["),exp2box(exp), L("]")])[@hs=0];
  }
}

public Box exp2box(Expression exp) {
  switch (exp) {
    case nat(int val): return L("<val>");
    case lookup(Ident var, list[Selector] selectors): return var2box(var, selectors);
    case neg(Expression arg): return H([L("-"), exp2box(arg)])[@hs=0];
    case pos(Expression arg): return H([L("+"), exp2box(arg)])[@hs=0];
    case not(Expression arg): return H([L("~"), exp2box()])[@hs=0];
    case mul(Expression lhs, Expression rhs): return H([exp2box(lhs), L("*"), exp2box(rhs)])[@hs=1];
    case div(Expression lhs, Expression rhs): return H([exp2box(lhs), L("DIV"), exp2box(rhs)])[@hs=1];
    case mod(Expression lhs, Expression rhs): return H([exp2box(lhs), L("MOD"), exp2box(rhs)])[@hs=1];
    case amp(Expression lhs, Expression rhs): return H([exp2box(lhs), L("&"), exp2box(rhs)])[@hs=1];
    case add(Expression lhs, Expression rhs): return H([exp2box(lhs), L("+"), exp2box(rhs)])[@hs=1];
    case sub(Expression lhs, Expression rhs): return H([exp2box(lhs), L("-"), exp2box(rhs)])[@hs=1];
    case or(Expression lhs, Expression rhs): return H([exp2box(lhs), L("OR"), exp2box(rhs)])[@hs=1];
    case eq(Expression lhs, Expression rhs): return H([exp2box(lhs), L("="), exp2box(rhs)])[@hs=1];
    case neq(Expression lhs, Expression rhs): return H([exp2box(lhs), L("#"), exp2box(rhs)])[@hs=1];
    case lt(Expression lhs, Expression rhs): return H([exp2box(lhs), L("\<"), exp2box(rhs)])[@hs=1];
    case gt(Expression lhs, Expression rhs): return H([exp2box(lhs), L("\>"), exp2box(rhs)])[@hs=1];
    case leq(Expression lhs, Expression rhs): return H([exp2box(lhs), L("\<="), exp2box(rhs)])[@hs=1];
    case geq(Expression lhs, Expression rhs): return H([exp2box(lhs), L("\>="), exp2box(rhs)])[@hs=1];
  }
}

public Box var2box(Ident var, list[Selector] selectors) {
  return H([id2box(var)] + [ sel2box(s) | s <- selectors ])[@hs=0];
}

public Box stat2box(Statement stat) {
  switch (stat) {
    case assign(Ident var, list[Selector] selectors, Expression exp): 
            return H([var2box(var, selectors), L(":="), exp2box(exp)])[@hs=1];
    case call(Ident proc, list[Expression] args):
            return H([id2box(proc), L("("),  H(hsepList(args, ",", exp2box))[@hs=1],  L(")")])[@hs=0];
    case ifThen(Expression condition, list[Statement] body, 
             list[tuple[Expression condition, list[Statement] body]] elseIfs,
             list[Statement] elsePart): {
        ift = V([
            H([L("IF"), exp2box(condition), L("THEN")])[@hs=1],
              I([V(hsepList(body, ";", stat2box))])]);
        elifs = for (<cond, ebody> <- elseIfs) {
          append V([
            H([L("ELSIF"), exp2box(cond), L("THEN")])[@hs=1],
            I(hsepList(ebody, ";", stat2box))
          ]);
        }
        els = V([
            L("ELSE"),
            I(hsepList(elsePart, ";", stat2box))
        ]);
        return V([ift] + elifs + [els] + [KW(L("END"))]);
    }
    case whileDo(Expression condition, list[Statement] body): 
       return V([
            H([L("WHILE"), exp2box(condition), L("DO")])[@hs=1],
             I([V(hsepList(body, ";", stat2box))]),
            KW(L("END"))
        ]);   

  }
}

public Box type2box(Type typ) {
   switch (typ) {
     case user(Ident name): return id2box(name);
     case array(Expression exp, Type t): return H([KW(L("ARRAY")), exp2box(exp), KW(L("OF")), type2box(t)])[@hs=1];
     case record(list[Field] fields): {
           if (fields == []) 
              return H([KW(L("RECORD")), KW(L("END"))])[@hs=1];
           return V([
             KW(L("RECORD")),
             I(hsepList(fields, ";", field2box)),
             KW(L("END"))
           ]);
     }
  }
}


public list[Box] hsepList(list[&T] elts, str sep, Box(&T) tobox) {
  if (elts == []) 
     return [];
  result = [];
  Box lst = tobox(head(elts));
  for (e <- tail(elts)) {
   result += [H([lst, L(sep)])[@hs=0]];
   lst = tobox(e);
  }
  return result + [lst];
}


public Box field2box(Field field) {
   return H([H([H(hsepList(field.names, ",", id2box))[@hs=1], L(":")])[@hs=0], type2box(field.\type)])[@hs=1];
}


public Box formal2box(Formal form) {
  result = H([])[@hs=1];
  if (form.hasVar) {
    result.h += [KW(L("VAR"))];
  }
  result.h += [H([H(hsepList(form.names, ",", id2box))[@hs=1], L(":")])[@hs=0]];
  result.h += [type2box(form.\type)];
  return result;
}


public Box proc2box(Procedure pr) {
  return V([
    H([KW(L("PROCEDURE")), H([id2box(pr.name), hsepList(pr.formals, ";", formal2box), L(";")])[@hs=0]])[@hs=1],
    I([
      decls2box(pr.decls)
    ]),
    KW(L("BEGIN")),
    I([
      V(hsepList(pr.body, ";", stat2box))[@vs=0]
    ]),
    H([H([KW(L("END")), id2box(pr.endName)])[@hs=1], L(";")])[@hs=0]
  ])[@vs=1];
}

public Box decls2box(Declarations ds) {
   Box v = V([]);
   if (ds.consts != []) {
     v.v += [KW(L("CONST")), I([A([constDecl2box(x) | x <- ds.consts])])];
   }
   if (ds.types != []) {
     v.v += [KW(L("TYPE")), I([A([typeDecl2box(x) | x <- ds.types])])];
   }
   if (ds.vars != []) {     
     v.v += [KW(L("VAR")), I([A([varDecl2box(x) | x <- ds.vars])])];
   }
   v.v += [proc2box(x) | x <- ds.procs];
   return v[@vs=1];
}


public Box constDecl2box(ConstDecl cd) {
  return R([L(cd.name), L("="), H([exp2box(cd.\value), L(";")])[@hs=0]]);
}

public Box typeDecl2box(TypeDecl td) {
  return R([L(td.name.name), L(":"), H([type2box(td.\type), L(";")])[@hs=0] ]);
}

public Box varDecl2box(VarDecl vd) {
  return R([H(hsepList(vd.names, ",", id2box))[@hs=1], L(":"), H([type2box(vd.\type), L(";")])[@hs=0]]);
}

public Box mod2box(Module m) {
  return V([
    H([KW(L("MODULE")), H([id2box(m.name), L(";")])[@hs=0]])[@hs=1],
    decls2box(m.decls),
    I([
      V(hsepList(m.body, ";", stat2box))[@vs=0]
    ]),
    H([H([KW(L("END")), id2box(m.endName)])[@hs=1], L(".")])[@hs=0]
  ])[@vs=1];
}

