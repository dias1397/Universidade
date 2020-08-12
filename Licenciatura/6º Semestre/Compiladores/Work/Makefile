CC = gcc
CFLAGS = -g
OUTFILE = out
LIBS =-lm


all: clean run-1 clean-pdf

compile: parser.c lexer.c yatypes.o latex.o
	$(CC) $(CFLAGS) parser.c lexer.c yatypes.o latex.o -o $(OUTFILE) $(LIBS)

latex.o: latex.h latex.c
	gcc $(CFLAGS) -c latex.c

yatypes.o: yatypes.h yatypes.c
	gcc $(CFLAGS) -c yatypes.c

run-1: compile
	./$(OUTFILE) < yaxamples/example1.ya

run-2: compile
	./$(OUTFILE) < yaxamples/example2.ya

run-6: compile
	./$(OUTFILE) < yaxamples/example6.ya

parser.c: ya.y
		bison -y -v -d $^ -o $@

lexer.c: ya.lex
		flex -o $@ $^

apt:
	pdflatex apt.tex

clean:
		rm -rf parser.c lexer.c parser.h parser.output latex.o yatypes.o
		rm -f out apt.pdf

clean-pdf: PDF
	rm -f *.aux
	rm -f *.log
	rm -f *.tex
	rm -f *.dvi
	rm -f *.ps


apt.dvi: apt.tex
		latex apt.tex

apt.ps: apt.dvi
		dvips -Ppdf -G0 apt.dvi

PDF: apt.ps
		ps2pdf apt.ps