CC = gcc -Wall
YACC = bison -d
LEX = flex


tacl : tacl.tab.c lex.yy.c
	$(CC) $^ -o $@ -lfl

tacl.tab.c : tacl.y
	$(YACC) $^

lex.yy.c : tacl.lex
	$(LEX) $^


run : tacl
	@./tacl

run-1 : tacl
	@echo '[example.ast]'
	@./tacl < ../examples/example.ast

run-2 : tacl
	@echo '[factorial.ast]'
	@./tacl < ../examples/factorial.ast

run-3 : tacl
	@echo '[fibonacci-v2.ast]'
	@./tacl < ../examples/fibonacci-v2.ast

run-4 : tacl
	@echo '[fig-9.ast]'
	@./tacl < ../examples/fig-9.ast

clean :
	@$(RM) tacl
	@$(RM) tacl.tab.c tacl.tab.h
	@$(RM) lex.yy.c
