YACC = bison++
YFLAGS = -d
%.cc %.h: %.y
	$(YACC) $(YFLAGS) -o $*.cc -h $*.h $<

LEX = flex++
LFLAGS = -8
%.cc %.h: %.l
	$(LEX) $(LFLAGS) -o$*.cc -h$*.h $<

# DMAN

dman: dmanParser.o dmanScanner.o
	$(CXX) -o $@ $^

dmanParser.o: dmanParser.cc dmanParser.h
dmanScanner.o: dmanScanner.cc dmanScanner.h dmanParser.h

dmanParser.cc dmanParser.h: dmanParser.y
dmanScanner.cc dmanScanner.h: dmanScanner.l
