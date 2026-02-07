
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_DIR = OVMF/OvmfPkg/SioBusDxe
INC = \
 -I$(MODULE_DIR)/ff \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) OVMF/FV/Ffs/SioBusDxe.ffs

OVMF/FV/Ffs/SioBusDxe.ffs: $(MODULE_DIR)/ff/SioBusDxe.1.pe32
	GenFfs -t EFI_FV_FILETYPE_DRIVER \
 -g 864E1CA8-85EB-4D63-9DCC-6E0FC90FFD55 -o $@ -oi $< \
 -oi OVMF/OvmfPkg/SioBusDxe/ff/SioBusDxe.ui \
 -oi OVMF/FV/Ffsv/one.ver

$(MODULE_DIR)/ff/SioBusDxe.1.pe32: $(MODULE_DIR)/ff/SioBusDxe.efi
	GenSec -s EFI_SECTION_PE32 -o $@ $<

$(MODULE_DIR)/ff/SioBusDxe.efi: $(MODULE_DIR)/ff/SioBusDxe.dll
	GenFw -e DXE_DRIVER -o $@ $< --zero

#	cp $< OVMF/x0x1x2x3x4x5x6x7x8x9x0x/x0x1x2x3x4x5x6x7x8x9x0x/x0x1x2x3x4x5x6x7x8x9x0x/Metronome.dll
#	GenFw -e DXE_DRIVER -o $@ \
#	OVMF/x0x1x2x3x4x5x6x7x8x9x0x/x0x1x2x3x4x5x6x7x8x9x0x/x0x1x2x3x4x5x6x7x8x9x0x/Metronome.dll  --zero
#	GenFw -e DXE_DRIVER -o $@ $< --zero


$(MODULE_DIR)/ff/SioBusDxe.dll: $(MODULE_DIR)/ff/SioBusDxe.lib
	gcc -o $@ \
 -nostdlib -Wl,-n,-q,--gc-sections -z common-page-size=0x40 -Wl,--entry,_ModuleEntryPoint \
 -u _ModuleEntryPoint \
 -Wl,-Map,$(MODULE_DIR)/ff/SioBusDxe.map,--whole-archive \
 -Wl,-melf_x86_64,--oformat=elf64-x86-64,-pie -flto -Os \
 -Wl,--start-group,@$(MODULE_DIR)/ff/static_library_files.lst,--end-group \
 $(CC_FLAGS) \
 -Wl,--defsym=PECOFF_HEADER_SIZE=0x228 \
 -Wl,--script=BaseTools/Scripts/GccBase.lds -Wno-error
	objcopy --strip-unneeded -R .eh_frame $@
 
$(MODULE_DIR)/ff/SioBusDxe.lib: \
 $(MODULE_DIR)/ff/ComponentName.obj \
 $(MODULE_DIR)/ff/SioService.obj \
 $(MODULE_DIR)/ff/SioBusDxe.obj \
 $(MODULE_DIR)/ff/AutoGen.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/ComponentName.obj: $(MODULE_DIR)/ComponentName.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 


$(MODULE_DIR)/ff/SioService.obj: $(MODULE_DIR)/SioService.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/SioBusDxe.obj: $(MODULE_DIR)/SioBusDxe.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 


$(MODULE_DIR)/ff/AutoGen.obj: $(MODULE_DIR)/ff/AutoGen.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) OVMF/FV/Ffs/SioBusDxe.ffs
	$(RM) $(MODULE_DIR)/ff/SioBusDxe.1.pe32 
	$(RM) $(MODULE_DIR)/ff/SioBusDxe.lib
	$(RM) $(MODULE_DIR)/ff/ComponentName.obj
	$(RM) $(MODULE_DIR)/ff/SioService.obj
	$(RM) $(MODULE_DIR)/ff/SioBusDxe.obj
	$(RM) $(MODULE_DIR)/ff/AutoGen.obj
	$(RM) $(MODULE_DIR)/ff/SioBusDxe.efi
	$(RM) $(MODULE_DIR)/ff/SioBusDxe.dll
