
RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/OVMF/BaseTools/Source/C/bin:.) \
 BUILD_LIB BUILD_FFS OVMF_fd

OVMF_fd: OVMF/FV/SECFV.Fv  OVMF/FVMAIN_COMPACT.BIN Meta_x86_64/MetaForth
 Meta_x86_64/MetaForth BUILD_LIB BUILD_FFS OVMF_fd

Meta_x86_64/MetaForth: Meta_x86_64/Mak64Forth.cpp 
	g++ -o $@ $< -Wreturn-type

OVMF/FVMAIN_COMPACT.BIN: OVMF/FVMAIN_COMPACT.guided.dummy
	cd OVMF/BaseTools/Source/C/LzmaCompress;make;cd ../../../../../
	LzmaCompress -e -o $@ $<

OVMF/FVMAIN_COMPACT.guided.dummy: OVMF/FVMAIN_COMPACT.1fv.sec  OVMF/FVMAIN_COMPACT.2fv.sec
	GenSec --sectionalign 128 --sectionalign 16 -o $@ \
 OVMF/FVMAIN_COMPACT.1fv.sec \
 OVMF/FVMAIN_COMPACT.2fv.sec

OVMF/FVMAIN_COMPACT.1fv.sec: OVMF/FV/PEIFV.Fv
	GenSec -s EFI_SECTION_FIRMWARE_VOLUME_IMAGE -o $@ $<

OVMF/FVMAIN_COMPACT.2fv.sec: OVMF/FV/DXEFV.Fv
	GenSec -s EFI_SECTION_FIRMWARE_VOLUME_IMAGE -o $@ $<

OVMF/FV/PEIFV.Fv: GenFv OVMF/FV/PEIFV.inf \
	OVMF/FV/Ffs/PeiCore.ffs \
	OVMF/FV/Ffs/PcdPeim.ffs \
	OVMF/FV/Ffs/PlatformPei.ffs \
	OVMF/FV/Ffs/DxeIpl.ffs
	GenFv -o $@ -i OVMF/FV/PEIFV.inf

OVMF/FV/SECFV.Fv: GenFv OVMF/FV/SECFV.inf \
OVMF/FV/Ffs/SecMain.ffs \
OVMF/FV/Ffs/ResetVector.ffs
	GenFv -a OVMF/FV/Ffs/SECFV.inf -o OVMF/FV/SECFV.Fv -i OVMF/FV/SECFV.inf

OVMF/FV/DXEFV.Fv: GenFv OVMF/FV/DXEFV.inf \
 OVMF/FV/Ffs/PeiCore.ffs \
 OVMF/FV/Ffs/PcdPeim.ffs \
 OVMF/FV/Ffs/WatchdogTimer.ffs \
 OVMF/FV/Ffs/Metronome.ffs \
 OVMF/FV/Ffs/SecurityStubDxe.ffs \
 OVMF/FV/Ffs/EnglishDxe.ffs \
 OVMF/FV/Ffs/LocalApicTimerDxe.ffs \
 OVMF/FV/Ffs/SioBusDxe.ffs \
 OVMF/FV/Ffs/CpuIo2Dxe.ffs \
 OVMF/FV/Ffs/SataController.ffs \
 OVMF/FV/Ffs/ConPlatformDxe.ffs \
 OVMF/FV/Ffs/DiskIoDxe.ffs \
 OVMF/FV/Ffs/PcdDxe.ffs \
 OVMF/FV/Ffs/FaultTolerantWriteDxe.ffs \
 OVMF/FV/Ffs/IoMmuDxe.ffs \
 OVMF/FV/Ffs/S3SaveStateDxe.ffs \
 OVMF/FV/Ffs/QemuVideoDxe.ffs \
 OVMF/FV/Ffs/CapsuleRuntimeDxe.ffs \
 OVMF/FV/Ffs/MonotonicCounterRuntimeDxe.ffs \
 OVMF/FV/Ffs/AtaBusDxe.ffs \
 OVMF/FV/Ffs/Ps2KeyboardDxe.ffs \
 OVMF/FV/Ffs/PartitionDxe.ffs \
 OVMF/FV/Ffs/GraphicsConsoleDxe.ffs \
 OVMF/FV/Ffs/RuntimeDxe.ffs \
 OVMF/FV/Ffs/ResetSystemRuntimeDxe.ffs \
 OVMF/FV/Ffs/PcRtc.ffs \
 OVMF/FV/Ffs/EmuVariableFvbRuntimeDxe.ffs \
 OVMF/FV/Ffs/ReportStatusCodeRouterRuntimeDxe.ffs \
 OVMF/FV/Ffs/PciSioSerialDxe.ffs \
 OVMF/FV/Ffs/PlatformDxe.ffs  \
 OVMF/FV/Ffs/CpuDxe.ffs \
 OVMF/FV/Ffs/DxeCore.ffs \
 OVMF/FV/Ffs/PciHostBridgeDxe.ffs \
 OVMF/FV/Ffs/TerminalDxe.ffs \
 OVMF/FV/Ffs/ConSplitterDxe.ffs \
 OVMF/FV/Ffs/Fat.ffs \
 OVMF/FV/Ffs/AtaAtapiPassThruDxe.ffs \
 OVMF/FV/Ffs/DevicePathDxe.ffs \
 OVMF/FV/Ffs/VariableRuntimeDxe.ffs \
 OVMF/FV/Ffs/PciBusDxe.ffs \
 OVMF/FV/Ffs/UiApp.ffs \
 OVMF/FV/Ffs/BdsDxe.ffs \
 OVMF/FV/Ffs/BootManagerMenuApp.ffs \
 OVMF/FV/Ffs/DisplayEngine.ffs \
 OVMF/FV/Ffs/SetupBrowser.ffs \
 OVMF/FV/Ffs/HiiDatabase.ffs 
	GenFv -o OVMF/FV/DXEFV.Fv -i OVMF/FV/DXEFV.inf

