
all: Lex Cup
	#export CLASSPATH=.:/usr/share/java/JLex.jar:/usr/share/java/cup.jar
	javac -d . parser.java sym.java Yylex.java -classpath .:/usr/share/java/JLex.jar:/usr/share/java/cup.jar
	javac -classpath .:/usr/share/java/JLex.jar:/usr/share/java/cup.jar Main.java
Lex:	
	jlex CIMS.lex
	mv CIMS.lex.java Yylex.java

Cup:
	cup CIMS.cup

	
