

[IFNDEF] OR!	:  OR! ( N ADDR -- )	DUP @ ROT OR	SWAP ! ; [THEN]
[IFNDEF] AND!	: AND! ( N ADDR -- )	DUP @ ROT AND	SWAP ! ; [THEN]

: L+!  ( N ADDR -- )	DUP L@ ROT + SWAP L! ;
\- BOUNDS : BOUNDS OVER + SWAP ;
\- ?THROW : ?THROW SWAP IF THROW THEN DROP ;
\- ?PAIRS : ?PAIRS	( x1 x1 -- )  XOR -22 ?THROW ;
\- >> : >> RSHIFT ;
\- L>S : L>S ( c -- n )  $FFFFFFFF AND $80000000 XOR $80000000 - ;

0 VALUE MSTR_IMG

REQUIRE NUMBER? ~mak/lib/fpcnum.f 

: CMOVE ( c-addr1 c-addr2 u --- )
\ Copy u bytes starting at c-addr1 to c-addr2, proceeding in ascending
\ order.

   DUP IF  >R
   BEGIN
    OVER 
\ ." C=" DUP H.
 C@
 SWAP DUP >R C!
 R> 1+ SWAP 1+ SWAP
    R>  1- DUP  >R 0=
   UNTIL
   R>
   THEN
   2DROP DROP
;

: cmove>	\ addr1 addr2 len --
  dup if
    tuck over + 1-			\ -- addr1 len addr2 addr2+len-1
    2swap + -rot			\ -- addr1+len addr2 addr2+len-1
    do  1- dup c@ i  c!  -1 +loop
    drop  exit
  then
  2drop drop
;
[then]

: move		\ addr1 addr2 u --
  -rot 2dup u<
  if  rot cmove>  else  rot cmove  THEN
;

: M_CMOVE ( c-addr1 c-addr2 u --- )
\ Copy u bytes starting at c-addr1 to c-addr2, proceeding in ascending
\ order.

   DUP IF  >R
   BEGIN
    OVER 
 MC@
 SWAP DUP >R
 C!
 R> 1+ SWAP 1+ SWAP
    R>  1- DUP  >R 0=
   UNTIL
   R>
   THEN
   2DROP DROP
;

[IFNDEF] #HEADER
: #HEADER ( cfa -- )
  HERE >R
  DP M! HEADER
 R> DP M! ;
[THEN]

[IFNDEF] ALIGN-NOP
: ALIGN-NOP ( n -- )
\ выровнять HERE на n и заполнить NOP
  HERE DUP ROT 2DUP
  MOD DUP IF - + ELSE 2DROP THEN
  OVER - DUP ALLOT 0x90 FILL
;
[THEN]

: XOR!	DUP @ ROT XOR SWAP ! ;

\+ OPTVALNEED 0 TO OPTVALNEED

: IHERE HERE ;

0 VALUE ?SOURCETYPE
: SOURCETYPE_SET -1 TO ?SOURCETYPE ;
: ,GUID>
  BASE M@ HEX
  >IN M@
  PARSE-NAME DROP 8  NUMBER? 0= THROW DROP L,
  >IN M! '-' PARSE 2DROP
 '-' PARSE NUMBER? 0= THROW DROP W,
 '-' PARSE NUMBER? 0= THROW DROP W,
 '-' PARSE NUMBER? 0= THROW DROP DUP 8 >> C, C,
  PARSE-NAME NUMBER? 0= THROW DROP
 CR DUP H.
 DUP 8 >> DUP 8 >> DUP 8 >> DUP 8 >> DUP 8 >>
 C, C,	C, C,	C, C, 

  BASE M!
;

: WSUM ( a1 a2  -- )
 0 -ROT DO I W@ + 2 +LOOP ;

MODULE: TC

: ><DP DP M@ T-DP M@
       DP M! T-DP M! ;

: IALLOT ALLOT ;

: TCONSTANT ( n -- )	><DP CONSTANT   ><DP ;

: CONSTANT HERE THERE? IF TCONSTANT BREAK CONSTANT ;