GenFv: ../libs/libCommon.a
	cd OVMF/BaseTools/Source/C/GenFv;make;cd ../../../../../

GenFw: ../libs/libCommon.a
	cd OVMF/BaseTools/Source/C/GenFw;make;cd ../../../../../

GenFfs: ../libs/libCommon.a
	cd OVMF/BaseTools/Source/C/GenFfs;make;cd ../../../../../

GenSec: ../libs/libCommon.a
	cd OVMF/BaseTools/Source/C/GenSec;make;cd ../../../../../

../libs/libCommon.a:
	cd OVMF/BaseTools/Source/C/Common;make; cd ../../../../../

BUILD_FFS: GenSec GenFw GenFfs
	make -f OVMF/MdeModulePkg/Core/Pei/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/PCD/Pei/GNUmakefile
	make -f OVMF/OvmfPkg/PlatformPei/GNUmakefile
	make -f OVMF/MdeModulePkg/Core/DxeIplPeim/GNUmakefile
	make -f OVMF/OvmfPkg/Sec/GNUmakefile 
	make -f OVMF/OvmfPkg/ResetVector/GNUmakefile 
	make -f OVMF/MdeModulePkg/Universal/WatchdogTimerDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/Metronome/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/SecurityStubDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/Disk/UnicodeCollation/EnglishDxe/GNUmakefile
	make -f OVMF/OvmfPkg/LocalApicTimerDxe/GNUmakefile 
	make -f OVMF/OvmfPkg/SioBusDxe/GNUmakefile 
	make -f OVMF/UefiCpuPkg/CpuIo2Dxe/GNUmakefile 
	make -f OVMF/MdeModulePkg/Bus/Pci/SataControllerDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/Console/ConPlatformDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/Disk/DiskIoDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/PCD/Dxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/FaultTolerantWriteDxe/GNUmakefile
	make -f OVMF/OvmfPkg/IoMmuDxe/GNUmakefile 
	make -f OVMF/MdeModulePkg/Universal/Acpi/S3SaveStateDxe/GNUmakefile
	make -f OVMF/OvmfPkg/QemuVideoDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/CapsuleRuntimeDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/MonotonicCounterRuntimeDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Bus/Ata/AtaBusDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Bus/Isa/Ps2KeyboardDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/Disk/PartitionDxe/GNUmakefile 
	make -f OVMF/MdeModulePkg/Universal/Console/GraphicsConsoleDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Core/RuntimeDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/ResetSystemRuntimeDxe/GNUmakefile
	make -f OVMF/PcAtChipsetPkg/PcatRealTimeClockRuntimeDxe/GNUmakefile
	make -f OVMF/OvmfPkg/EmuVariableFvbRuntimeDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Bus/Pci/PciSioSerialDxe/GNUmakefile
	make -f OVMF/OvmfPkg/PlatformDxe/GNUmakefile
	make -f OVMF/UefiCpuPkg/CpuDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Core/Dxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Bus/Pci/PciHostBridgeDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/Console/TerminalDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/Console/ConSplitterDxe/GNUmakefile
	make -f OVMF/FatPkg/EnhancedFatDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Bus/Ata/AtaAtapiPassThru/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/DevicePathDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/Variable/RuntimeDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Bus/Pci/PciBusDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Application/UiApp/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/BdsDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Application/BootManagerMenuApp/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/DisplayEngineDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/SetupBrowserDxe/GNUmakefile
	make -f OVMF/MdeModulePkg/Universal/HiiDatabaseDxe/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseSynchronizationLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseDebugPrintErrorLevelLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiBootServicesTableLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiApplicationEntryPoint/GNUmakefile

