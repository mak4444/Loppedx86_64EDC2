
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_DIR = OVMF/MdeModulePkg/Universal/SecurityStubDxe
INC =  \
 -I$(MODULE_DIR) \
 -I$(MODULE_DIR)/SecurityStubDxe \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64 

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/../.) OVMF/FV/Ffs/SecurityStubDxe.ffs

OVMF/FV/Ffs/SecurityStubDxe.ffs: $(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.1.pe32
	GenFfs -t EFI_FV_FILETYPE_DRIVER \
 -g F80697E9-7FD6-4665-8646-88E33EF71DFC -o $@ \
 -oi $(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.1.dpx -oi $< \
 -oi $(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.ui \
 -oi OVMF/FV/Ffsv/one.ver

$(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.1.pe32: $(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.efi
	GenSec -s EFI_SECTION_PE32 -o $@ $<

$(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.efi: $(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.dll
	GenFw -e DXE_DRIVER -o $@ $< --zero

$(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.dll: $(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.lib
	gcc -o $@ \
 -nostdlib -Wl,-n,-q,--gc-sections -z common-page-size=0x40 -Wl,--entry,_ModuleEntryPoint \
 -u _ModuleEntryPoint \
 -Wl,-Map,$(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.map,--whole-archive \
 -Wl,-melf_x86_64,--oformat=elf64-x86-64,-pie -flto -Os \
 -Wl,--start-group,@$(MODULE_DIR)/SecurityStubDxe/static_library_files.lst,--end-group \
 $(CC_FLAGS) \
 -Wl,--defsym=PECOFF_HEADER_SIZE=0x228 \
 -Wl,--script=BaseTools/Scripts/GccBase.lds -Wno-error
	objcopy --strip-unneeded -R .eh_frame $@
 
$(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.lib: \
 $(MODULE_DIR)/SecurityStubDxe/SecurityStub.obj \
 $(MODULE_DIR)/SecurityStubDxe/Defer3rdPartyImageLoad.obj \
 $(MODULE_DIR)/SecurityStubDxe/AutoGen.obj
	rm -f $@
	gcc-ar cr $(MODULE_DIR)/SecurityStubDxe/SecurityStubDxe.lib \
 @$(MODULE_DIR)/SecurityStubDxe/object_files.lst

$(MODULE_DIR)/SecurityStubDxe/SecurityStub.obj: $(MODULE_DIR)/SecurityStub.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/SecurityStubDxe/Defer3rdPartyImageLoad.obj: $(MODULE_DIR)/Defer3rdPartyImageLoad.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/SecurityStubDxe/AutoGen.obj: $(MODULE_DIR)/SecurityStubDxe/AutoGen.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) OVMF/FV/SecurityStubDxes/SecurityStubDxe.SecurityStubDxes
	$(RM) OVMF/FV/Ffs/SecurityStubDxe.ffs
	$(RM) $(MODULE_DIR)/SecurityStubDxe/*.1.pe32 
	$(RM) $(MODULE_DIR)/SecurityStubDxe/*.lib
	$(RM) $(MODULE_DIR)/SecurityStubDxe/*.obj
	$(RM) $(MODULE_DIR)/SecurityStubDxe/*.deps
	$(RM) $(MODULE_DIR)/SecurityStubDxe/*.map
	$(RM) $(MODULE_DIR)/SecurityStubDxe/*.efi
	$(RM) $(MODULE_DIR)/SecurityStubDxe/*.dll
