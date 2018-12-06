CC = gcc -Wall
YACC = bison -d
LEX = flex


tacl : tacl.tab.c lex.yy.c ast.c ir.c
	$(CC) $^ -o $@ -lfl

tacl.tab.c : tacl.y
	$(YACC) $^

lex.yy.c : tacl.lex
	$(LEX) $^


run : tacl
	@./tacl

run-1 : tacl
	@echo '[twice.ast]'
	@./tacl < examples/twice.ast > examples/twice.ir

run-2 : tacl
	@echo '[triangular.ast]'
	@./tacl < examples/triangular.ast > examples/triangular.ir

run-3 : tacl
	@echo '[g.ast]'
	@./tacl < examples/g.ast > examples/g.ir

run-4 : tacl
	@echo '[factorial.ast]'
	@./tacl < examples/factorial.ast > examples/factorial.ir

run-5 : tacl
	@echo '[fig-9.ast]'
	@./tacl < examples/fig-9.ast > examples/fig-9.ir	

run-6 : tacl
	@echo '[fibonacci-v2.ast]'
	@./tacl < examples/fibonacci-v2.ast > examples/fibonacci-v2.ir

run-7 : tacl
	@echo '[procedure.ast]'
	@./tacl < examples/procedure.ast > procedure.ir

clean :
	@$(RM) tacl
	@$(RM) tacl.tab.c tacl.tab.h
	@$(RM) lex.yy.c