BUILD_LIB:
	make -f OVMF/MdePkg/Library/RegisterFilterLibNull/GNUmakefile
	make -f OVMF/OvmfPkg/Library/AmdSvsmLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/CcExitLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/CcExitLib/CcExitLib/GNUmakefile
	make -f OVMF/MdePkg/Library/TdxLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/CcProbeLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/BaseMemEncryptSevLib/GNUmakefile
	make -f OVMF/UefiCpuPkg/Library/BaseXApicX2ApicLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseIoLibIntrinsic/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseCpuLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseMemoryLibRepStr/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePrintLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/PlatformDebugLibIoPort/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePciCf8Lib/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePciLibCf8/GNUmakefile
	make -f OVMF/OvmfPkg/Library/AcpiTimerLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/AcpiTimerLib/BaseAcpiTimerLib/GNUmakefile
	make -f OVMF/CryptoPkg/Library/OpensslLib/GNUmakefile
	make -f OVMF/CryptoPkg/Library/BaseCryptLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseSynchronizationLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/DebugAgentLibNull/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseSafeIntLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePeCoffExtraActionLibNull/GNUmakefile
	make -f OVMF/PcAtChipsetPkg/Library/SerialIoLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePeCoffGetEntryPointLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseExtractGuidedSectionLib/GNUmakefile
	make -f OVMF/OvmfPkg/IntelTdx/TdxMeasurementLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/TdxMailboxLib/GNUmakefile
	make -f OVMF/UefiCpuPkg/Library/CpuExceptionHandlerLib/GNUmakefile
	make -f OVMF/UefiCpuPkg/Library/CpuPageTableLib/GNUmakefile
	make -f OVMF/MdePkg/Library/StackCheckLibNull/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/LzmaCustomDecompressLib/GNUmakefile
	make -f OVMF/OvmfPkg/IntelTdx/TdxHelperLib/GNUmakefile
	make -f OVMF/OvmfPkg/IntelTdx/TdxHelperLib/PeiTdxHelperLib/GNUmakefile
	make -f OVMF/MdePkg/Library/DxePcdLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseDebugPrintErrorLevelLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiBootServicesTableLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiMemoryAllocationLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiRuntimeServicesTableLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiDevicePathLibDevicePathProtocol/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiLib/GNUmakefile
	make -f OVMF/MdePkg/Library/DxeHobLib/GNUmakefile
	make -f OVMF/MdePkg/Library/DxeServicesLib/GNUmakefile
	make -f OVMF/MdePkg/Library/DxeServicesTableLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePerformanceLibNull/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseOrderedCollectionRedBlackTreeLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiFileHandleLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/CcProbeLib/DxeCcProbeLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/PlatformDebugLibIoPort/PlatformDebugLibIoPort/GNUmakefile
	make -f OVMF/OvmfPkg/Library/QemuFwCfgLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/LoadLinuxLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/QemuFwCfgSimpleParserLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/SerializeVariablesLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/PlatformBootManagerCommonLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/XenPlatformLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/GNUmakefile
	make -f OVMF/OvmfPkg/Library/PlatformBmPrintScLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/QemuBootOrderLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/X86QemuLoadImageLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/QemuFwCfgS3Lib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/NvVarsFileLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/PlatformBootManagerLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiDriverEntryPoint/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/UefiHiiServicesLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/UefiSortLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/UefiHiiLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/VariablePolicyHelperLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/DxeReportStatusCodeLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/UefiBootManagerLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/BootLogoLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/BaseMemEncryptSevLib/PeiMemEncryptSevLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/BaseMemEncryptSevLib/DxeMemEncryptSevLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/HardwareInfoLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/HardwareInfoLib/DxeHardwareInfoLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/QemuFwCfgS3Lib/PeiQemuFwCfgS3LibFwCfg/GNUmakefile
	make -f OVMF/OvmfPkg/Library/PlatformInitLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/SmmRelocationLib/GNUmakefile
	make -f OVMF/MdePkg/Library/PeiMemoryAllocationLib/GNUmakefile
	make -f OVMF/MdePkg/Library/PeiPcdLib/GNUmakefile
	make -f OVMF/MdePkg/Library/PeiServicesTablePointerLibIdt/GNUmakefile
	make -f OVMF/MdePkg/Library/PeiServicesLib/GNUmakefile
	make -f OVMF/MdePkg/Library/PeiHobLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseCacheMaintenanceLib/GNUmakefile
	make -f OVMF/MdePkg/Library/PeiResourcePublicationLib/GNUmakefile
	make -f OVMF/MdePkg/Library/PeimEntryPoint/GNUmakefile
	make -f OVMF/CryptoPkg/Library/IntrinsicLib/GNUmakefile
	make -f OVMF/CryptoPkg/Library/BaseCryptLib/PeiCryptLib/GNUmakefile
	make -f OVMF/UefiCpuPkg/Library/MtrrLib/GNUmakefile 
	make -f OVMF/UefiCpuPkg/Library/CpuExceptionHandlerLib/PeiCpuExceptionHandlerLib/GNUmakefile
	make -f OVMF/UefiCpuPkg/Library/CpuExceptionHandlerLib/DxeCpuExceptionHandlerLib/GNUmakefile
	make -f OVMF/SecurityPkg/Library/PeiTpmMeasurementLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePcdLibNull/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiDevicePathLib/GNUmakefile
	make -f OVMF/MdePkg/Library/DxeCoreEntryPoint/GNUmakefile
	make -f OVMF/MdePkg/Library/DxeCoreHobLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePeCoffLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseUefiDecompressLib/GNUmakefile
	make -f OVMF/MdePkg/Library/DxeExtractGuidedSectionLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/DxeCoreMemoryAllocationLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/ImagePropertiesRecordLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/AcpiTimerLib/DxeAcpiTimerLib/GNUmakefile
	make -f OVMF/UefiCpuPkg/Library/MicrocodeLib/GNUmakefile 
	make -f OVMF/UefiCpuPkg/Library/MpInitLib/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiApplicationEntryPoint/GNUmakefile
	make -f OVMF/MdePkg/Library/UefiRuntimeLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/AuthVariableLibNull/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/VarCheckLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/BaseVariableFlashInfoLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/VariablePolicyLib/GNUmakefile
	make -f OVMF/SecurityPkg/Library/DxeTpmMeasurementLib/GNUmakefile
	make -f OVMF/MdePkg/Library/PeiExtractGuidedSectionLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/BaseMemEncryptTdxLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/PciHostBridgeUtilityLib/GNUmakefile
	make -f OVMF/MdePkg/Library/BasePciSegmentLibPci/GNUmakefile
	make -f OVMF/OvmfPkg/Library/PciHostBridgeLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/DeviceManagerUiLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/OemHookStatusCodeLibNull/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/PeiReportStatusCodeLib/GNUmakefile
	make -f OVMF/MdePkg/Library/PeiCoreEntryPoint/GNUmakefile
	make -f OVMF/MdePkg/Library/BaseSmbusLibNull/GNUmakefile
	make -f OVMF/OvmfPkg/Library/LockBoxLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/PiDxeS3BootScriptLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/ResetSystemLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/RuntimeDxeReportStatusCodeLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/NestedInterruptTplLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/FrameBufferBltLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/DxeSecurityManagementLib/GNUmakefile
	make -f OVMF/OvmfPkg/Library/EmuVariableFvbLib/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/DxeCapsuleLibNull/GNUmakefile
	make -f OVMF/MdeModulePkg/Library/CustomizedDisplayLib/GNUmakefile

