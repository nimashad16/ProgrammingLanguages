
PROG = simple
CFLAGS = -O3 -I. -fpermissive -std=c++11 -Wno-unused-result
SCANNER = scanner
GRAMMAR = grammar
FLEX = flex
BISON = bison
SRCS = driver.cc lex.yy.c $(PROG).cc icode.cc symtab.cc
BIN = $(PROG).exe
BINDEB = $(PROG)-debug.exe
CC = g++

all: grammar scanner bin debug

bin: $(SRCS)
	$(CC) $(CFLAGS) -o $(BIN) $(SRCS) 

debug: $(SRCS)
	$(CC) $(CFLAGS) -o $(BINDEB) $(SRCS) -D _SMP_DEBUG_

grader: $(SRCS) grammar scanner
	$(CC) $(CFLAGS) -o $(BIN) $(SRCS) -DPL_GRADER

scanner: $(SCANNER).yy
	$(FLEX) $(SCANNER).yy

grammar: $(GRAMMAR).y
	$(BISON) $(GRAMMAR).y -o $(PROG).cc

clean: 
	rm -f lex.yy.c $(PROG)* location.hh position.hh stack.hh
