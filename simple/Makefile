simple:	simple.lex.c
	gcc -o simple lex.yy.c
simple.lex.c:	simple.l
	flex simple.l
clean:
	rm  lex.yy.c simple
