 $10000 DP M!
  0 , 0 ,

\ gEfiFirmwareFileSystem2Guid
  ,GUID> 8c8ce578-8a3d-4f1c-9935-896185c32dd3

   0x1BC000 ,				\ FvLength
  '_' C, 'F' C, 'V' C, 'H' C,		\ Signature
  0x00 C, 0x08 C, 0x04 C, 0x00 C,	\ Attributes
  0x48	W,				\ HeaderLength
  0 W, \  0x1B97 W,				\ CheckSum 
  0x02000060 L,				\ ExtHeaderOffset
  0x1BC L,				\ Reserved
  0x1000 L,				\ Revision
  0 ,					\ End
  -1 , -1 ,

  $F0AAF4 L,
  $2C W,
  $F800 W,
  ,GUID> 48DB5E17-707C-472D-91CD-1613E7EF51B0 \ FvName

 $14 L,
 -1 L,

  ,GUID> 9E21FD93-9C72-4c15-8C4B-E77F1DB2D792 \ FfsFile
 \ FV_IMAGE
 $BAA30 L,
 $AAE2 W,
 $F806 W,
 $AACA W,
 $206 W,
  ,GUID> EE4E5898-3914-4259-9D6E-DC7BD79403CF \ Section
 $18 W,
 $1 W,
 S" OVMF/FVMAIN_COMPACT.BIN" MCR 2DUP TYPE CR  FILE,