: TENUM ( n -- )	><DP ENUM  ><DP ;

: ENUM HERE THERE? IF TENUM BREAK ENUM ;

0 VALUE 'DO-CONST

: #define  HERE THERE? IF ><DP #define ><DP BREAK #define ;

: MCREATE CREATE  ;

: LABEL        ( | name --- )  \ 
   IHERE    TCONSTANT ;

: CREATE
   IHERE  \ $7 + $7 ANDC DUP DP M!
  TCONSTANT ;

: THERE HERE ;
: HERE HERE ;

EXPORT

1 [IF]

' <PRE> >BODY M@  ' NOOP  TO <PRE> \ 

[DEFINED] DBG_COUNT [IF] DBG_COUNT M@  DBG_COUNT 0! [THEN]

[DEFINED] DBG_COUNT   [IF]  DBG_COUNT ! [THEN]

TO <PRE>

: T-STOP
  PREVIOUS DEFINITIONS
  HERE THERE?    IF ><DP THEN
;

: T-GO
[DEFINED] DBG_STOP [IF]  DBG_STOP [THEN]
  ALSO TC DEFINITIONS
  HERE THERE? 0= IF ><DP THEN
;

: THERE?A  IMAGE-BEGIN   U< ;
: THERE?B  'FSTART - $880000  U< ;

: TTH  ['] THERE?B TO THERE? ;

: SEG: ( len seg -- )
  HERE $14 + OVER >SEG_DT
  HERE TCONSTANT , DUP , IALLOT
  0 L,
 ; 

: SEG_SET
 M@ DP M!
;

:  ?COMP_ STATE M@ =
         IF  COMPILE,
         ELSE EXECUTE
         THEN ;

-1 VALUE N.FLOAD?

: TC-INTERPRET ( -> )
\ ?SOURCETYPE IF  ." SOURCE=" SOURCE H. H. CR  KEY DROP THEN
 ?SOURCETYPE IF  CR SOURCE TYPE ( KEY DROP) THEN
\  STATE M@ 0= IF  MAIN_S THEN
  BEGIN
    PARSE-NAME DUP
  WHILE
    SFIND ?DUP
    IF [']  ?COMP_  CATCH 
        THROW
    ELSE 
[IFDEF] ?_.
	?_.  N.FLOAD? AND
        IF  F-SIZE @ >R FSINGLE ['] MFFFFF CATCH R> F-SIZE ! THROW
		STATE M@ IF LIT, THEN
        ELSE ?SLITERAL
        THEN
[ELSE] ?SLITERAL
[THEN]
\         S" NOTFOUND" SFIND 
	\         IF EXECUTE
\         ELSE 2DROP
\         ?SLITERAL
\         THEN
    THEN
    ?STACK
  REPEAT 2DROP 
\  STATE M@ 0= IF  MAIN_S THEN
;

 ' TC-INTERPRET  TO INTERPRET

[THEN]

0 VALUE T-STDOUT

: TSAVE ( <filename> -- )
 CR ." TSAVE="
 PARSE-NAME W/O CREATE-FILE THROW  TO T-STDOUT
 0 T> HERE DUP H. T-STDOUT WRITE-FILE ." WRITE-FILE=" H.
\ S" QWERETY"  T-STDOUT WRITE-FILE ." WRITE-FILE=" H.
 T-STDOUT CLOSE-FILE ." CLOSE-FILE=" H.
;
[IFDEF] FILE-SIZE
: FILE, ( addr len -- )
   R/W OPEN-FILE THROW >R
   R@  FILE-SIZE THROW D>S
   HERE OVER R@ READ-FILE THROW
   IALLOT
    R> CLOSE-FILE THROW
;
[ELSE]
: FILE, ( addr len -- )
CR ." FILE,="
   R/W OPEN-FILE DUP H. THROW >R
   BEGIN  ." -"	
	HERE T> $1000 R@ READ-FILE THROW
	DUP IALLOT 0=
   UNTIL

    R> CLOSE-FILE THROW
;

[THEN]

;MODULE
: [T] ALSO TC ; IMMEDIATE
