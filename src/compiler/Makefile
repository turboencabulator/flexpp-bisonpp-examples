YACC = bison++
YFLAGS = -d
%.cc %.h: %.y
	$(YACC) $(YFLAGS) -o $*.cc -h $*.h $<

LEX = flex++
LFLAGS = -8
%.cc %.h: %.l
	$(LEX) $(LFLAGS) -o$*.cc -h$*.h $<

# COMPILER SAMPLE

compiler: MyCompiler.o MyParser.o MyScanner.o
	$(CXX) -o $@ $^

MyCompiler.o: MyCompiler.cc MyParser.h MyScanner.h
MyParser.o: MyParser.cc MyParser.h
MyScanner.o: MyScanner.cc MyScanner.h MyParser.h

MyParser.cc MyParser.h: MyParser.y
MyScanner.cc MyScanner.h: MyScanner.l
