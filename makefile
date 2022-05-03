compile:
	bison -o bison/cminus_syntax.tab.c -d bison/cminus_syntax.y -Wcounterexamples -g
	flex -o flex/lex.yy.c flex/cminus_lexical.l
	# gcc -g -c utils/stack.c -o ./obj/stack.o
	gcc -g -c utils/symbol_table.c -o obj/symbol_table.o -I bison
	gcc -g -c utils/tree.c -o obj/tree.o -I bison
	gcc -g bison/cminus_syntax.tab.c flex/lex.yy.c obj/stack.o obj/symbol_table.o obj/tree.o -I utils -I bison -I flex -Wall

run:
	./a.out tests/t_error02.c
	
debug:
	valgrind -v --tool=memcheck --leak-check=full --log-file="logfile.out" --show-leak-kinds=all --track-origins=yes ./a.out tests/t_correct02.c

clean:
	rm -f logfile.out ./bison/clang_syntax.output
