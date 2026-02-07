 $1CC000 DP M!

  S" OVMF/FV/SECFV.Fv" FILE, \EOF

   0 , 0 ,   \ ZeroVector
\ gEfiFirmwareFileSystem2Guid
  ,GUID> 8c8ce578-8a3d-4f1c-9935-896185c32dd3

   0x24000 ,				\ FvLength
  '_' C, 'F' C, 'V' C, 'H' C,		\ Signature
  0xFF C, 0x3E C, 0x04 C, 0x00 C,	\ Attributes
  0x48 W,				\ HeaderLength
  0x6649 W,				\ CheckSum 
  0x02000060 L,				\ ExtHeaderOffset
  0x24 L,				\ Reserved
  0x1000 L,				\ Revision
  0 ,					\ End
  -1 , 1- ,
  $F0AAF4 L,
  $2C W,
  $F800 W,
  ,GUID> 763BED0D-DE9F-48F5-81F1-3E90E1B1A015 \ FvName
  $14 L,
  -1 L,

 HERE S" OVMF/FV/Ffs/SecMain.ffs" FILE, 
  $F800 OVER $16 + W!
  $FFFDC094 SWAP $CC + L!
 
\EOF
  ,GUID> df1ccef6-f301-4a63-9661-fc6030dcc880 \ SecMain
 $AA36 W,
  3    W,
 $C2FE W,
 $F800 W,
\eof
 CREATE SecMain.1.pe32
 S" OVMF/SECFV.1.pe32" FILE,

 $fffdc094  \ BaseAddress
 SecMain.1.pe32  $b4 + L!

 $fffdc09400000000 SecMain.1.pe32  $99c5 +
 2DUP +! $F +	2DUP +! $F +	2DUP +! $F +	2DUP +! $F +
 2DUP +! $F +	2DUP +! $F +	2DUP +! $F +	2DUP +! $F +
 2DUP +! $F +	2DUP +! $F +	2DUP +! $F +	2DUP +! $F +
 2DUP +! $F +	2DUP +! $F +	2DUP +! $F +	2DUP +! $F +
 2DUP +! $F +	2DUP +! $F +	2DUP +! $F +	2DUP +! $F +
 2DUP +! $F +	2DUP +! $F +	2DUP +! $F +	2DUP +! $F +
 2DUP +! $F +	2DUP +! $F +	2DUP +! $F +	2DUP +! $F +
 2DUP +! $F +	2DUP +! $F +	2DUP +! $F +	2DUP +! $F +
 2DUP +! $127B +
 2DUP +! $20 +
 2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +
 2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +
 2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +
 2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +
 2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +
 2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +
 2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +	2DUP +! 8 +
 2DUP +! 8 +	2DUP +! $20 +
 2DUP +! 8 +	2DUP +! $10 +
 2DUP +! $28 +
 2DUP +! 8 + 2DUP +! $10 + 2DUP +! 
 2DROP \ $7777777777777777 SWAP ! 
 $14 W,
 $1500 W,
\ 'S' W, 'e' W, 'c' W, 'M' W, 'a' W, 'i' W, 'n' W,
 S" SecMain" U$,
 $1400000E0000 ,
 S" 1.0" U$, 0 W,




 
