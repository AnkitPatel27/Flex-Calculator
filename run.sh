yacc -d calc.y                  
lex calc.l 
gcc lex.yy.c y.tab.c -o calc -lm
rm lex.yy.c y.tab.c y.tab.h
./calc