
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_DIR = OVMF/MdeModulePkg/Universal/Console/GraphicsConsoleDxe

INC = \
 -I$(MODULE_DIR)/ff \
 -IOVMF/OvmfPkg/Include \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) OVMF/FV/Ffs/GraphicsConsoleDxe.ffs

OVMF/FV/Ffs/GraphicsConsoleDxe.ffs: $(MODULE_DIR)/ff/GraphicsConsoleDxe.1.pe32
	GenFfs -t EFI_FV_FILETYPE_DRIVER \
 -g CCCB0C28-4B24-11d5-9A5A-0090273FC14D -o $@ -oi $< \
 -oi $(MODULE_DIR)/ff/GraphicsConsoleDxe.ui \
 -oi OVMF/FV/Ffsv/one.ver

$(MODULE_DIR)/ff/GraphicsConsoleDxe.1.pe32: $(MODULE_DIR)/ff/GraphicsConsoleDxe.efi
	GenSec -s EFI_SECTION_PE32 -o $@ $<

$(MODULE_DIR)/ff/GraphicsConsoleDxe.efi: $(MODULE_DIR)/ff/GraphicsConsoleDxe.dll
	GenFw -e UEFI_DRIVER -o $@ $< --zero

$(MODULE_DIR)/ff/GraphicsConsoleDxe.dll: $(MODULE_DIR)/ff/GraphicsConsoleDxe.lib
	gcc -o $@ \
 -nostdlib -Wl,-n,-q,--gc-sections -z common-page-size=0x40 -Wl,--entry,_ModuleEntryPoint \
 -u _ModuleEntryPoint \
 -Wl,-Map,$(MODULE_DIR)/ff/GraphicsConsoleDxe.map,--whole-archive \
 -Wl,-melf_x86_64,--oformat=elf64-x86-64,-pie -flto -Os \
 -Wl,--start-group,@$(MODULE_DIR)/ff/static_library_files.lst,--end-group \
 $(CC_FLAGS) \
 -Wl,--defsym=PECOFF_HEADER_SIZE=0x228 \
 -Wl,--script=BaseTools/Scripts/GccBase.lds -Wno-error
	objcopy --strip-unneeded -R .eh_frame $@
 
$(MODULE_DIR)/ff/GraphicsConsoleDxe.lib: \
 $(MODULE_DIR)/ff/ComponentName.obj \
 $(MODULE_DIR)/ff/LaffStd.obj \
 $(MODULE_DIR)/ff/GraphicsConsole.obj \
 $(MODULE_DIR)/ff/AutoGen.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/ComponentName.obj: $(MODULE_DIR)/ComponentName.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/LaffStd.obj: $(MODULE_DIR)/LaffStd.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/GraphicsConsole.obj: $(MODULE_DIR)/GraphicsConsole.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/AutoGen.obj: $(MODULE_DIR)/ff/AutoGen.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) OVMF/FV/Ffs/GraphicsConsoleDxe.ffs
	$(RM) $(MODULE_DIR)/ff/GraphicsConsoleDxe.1.pe32 
	$(RM) $(MODULE_DIR)/ff/GraphicsConsoleDxe.lib
	$(RM) $(MODULE_DIR)/ff/ComponentName.obj
	$(RM) $(MODULE_DIR)/ff/LaffStd.obj
	$(RM) $(MODULE_DIR)/ff/GraphicsConsole.obj
	$(RM) $(MODULE_DIR)/ff/AutoGen.obj
	$(RM) $(MODULE_DIR)/ff/GraphicsConsoleDxe.efi
	$(RM) $(MODULE_DIR)/ff/GraphicsConsoleDxe.dll
