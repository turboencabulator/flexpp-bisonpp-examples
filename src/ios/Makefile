YACC = bison++
YFLAGS = -d
%.cc %.h: %.y
	$(YACC) $(YFLAGS) -o $*.cc -h $*.h $<

LEX = flex++
LFLAGS = -8
%.cc %.h: %.l
	$(LEX) $(LFLAGS) -o$*.cc -h$*.h $<

# COMPILER ON IOSTREAM SAMPLE

ios: MyCompilerIOS.o MyParserIOS.o MyScannerIOS.o
	$(CXX) -o $@ $^

MyCompilerIOS.o: MyCompilerIOS.cc MyParserIOS.h MyScannerIOS.h
MyParserIOS.o: MyParserIOS.cc MyParserIOS.h
MyScannerIOS.o: MyScannerIOS.cc MyScannerIOS.h MyParserIOS.h

MyParserIOS.cc MyParserIOS.h: MyParserIOS.y
MyScannerIOS.cc MyScannerIOS.h: MyScannerIOS.l
