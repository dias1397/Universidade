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
	@./ir < examples/twice.ir2 > output/twice.mips

run-2 : ir
	@echo '[triangular.ir2]'
	@./ir < examples/triangular.ir2 > output/triangular.mips

run-3 : ir
	@echo '[example.ir2]'
	@./ir < examples/example.ir2 > output/example.mips

run-4 : ir
	@echo '[factorial.ir2]'
	@./ir < examples/factorial.ir2 > output/factorial.mips

run-5 : ir
	@echo '[fig-9.ir2]'
	@./ir < examples/fig-9.ir2 > output/fig-9.mips

run-6 : ir
	@echo '[ragbag.ir2]'
	@./ir < examples/ragbag.ir2 > output/ragbag.mips

dif-1 : 
	@echo '[Compare twice.mips with example]'
	@diff -Zws output/twice.mips examples/twice.mips || exit 0

dif-2 : 
	@echo '[Compare triangular.mips with example]'
	@diff -Zws output/triangular.mips examples/triangular.mips || exit 0

dif-3 : 
	@echo '[Compare example.mips with example]'
	@diff -Zws output/example.mips examples/example.mips || exit 0

dif-4 : 
	@echo '[Compare factorial.mips with example]'
	@diff -Zws output/factorial.mips examples/factorial.mips || exit 0

dif-5 : 
	@echo '[Compare fig-9.mips with example]'
	@diff -Zws output/fig-9.mips examples/fig-9.mips || exit 0

dif-6 : 
	@echo '[Compare ragbag.mips with example]'
	@diff -Zws output/ragbag.mips examples/ragbag.mips || exit 0

clean :
	@$(RM) ir
	@$(RM) ir.tab.c ir.tab.h
	@$(RM) lex.yy.c
	@$(RM) output/twice.mips output/triangular.mips output/example.mips 
	@$(RM) output/factorial.mips output/fig-9.mips output/ragbag.mips 