cleanfv:
	$(RM) OVMF.fd
	$(RM) OVMF/FV/SECFV.Fv
	$(RM) OVMF/FV/PEIFV.Fv
	$(RM) OVMF/FV/DXEFV.Fv

clean:
	$(RM) -r OVMF/BaseTools/Source/C/bin
	$(RM) -r OVMF/BaseTools/Source/C/libs
	cd OVMF/BaseTools/Source/C/GenFv;make clean; cd ../../../../../
	cd OVMF/BaseTools/Source/C/GenFw;make clean; cd ../../../../../
	cd OVMF/BaseTools/Source/C/GenFfs;make clean; cd ../../../../../
	cd OVMF/BaseTools/Source/C/GenSec;make clean; cd ../../../../../
	cd OVMF/BaseTools/Source/C/LzmaCompress;make clean; cd ../../../../../
	cd OVMF/BaseTools/Source/C/Common;make clean; cd ../../../../../
	$(RM) Meta_x86_64/MetaForth
	$(RM) OVMF.fd
	$(RM) OVMF/FV/SECFV.Fv
	$(RM) OVMF/FV/PEIFV.Fv
	$(RM) OVMF/FV/DXEFV.Fv
	$(RM) OVMF/FVMAIN_COMPACT.BIN
	$(RM) OVMF/FVMAIN_COMPACT.guided.dummy
	$(RM) OVMF/FVMAIN_COMPACT.1fv.sec
	$(RM) OVMF/FVMAIN_COMPACT.2fv.sec
	make -f OVMF/OvmfPkg/Sec/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Core/Pei/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/PCD/Pei/GNUmakefile clean
	make -f OVMF/OvmfPkg/PlatformPei/GNUmakefile clean
	make -f OVMF/OvmfPkg/Sec/GNUmakefile clean
	make -f OVMF/OvmfPkg/ResetVector/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/WatchdogTimerDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Metronome/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/SecurityStubDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Disk/UnicodeCollation/EnglishDxe/GNUmakefile clean
	make -f OVMF/OvmfPkg/LocalApicTimerDxe/GNUmakefile clean
	make -f OVMF/OvmfPkg/SioBusDxe/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/CpuIo2Dxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Bus/Pci/SataControllerDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Console/ConPlatformDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Disk/DiskIoDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/PCD/Dxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/FaultTolerantWriteDxe/GNUmakefile clean 
	make -f OVMF/OvmfPkg/IoMmuDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Acpi/S3SaveStateDxe/GNUmakefile clean
	make -f OVMF/OvmfPkg/QemuVideoDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/CapsuleRuntimeDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/MonotonicCounterRuntimeDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Bus/Ata/AtaBusDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Bus/Isa/Ps2KeyboardDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Disk/PartitionDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Console/GraphicsConsoleDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Core/RuntimeDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/ResetSystemRuntimeDxe/GNUmakefile  clean
	make -f OVMF/PcAtChipsetPkg/PcatRealTimeClockRuntimeDxe/GNUmakefile  clean
	make -f OVMF/OvmfPkg/EmuVariableFvbRuntimeDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Bus/Pci/PciSioSerialDxe/GNUmakefile  clean
	make -f OVMF/OvmfPkg/PlatformDxe/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/CpuDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Core/Dxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Bus/Pci/PciHostBridgeDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Console/TerminalDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Console/ConSplitterDxe/GNUmakefile clean
	make -f OVMF/FatPkg/EnhancedFatDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Bus/Ata/AtaAtapiPassThru/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/DevicePathDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/Variable/RuntimeDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Bus/Pci/PciBusDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Application/UiApp/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/BdsDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Application/BootManagerMenuApp/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/DisplayEngineDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/SetupBrowserDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Universal/HiiDatabaseDxe/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Core/DxeIplPeim/GNUmakefile clean
	make -f OVMF/MdePkg/Library/RegisterFilterLibNull/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/AmdSvsmLib/GNUmakefile  clean
	make -f OVMF/OvmfPkg/Library/CcExitLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/CcExitLib/CcExitLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/TdxLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/CcProbeLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/BaseMemEncryptSevLib/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/Library/BaseXApicX2ApicLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseIoLibIntrinsic/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseCpuLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseMemoryLibRepStr/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePrintLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/PlatformDebugLibIoPort/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePciCf8Lib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePciLibCf8/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/AcpiTimerLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/AcpiTimerLib/BaseAcpiTimerLib/GNUmakefile clean
	make -f OVMF/CryptoPkg/Library/OpensslLib/GNUmakefile clean
	make -f OVMF/CryptoPkg/Library/BaseCryptLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseSynchronizationLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/DebugAgentLibNull/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseSafeIntLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePeCoffExtraActionLibNull/GNUmakefile clean
	make -f OVMF/PcAtChipsetPkg/Library/SerialIoLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePeCoffGetEntryPointLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseExtractGuidedSectionLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/IntelTdx/TdxMeasurementLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/TdxMailboxLib/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/Library/CpuExceptionHandlerLib/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/Library/CpuPageTableLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/StackCheckLibNull/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/LzmaCustomDecompressLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/IntelTdx/TdxHelperLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/IntelTdx/TdxHelperLib/PeiTdxHelperLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/DxePcdLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseDebugPrintErrorLevelLib/GNUmakefile  clean
	make -f OVMF/MdePkg/Library/UefiBootServicesTableLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiMemoryAllocationLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiRuntimeServicesTableLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiDevicePathLibDevicePathProtocol/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/DxeHobLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/DxeServicesLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/DxeServicesTableLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePerformanceLibNull/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseOrderedCollectionRedBlackTreeLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiFileHandleLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/CcProbeLib/DxeCcProbeLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/PlatformDebugLibIoPort/PlatformDebugLibIoPort/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/QemuFwCfgLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/LoadLinuxLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/QemuFwCfgSimpleParserLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/SerializeVariablesLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/PlatformBootManagerCommonLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/XenPlatformLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/PlatformBmPrintScLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/QemuBootOrderLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/X86QemuLoadImageLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/QemuFwCfgS3Lib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/NvVarsFileLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/PlatformBootManagerLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiDriverEntryPoint/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/UefiHiiServicesLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/UefiSortLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/UefiHiiLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/VariablePolicyHelperLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/DxeReportStatusCodeLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/UefiBootManagerLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/BootLogoLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/BaseMemEncryptSevLib/PeiMemEncryptSevLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/BaseMemEncryptSevLib/DxeMemEncryptSevLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib/GNUmakefile  clean
	make -f OVMF/OvmfPkg/Library/HardwareInfoLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/QemuFwCfgS3Lib/PeiQemuFwCfgS3LibFwCfg/GNUmakefile clean 
	make -f OVMF/OvmfPkg/Library/PlatformInitLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/SmmRelocationLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/PeiMemoryAllocationLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/PeiPcdLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/PeiServicesTablePointerLibIdt/GNUmakefile clean
	make -f OVMF/MdePkg/Library/PeiServicesLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/PeiHobLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseCacheMaintenanceLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/PeiResourcePublicationLib/GNUmakefile  clean
	make -f OVMF/MdePkg/Library/PeimEntryPoint/GNUmakefile  clean
	make -f OVMF/CryptoPkg/Library/IntrinsicLib/GNUmakefile clean
	make -f OVMF/CryptoPkg/Library/BaseCryptLib/PeiCryptLib/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/Library/MtrrLib/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/Library/CpuExceptionHandlerLib/PeiCpuExceptionHandlerLib/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/Library/CpuExceptionHandlerLib/DxeCpuExceptionHandlerLib/GNUmakefile clean
	make -f OVMF/SecurityPkg/Library/PeiTpmMeasurementLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePcdLibNull/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiDevicePathLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/DxeCoreEntryPoint/GNUmakefile clean
	make -f OVMF/MdePkg/Library/DxeCoreHobLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePeCoffLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseUefiDecompressLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/DxeExtractGuidedSectionLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/DxeCoreMemoryAllocationLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/ImagePropertiesRecordLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/AcpiTimerLib/DxeAcpiTimerLib/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/Library/MicrocodeLib/GNUmakefile clean
	make -f OVMF/UefiCpuPkg/Library/MpInitLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiApplicationEntryPoint/GNUmakefile clean
	make -f OVMF/MdePkg/Library/UefiRuntimeLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/AuthVariableLibNull/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/VarCheckLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/BaseVariableFlashInfoLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/VariablePolicyLib/GNUmakefile clean
	make -f OVMF/SecurityPkg/Library/DxeTpmMeasurementLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/PeiExtractGuidedSectionLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/BaseMemEncryptTdxLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/HardwareInfoLib/DxeHardwareInfoLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/PciHostBridgeUtilityLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BasePciSegmentLibPci/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/PciHostBridgeLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/DeviceManagerUiLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/OemHookStatusCodeLibNull/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/PeiReportStatusCodeLib/GNUmakefile clean
	make -f OVMF/MdePkg/Library/PeiCoreEntryPoint/GNUmakefile clean
	make -f OVMF/MdePkg/Library/BaseSmbusLibNull/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/LockBoxLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/PiDxeS3BootScriptLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/ResetSystemLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/RuntimeDxeReportStatusCodeLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/NestedInterruptTplLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/FrameBufferBltLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/DxeSecurityManagementLib/GNUmakefile clean
	make -f OVMF/OvmfPkg/Library/EmuVariableFvbLib/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/DxeCapsuleLibNull/GNUmakefile clean
	make -f OVMF/MdeModulePkg/Library/CustomizedDisplayLib/GNUmakefile clean

