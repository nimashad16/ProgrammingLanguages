
SRCS = driver.cc lex.yy.c
BIN = pl-scanner.exe
CFLAGS = -O3 -I.
SCANNER = pl-scanner
#SCANNER = example-flex
FLEX = flex
CC = g++

all: scanner bin

bin: $(SRCS)
	$(CC) $(CFLAGS) -o $(BIN) $(SRCS) 

scanner: $(SCANNER).yy
	$(FLEX) $(SCANNER).yy

clean: 
	rm *.exe lex.yy.c *.o
