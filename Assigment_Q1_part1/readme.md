# Assignment 8 (lex Calculator) 
## (Q1_Part 1)

### CFG
The production rule we have used for the assigment is
```
line 
line assignment exp exp2 exp3 term
identifier number + - * / % ^ ( ) exit ; print = 
line -> assignment ; | exit ; | print exp ; | line assignment ; | line print exp ; | line exit ;
assignment -> identifier = exp
exp -> exp2 | exp + exp2 | exp - exp2
exp2 -> exp3 | exp2 * exp3 | exp2 % exp3 | exp2 / exp3          
exp3 -> term | exp3 ^ term
term -> number | ( exp ) | identifier
``` 

The operator precedence is 
```
High ----------- Low
^  %  *  /  +  - 

All the operators are left assciativity
```

 
the below is the DFA for the above Production Rule for LR(0) parsing
## DFA
![App Screenshot](./LR(0)DFA.png)

### LR(0) parsing table 

```
+------+----------------------------+
| Name |         Reduction          |
+------+----------------------------+
|  r0  |     line->assignment;      |
|  r1  |        line->exit;         |
|  r2  |      line->printexp;       |
|  r3  |   line->lineassignment;    |
|  r4  |    line->lineprintexp;     |
|  r5  |      line->lineexit;       |
|  r6  | assignment->identifier=exp |
|  r7  |         exp->exp2          |
|  r8  |       exp->exp+exp2        |
|  r9  |       exp->exp-exp2        |
| r10  |         exp2->exp3         |
| r11  |      exp2->exp2*exp3       |
| r12  |      exp2->exp2%exp3       |
| r13  |      exp2->exp2/exp3       |
| r14  |         exp3->term         |
| r15  |      exp3->exp3^term       |
| r16  |        term->number        |
| r17  |        term->(exp)         |
| r18  |      term->identifier      |
| r19  |        line'->line$        |
+------+----------------------------+


+--------+-----+----------+-----+-----+----------+----------+----------+----------+-----+-----+-----------+------+------------+--------+-------+------------+-----+------+------+------+------+
| STATES |  $  |    %     |  (  |  )  |    *     |    +     |    -     |    /     |  ;  |  =  |     ^     | exit | identifier | number | print | assignment | exp | exp2 | exp3 | line | term |
+--------+-----+----------+-----+-----+----------+----------+----------+----------+-----+-----+-----------+------+------------+--------+-------+------------+-----+------+------+------+------+
|   s0   |     |          |     |     |          |          |          |          |     |     |           |  s3  |     s1     |        |   s5  |     2      |     |      |      |  4   |      |
|   s1   |     |          |     |     |          |          |          |          |     |  s6 |           |      |            |        |       |            |     |      |      |      |      |
|   s2   |     |          |     |     |          |          |          |          |  s7 |     |           |      |            |        |       |            |     |      |      |      |      |
|   s3   |     |          |     |     |          |          |          |          |  s8 |     |           |      |            |        |       |            |     |      |      |      |      |
|   s4   | acc |          |     |     |          |          |          |          |     |     |           | s10  |     s1     |        |  s11  |     9      |     |      |      |      |      |
|   s5   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |  12 |  13  |  14  |      |  15  |
|   s6   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |  19 |  13  |  14  |      |  15  |
|   s7   |  r0 |    r0    |  r0 |  r0 |    r0    |    r0    |    r0    |    r0    |  r0 |  r0 |     r0    |  r0  |     r0     |   r0   |   r0  |            |     |      |      |      |      |
|   s8   |  r1 |    r1    |  r1 |  r1 |    r1    |    r1    |    r1    |    r1    |  r1 |  r1 |     r1    |  r1  |     r1     |   r1   |   r1  |            |     |      |      |      |      |
|   s9   |     |          |     |     |          |          |          |          | s20 |     |           |      |            |        |       |            |     |      |      |      |      |
|  s10   |     |          |     |     |          |          |          |          | s21 |     |           |      |            |        |       |            |     |      |      |      |      |
|  s11   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |  22 |  13  |  14  |      |  15  |
|  s12   |     |          |     |     |          |   s23    |   s24    |          | s25 |     |           |      |            |        |       |            |     |      |      |      |      |
|  s13   |  r7 | s26 (r7) |  r7 |  r7 | s27 (r7) |    r7    |    r7    | s28 (r7) |  r7 |  r7 |     r7    |  r7  |     r7     |   r7   |   r7  |            |     |      |      |      |      |
|  s14   | r10 |   r10    | r10 | r10 |   r10    |   r10    |   r10    |   r10    | r10 | r10 | s29 (r10) | r10  |    r10     |  r10   |  r10  |            |     |      |      |      |      |
|  s15   | r14 |   r14    | r14 | r14 |   r14    |   r14    |   r14    |   r14    | r14 | r14 |    r14    | r14  |    r14     |  r14   |  r14  |            |     |      |      |      |      |
|  s16   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |  30 |  13  |  14  |      |  15  |
|  s17   | r18 |   r18    | r18 | r18 |   r18    |   r18    |   r18    |   r18    | r18 | r18 |    r18    | r18  |    r18     |  r18   |  r18  |            |     |      |      |      |      |
|  s18   | r16 |   r16    | r16 | r16 |   r16    |   r16    |   r16    |   r16    | r16 | r16 |    r16    | r16  |    r16     |  r16   |  r16  |            |     |      |      |      |      |
|  s19   |  r6 |    r6    |  r6 |  r6 |    r6    | s23 (r6) | s24 (r6) |    r6    |  r6 |  r6 |     r6    |  r6  |     r6     |   r6   |   r6  |            |     |      |      |      |      |
|  s20   |  r3 |    r3    |  r3 |  r3 |    r3    |    r3    |    r3    |    r3    |  r3 |  r3 |     r3    |  r3  |     r3     |   r3   |   r3  |            |     |      |      |      |      |
|  s21   |  r5 |    r5    |  r5 |  r5 |    r5    |    r5    |    r5    |    r5    |  r5 |  r5 |     r5    |  r5  |     r5     |   r5   |   r5  |            |     |      |      |      |      |
|  s22   |     |          |     |     |          |   s23    |   s24    |          | s31 |     |           |      |            |        |       |            |     |      |      |      |      |
|  s23   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |     |  32  |  14  |      |  15  |
|  s24   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |     |  33  |  14  |      |  15  |
|  s25   |  r2 |    r2    |  r2 |  r2 |    r2    |    r2    |    r2    |    r2    |  r2 |  r2 |     r2    |  r2  |     r2     |   r2   |   r2  |            |     |      |      |      |      |
|  s26   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |     |      |  34  |      |  15  |
|  s27   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |     |      |  35  |      |  15  |
|  s28   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |     |      |  36  |      |  15  |
|  s29   |     |          | s16 |     |          |          |          |          |     |     |           |      |    s17     |  s18   |       |            |     |      |      |      |  37  |
|  s30   |     |          |     | s38 |          |   s23    |   s24    |          |     |     |           |      |            |        |       |            |     |      |      |      |      |
|  s31   |  r4 |    r4    |  r4 |  r4 |    r4    |    r4    |    r4    |    r4    |  r4 |  r4 |     r4    |  r4  |     r4     |   r4   |   r4  |            |     |      |      |      |      |
|  s32   |  r8 | s26 (r8) |  r8 |  r8 | s27 (r8) |    r8    |    r8    | s28 (r8) |  r8 |  r8 |     r8    |  r8  |     r8     |   r8   |   r8  |            |     |      |      |      |      |
|  s33   |  r9 | s26 (r9) |  r9 |  r9 | s27 (r9) |    r9    |    r9    | s28 (r9) |  r9 |  r9 |     r9    |  r9  |     r9     |   r9   |   r9  |            |     |      |      |      |      |
|  s34   | r12 |   r12    | r12 | r12 |   r12    |   r12    |   r12    |   r12    | r12 | r12 | s29 (r12) | r12  |    r12     |  r12   |  r12  |            |     |      |      |      |      |
|  s35   | r11 |   r11    | r11 | r11 |   r11    |   r11    |   r11    |   r11    | r11 | r11 | s29 (r11) | r11  |    r11     |  r11   |  r11  |            |     |      |      |      |      |
|  s36   | r13 |   r13    | r13 | r13 |   r13    |   r13    |   r13    |   r13    | r13 | r13 | s29 (r13) | r13  |    r13     |  r13   |  r13  |            |     |      |      |      |      |
|  s37   | r15 |   r15    | r15 | r15 |   r15    |   r15    |   r15    |   r15    | r15 | r15 |    r15    | r15  |    r15     |  r15   |  r15  |            |     |      |      |      |      |
|  s38   | r17 |   r17    | r17 | r17 |   r17    |   r17    |   r17    |   r17    | r17 | r17 |    r17    | r17  |    r17     |  r17   |  r17  |            |     |      |      |      |      |
+--------+-----+----------+-----+-----+----------+----------+----------+----------+-----+-----+-----------+------+------------+--------+-------+------------+-----+------+------+------+------+
```

```
SR Conflict at s 13 % 
SR Conflict at s 13 *
SR Conflict at s 13 /
SR Conflict at s 14 ^
SR Conflict at s 19 +
SR Conflict at s 19 -
SR Conflict at s 32 %
SR Conflict at s 32 *
SR Conflict at s 32 /
SR Conflict at s 33 %
SR Conflict at s 33 *
SR Conflict at s 33 /
SR Conflict at s 34 ^
SR Conflict at s 35 ^
SR Conflict at s 36 ^
```

This shows that this conflicts can be removed using SLR parsing hence the grammar is also LALR(1) 

