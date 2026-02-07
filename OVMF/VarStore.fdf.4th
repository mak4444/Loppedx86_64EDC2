\  FDF include file with Layout Regions that define an empty variable store.

\ This is the EFI_FIRMWARE_VOLUME_HEADER

  HERE CODE-SIZE $FF FILL

  0 , 0 ,   \ ZeroVector


\ FileSystemGuid: gEfiSystemNvDataFvGuid
  ,GUID>  FFF12B8D-7696-4C8B-A985-2747075B4F50

  HERE \ for csum

   0x20000 ,				\ FvLength
  '_' C, 'F' C, 'V' C, 'H' C,		\ Signature
  0xff C, 0xfe C, 0x04 C, 0x00 C,	\ Attributes
  0x48	W,				\ HeaderLength
  0 W, \  0xF919 W,				\ CheckSum 
  0x02000000 L,				\ ExtHeaderOffset
  0x20 L,				\ Reserved
  0x1000 L,				\ Revision
  0 ,					\ End
 HERE SWAP WSUM CR .( WSUM=) H. CR

\ Signature: gEfiAuthenticatedVariableGuid
  ,GUID> aaf32c78-947b-439a-a180-2e144ec37792

\ Size: 0xe000 (gEfiMdeModulePkgTokenSpaceGuid.PcdFlashNvStorageVariableSize) -
\         0x48 (size of EFI_FIRMWARE_VOLUME_HEADER) = 0xdfb8
\ This can speed up the Variable Dispatch a bit.
  0xe000 0x48 - L,
 0x5A C,	\ FORMATTED 
 0xFE C,	\ HEALTHY 
 0 W, 0 L,	\ Reserved


 $F000 DP M!

  \ gEdkiiWorkingBlockSignatureGuid
   ,GUID> 9e58292b-7c68-497d-a0ce-6500fd9f1b95

  0x642CAF2C L,		\ Crc
  0xFE C,		\ WorkingBlockValid:1
  0xFF C,		\ WorkingBlockInvalid:1
  0xFFFF W,		\ Reserved
  0x0FE0 ,		\ WriteQueueSize


\ CODE-SIZE DP M!

