CC = gcc -Wall
YACC = bison -d
LEX = flex


ir : ir.tab.c lex.yy.c tree.c mips.c
	$(CC) $^ -o $@ -lfl

ir.tab.c : ir.y
	$(YACC) $^

lex.yy.c : ir.lex
	$(LEX) $^


run : ir
	@./ir

run-1 : ir
	@echo '[twice.ir2]'
	@./ir < examples/twice.ir2

run-2 : ir
	@echo '[triangular.ir2]'
	@./ir < examples/triangular.ir2

run-3 : ir
	@echo '[example.ir2]'
	@./ir < examples/example.ir2

run-4 : ir
	@echo '[factorial.ir2]'
	@./ir < examples/factorial.ir2

run-5 : ir
	@echo '[fig-9.ir2]'
	@./ir < examples/fig-9.ir2	

run-6 : ir
	@echo '[ragbag.ir2]'
	@./ir < examples/ragbag.ir2

clean :
	@$(RM) ir
	@$(RM) ir.tab.c ir.tab.h
	@$(RM) lex.yy.c
