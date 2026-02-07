
MODULE_NAME = DxeCore
BASE_NAME = $(MODULE_NAME)

MODULE_DIR = OVMF/MdeModulePkg/Core/Dxe

CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps


INC = \
 -I$(MODULE_DIR) \
 -I$(MODULE_DIR)/ff \
 -IOVMF/OvmfPkg/Include \
 -IOVMF/MdePkg/Include \
 -IOVMF/UefiCpuPkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) OVMF/FV/Ffs/$(MODULE_NAME).ffs

OVMF/FV/Ffs/$(MODULE_NAME).ffs: $(MODULE_DIR)/ff/$(MODULE_NAME).1.pe32
	GenFfs -t EFI_FV_FILETYPE_DXE_CORE \
 -g D6A2CB7F-6A18-4e2f-B43B-9920A733700A -o $@ -oi $< \
 -oi $(MODULE_DIR)/ff/$(MODULE_NAME).ui \
 -oi OVMF/FV/Ffsv/one.ver

$(MODULE_DIR)/ff/$(MODULE_NAME).1.pe32: $(MODULE_DIR)/ff/$(MODULE_NAME).efi
	GenSec -s EFI_SECTION_PE32 -o $@ $<

$(MODULE_DIR)/ff/$(MODULE_NAME).efi: $(MODULE_DIR)/ff/$(MODULE_NAME).dll
	GenFw -e UEFI_DRIVER -o $@ $< --zero

$(MODULE_DIR)/ff/$(MODULE_NAME).dll: $(MODULE_DIR)/ff/$(MODULE_NAME).lib
	gcc -o $@ \
 -nostdlib -Wl,-n,-q,--gc-sections -z common-page-size=0x40 -Wl,--entry,_ModuleEntryPoint \
 -u _ModuleEntryPoint \
 -Wl,-Map,$(MODULE_DIR)/ff/$(MODULE_NAME).map,--whole-archive \
 -Wl,-melf_x86_64,--oformat=elf64-x86-64,-pie -flto -Os \
 -Wl,--start-group,@$(MODULE_DIR)/ff/static_library_files.lst,--end-group \
 $(CC_FLAGS) \
 -Wl,--defsym=PECOFF_HEADER_SIZE=0x228 \
 -Wl,--script=BaseTools/Scripts/GccBase.lds -Wno-error
	objcopy --strip-unneeded -R .eh_frame $@
 
