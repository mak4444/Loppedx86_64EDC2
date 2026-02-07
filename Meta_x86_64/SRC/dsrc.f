
 ~mak/lib/fpc.f 

 REQUIRE forth ~mak/lib/caseins.f
\+ CASE-INS  CASE-INS ON

REQUIRE [AGAIN] ~mak/lib/twopass.f 

CREATE SEG_DT
  0 , 0 ,
 -1 ,  0 , -1 ,  0 , -1 ,  0 , -1 ,  0 , -1 , 0 , -1 ,  0 , -1 ,
 -1 ,  0 , -1 ,  0 , -1 ,  0 , -1 ,  0 , -1 , 0 , -1 ,  0 , -1 ,
HERE
  0 , -1 ,
CONSTANT SEG_DT_END


: T> ( tadr -- madr )
 SEG_DT
 BEGIN  CELL+ CELL+  2DUP @ U<
 UNTIL 
 CELL- @ +
;

: >SEG_DT ( madr tadr -- )
 ." SEG_DT00=" .s cr
 SEG_DT
 dup 44 dump
 BEGIN  CELL+ CELL+  2DUP @ U<
 UNTIL  \  madr tadr dtadr
 ." SEG_DT30=" .s cr
 DUP
 DUP CELL+ CELL+ SEG_DT_END OVER - CMOVE>
 >R
 TUCK - SWAP
 R>
 ." SEG_DT60=" .s cr
 2!
 ." SEG_DT70=" .s cr

;

0 VALUE LOW_LIM

WARNING OFF
Meta_x86_64/mhead0.f

REQUIRE TC_?LIMIT ~mak/lib/THERE/STAT.F

src/INIT/srcxx.f 
\- 4+ : 4+ 4 + ;

Meta_x86_64/mhead.f

 MEM_MODE

\- W>S : W>S ( w -- n )  0xFFFF AND 0x8000 XOR 0x8000 - ;

[IFNDEF] H.R
: H.R           ( n1 n2 -- )    \ display n1 as a hex number right
                                \ justified in a field of n2 characters
                BASE @ >R HEX >R
                0 <# #S #> R> OVER - 0 MAX SPACES TYPE
                R> BASE ! ;
[THEN]

REQUIRE T-START	Meta_x86_64/SRC/tc.f 


