
MODULE_NAME = PlatformDxe
BASE_NAME = $(MODULE_NAME)

MODULE_DIR = OVMF/OvmfPkg/PlatformDxe

CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps


INC = \
 -I$(MODULE_DIR)/ff \
 -IOVMF/OvmfPkg/Include \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) OVMF/FV/Ffs/$(MODULE_NAME).ffs

OVMF/FV/Ffs/$(MODULE_NAME).ffs: $(MODULE_DIR)/ff/$(MODULE_NAME).1.pe32
	GenFfs -t EFI_FV_FILETYPE_DRIVER \
 -g D9DCC5DF-4007-435E-9098-8970935504B2 -o $@ -oi $< \
 -oi OVMF/FV/Ffsv/one.ver

# -oi $(MODULE_DIR)/ff/$(MODULE_NAME).1.dpx \
# -oi $(MODULE_DIR)/ff/$(MODULE_NAME).ui \
# -oi $(MODULE_DIR)/ff/$(MODULE_NAME).raw -oi $< \


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
 $(MODULE_DIR)/ff/PlatformConfig.obj \
 $(MODULE_DIR)/ff/PlatformForms.obj \
 $(MODULE_DIR)/ff/Platform.obj \
 $(MODULE_DIR)/ff/AutoGen.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/PlatformConfig.obj: $(MODULE_DIR)/PlatformConfig.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/PlatformForms.obj: $(MODULE_DIR)/ff/PlatformForms.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Platform.obj: $(MODULE_DIR)/Platform.c
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
