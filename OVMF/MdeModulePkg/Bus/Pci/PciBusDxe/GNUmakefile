
MODULE_NAME = PciBusDxe
BASE_NAME = $(MODULE_NAME)

MODULE_DIR = OVMF/MdeModulePkg/Bus/Pci/PciBusDxe

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
	GenFfs -t EFI_FV_FILETYPE_DRIVER \
 -g 93B80004-9FB3-11d4-9A3A-0090273FC14D -o $@ -oi $< \
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
 $(MODULE_DIR)/ff/PciLib.obj \
 $(MODULE_DIR)/ff/PciIo.obj \
 $(MODULE_DIR)/ff/PciBus.obj \
 $(MODULE_DIR)/ff/PciDeviceSupport.obj \
 $(MODULE_DIR)/ff/ComponentName.obj \
 $(MODULE_DIR)/ff/PciCommand.obj \
 $(MODULE_DIR)/ff/PciResourceSupport.obj \
 $(MODULE_DIR)/ff/PciEnumeratorSupport.obj \
 $(MODULE_DIR)/ff/PciEnumerator.obj \
 $(MODULE_DIR)/ff/PciOptionRomSupport.obj \
 $(MODULE_DIR)/ff/PciDriverOverride.obj \
 $(MODULE_DIR)/ff/PciPowerManagement.obj \
 $(MODULE_DIR)/ff/PciRomTable.obj \
 $(MODULE_DIR)/ff/PciHotPlugSupport.obj \
 $(MODULE_DIR)/ff/AutoGen.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/PciLib.obj: $(MODULE_DIR)/PciLib.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciIo.obj: $(MODULE_DIR)/PciIo.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciBus.obj: $(MODULE_DIR)/PciBus.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciDeviceSupport.obj: $(MODULE_DIR)/PciDeviceSupport.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/ComponentName.obj: $(MODULE_DIR)/ComponentName.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciCommand.obj: $(MODULE_DIR)/PciCommand.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciResourceSupport.obj: $(MODULE_DIR)/PciResourceSupport.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciEnumeratorSupport.obj: $(MODULE_DIR)/PciEnumeratorSupport.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciEnumerator.obj: $(MODULE_DIR)/PciEnumerator.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciOptionRomSupport.obj: $(MODULE_DIR)/PciOptionRomSupport.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciDriverOverride.obj: $(MODULE_DIR)/PciDriverOverride.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciPowerManagement.obj: $(MODULE_DIR)/PciPowerManagement.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciRomTable.obj: $(MODULE_DIR)/PciRomTable.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PciHotPlugSupport.obj: $(MODULE_DIR)/PciHotPlugSupport.c
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