$(MODULE_DIR)/ff/$(MODULE_NAME).lib: \
 $(MODULE_DIR)/ff/CoreSectionExtraction.obj \
 $(MODULE_DIR)/ff/Image.obj \
 $(MODULE_DIR)/ff/DebugImageInfo.obj \
 $(MODULE_DIR)/ff/Stall.obj \
 $(MODULE_DIR)/ff/SetWatchdogTimer.obj \
 $(MODULE_DIR)/ff/InstallConfigurationTable.obj \
 $(MODULE_DIR)/ff/MemoryAttributesTable.obj \
 $(MODULE_DIR)/ff/MemoryProtection.obj \
 $(MODULE_DIR)/ff/Library.obj \
 $(MODULE_DIR)/ff/DriverSupport.obj \
 $(MODULE_DIR)/ff/Notify.obj \
 $(MODULE_DIR)/ff/Locate.obj \
 $(MODULE_DIR)/ff/Handle.obj \
 $(MODULE_DIR)/ff/Gcd.obj \
 $(MODULE_DIR)/ff/Pool.obj \
 $(MODULE_DIR)/ff/Page.obj \
 $(MODULE_DIR)/ff/MemData.obj \
 $(MODULE_DIR)/ff/MemoryProfileRecord.obj \
 $(MODULE_DIR)/ff/HeapGuard.obj \
 $(MODULE_DIR)/ff/FwVolBlock.obj \
 $(MODULE_DIR)/ff/FwVolWrite.obj \
 $(MODULE_DIR)/ff/FwVolRead.obj \
 $(MODULE_DIR)/ff/FwVolAttrib.obj \
 $(MODULE_DIR)/ff/Ffs.obj \
 $(MODULE_DIR)/ff/FwVol.obj \
 $(MODULE_DIR)/ff/Tpl.obj \
 $(MODULE_DIR)/ff/Timer.obj \
 $(MODULE_DIR)/ff/Event.obj \
 $(MODULE_DIR)/ff/Dependency.obj \
 $(MODULE_DIR)/ff/Dispatcher.obj \
 $(MODULE_DIR)/ff/DxeProtocolNotify.obj \
 $(MODULE_DIR)/ff/DxeMain.obj \
 $(MODULE_DIR)/ff/AutoGen.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/CoreSectionExtraction.obj: $(MODULE_DIR)/SectionExtraction/CoreSectionExtraction.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Image.obj: $(MODULE_DIR)/Image/Image.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/DebugImageInfo.obj: $(MODULE_DIR)/Misc/DebugImageInfo.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Stall.obj: $(MODULE_DIR)/Misc/Stall.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/SetWatchdogTimer.obj: $(MODULE_DIR)/Misc/SetWatchdogTimer.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/InstallConfigurationTable.obj: $(MODULE_DIR)/Misc/InstallConfigurationTable.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/MemoryAttributesTable.obj: $(MODULE_DIR)/Misc/MemoryAttributesTable.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -I$(MODULE_DIR)/Mem \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/MemoryProtection.obj: $(MODULE_DIR)/Misc/MemoryProtection.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Library.obj: $(MODULE_DIR)/Library/Library.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/DriverSupport.obj: $(MODULE_DIR)/Hand/DriverSupport.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Notify.obj: $(MODULE_DIR)/Hand/Notify.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -I$(MODULE_DIR)/Event \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Locate.obj: $(MODULE_DIR)/Hand/Locate.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Handle.obj: $(MODULE_DIR)/Hand/Handle.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 


$(MODULE_DIR)/ff/Gcd.obj: $(MODULE_DIR)/Gcd/Gcd.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Pool.obj: $(MODULE_DIR)/Mem/Pool.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Page.obj: $(MODULE_DIR)/Mem/Page.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/MemData.obj: $(MODULE_DIR)/Mem/MemData.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/MemoryProfileRecord.obj: $(MODULE_DIR)/Mem/MemoryProfileRecord.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/HeapGuard.obj: $(MODULE_DIR)/Mem/HeapGuard.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/FwVolBlock.obj: $(MODULE_DIR)/FwVolBlock/FwVolBlock.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/FwVolWrite.obj: $(MODULE_DIR)/FwVol/FwVolWrite.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/FwVolRead.obj: $(MODULE_DIR)/FwVol/FwVolRead.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/FwVolAttrib.obj: $(MODULE_DIR)/FwVol/FwVolAttrib.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Ffs.obj: $(MODULE_DIR)/FwVol/Ffs.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/FwVol.obj: $(MODULE_DIR)/FwVol/FwVol.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Tpl.obj: $(MODULE_DIR)/Event/Tpl.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Timer.obj: $(MODULE_DIR)/Event/Timer.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Event.obj: $(MODULE_DIR)/Event/Event.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Dependency.obj: $(MODULE_DIR)/Dispatcher/Dependency.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Dispatcher.obj: $(MODULE_DIR)/Dispatcher/Dispatcher.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/DxeProtocolNotify.obj: $(MODULE_DIR)/DxeMain/DxeProtocolNotify.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/DxeMain.obj: $(MODULE_DIR)/DxeMain/DxeMain.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/AutoGen.obj: $(MODULE_DIR)/ff/AutoGen.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) OVMF/FV/Ffs/$(MODULE_NAME).ffs
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).1.pe32 
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).lib
	$(RM) $(MODULE_DIR)/ff/*.obj
	$(RM) $(MODULE_DIR)/ff/*.deps
	$(RM) $(MODULE_DIR)/ff/*.map
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).efi
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).dll

