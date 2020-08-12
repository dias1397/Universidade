# Makefile for the rpn calculator
# para correr fazer make

rpncalc: lex.yy.c
		gcc -o $@ $<

lex.yy.c: rpn.flex
		flex $<

clean:
		rm -f lex.yy.c

clean_all clean-all: clean
		rm -f rpncalc