CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=SecMainStrings -mstack-protector-guard=global  -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args \
 -mno-red-zone -Wno-address -mcmodel=small -fpie -fno-asynchronous-unwind-tables \
 -Wno-address -fno-omit-frame-pointer -flto -DUSING_LTO -Wno-unused-but-set-variable \
 -Wno-unused-const-variable -DMDEPKG_NDEBUG -mno-mmx -mno-sse \
 -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED 

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_DIR = OVMF/OvmfPkg/Sec

INC =  \
 -IOVMF/OvmfPkg/Sec/SecMain \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64 \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include \
 -IOVMF/UefiCpuPkg \
 -IOVMF/UefiCpuPkg/Include \
 -IOVMF/OvmfPkg \
 -IOVMF/OvmfPkg/Include

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE):.) OVMF/FV/Ffs/SecMain.ffs


OVMF/FV/Ffs/SecMain.ffs: $(MODULE_DIR)/SecMain/SecMain.1.pe32
	GenFfs -t EFI_FV_FILETYPE_SECURITY_CORE \
 -g df1ccef6-f301-4a63-9661-fc6030dcc880 -o $@ \
 -oi $(MODULE_DIR)/SecMain/SecMain.1.pe32 \
 -oi $(MODULE_DIR)/SecMain/SecMain.ui \
 -oi OVMF/FV/Ffsv/one.ver

$(MODULE_DIR)/SecMain/SecMain.1.pe32: $(MODULE_DIR)/SecMain/SecMain.efi
	GenSec -s EFI_SECTION_PE32 -o $@ $<

$(MODULE_DIR)/SecMain/SecMain.efi: $(MODULE_DIR)/SecMain/SecMain.dll
	GenFw -e SEC -o $@ $< --zero

$(MODULE_DIR)/SecMain/SecMain.dll: $(MODULE_DIR)/SecMain/SecMain.lib
	gcc -o $@ \
 -nostdlib -Wl,-n,-q,--gc-sections -z common-page-size=0x40 -Wl,--entry,_ModuleEntryPoint \
 -u _ModuleEntryPoint \
 -Wl,-Map,$(MODULE_DIR)/SecMain/SecurityStubDxe.map,--whole-archive \
 -Wl,-melf_x86_64,--oformat=elf64-x86-64,-pie -flto -Os \
 -Wl,--start-group,@$(MODULE_DIR)/SecMain/static_library_files.lst,--end-group \
 $(CC_FLAGS) \
 -Wl,--defsym=PECOFF_HEADER_SIZE=0x228 \
 -Wl,--script=BaseTools/Scripts/GccBase.lds -Wno-error

$(MODULE_DIR)/SecMain/SecMain.lib: \
 $(MODULE_DIR)/SecMain/SecMain.obj \
 $(MODULE_DIR)/SecMain/AmdSev.obj \
 $(MODULE_DIR)/SecMain/x64/SecEntry.obj \
 $(MODULE_DIR)/SecMain/AutoGen.obj
	rm -f OVMF/OvmfPkg/Sec/SecMain/SecMain.lib 
	gcc-ar cr OVMF/OvmfPkg/Sec/SecMain/SecMain.lib \
 @OVMF/OvmfPkg/Sec/SecMain/object_files.lst

$(MODULE_DIR)/SecMain/SecMain.obj: $(MODULE_DIR)/SecMain.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $<

$(MODULE_DIR)/SecMain/AmdSev.obj: $(MODULE_DIR)/AmdSev.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $<

$(MODULE_DIR)/SecMain/x64/SecEntry.obj: $(MODULE_DIR)/SecMain/x64/SecEntry.iii
	nasm \
 -IOVMF/OvmfPkg/Sec/X64 \
 -IOVMF/OvmfPkg/Include/ -f elf64 -o $@ $<

$(MODULE_DIR)/SecMain/AutoGen.obj: $(MODULE_DIR)/SecMain/AutoGen.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $<

clean:
	$(RM) OVMF/FV/Ffs/SecMain.ffs
	$(RM) $(MODULE_DIR)/SecMain/SecMain.1.pe32
	$(RM) $(MODULE_DIR)/SecMain/SecMain.efi
	$(RM) $(MODULE_DIR)/SecMain/SecMain.dll
	$(RM) $(MODULE_DIR)/SecMain/SecMain.lib
	$(RM) $(MODULE_DIR)/SecMain/*.obj
	$(RM) $(MODULE_DIR)/SecMain/*.deps
	$(RM) $(MODULE_DIR)/SecMain/*.map

