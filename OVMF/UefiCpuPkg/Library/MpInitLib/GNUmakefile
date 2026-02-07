
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_NAME = DxeMpInitLib
MODULE_DIR = OVMF/UefiCpuPkg/Library/MpInitLib

INC = \
 -I$(MODULE_DIR)/X64 \
 -I$(MODULE_DIR)/ff \
 -I$(MODULE_DIR) \
 -IOVMF/MdePkg \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64 \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include \
 -IOVMF/UefiCpuPkg -IOVMF/UefiCpuPkg/Include

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) $(MODULE_DIR)/ff/$(MODULE_NAME).lib
 
$(MODULE_DIR)/ff/$(MODULE_NAME).lib: \
 $(MODULE_DIR)/ff/AmdSevX.obj \
 $(MODULE_DIR)/ff/CreatePageTable.obj \
 $(MODULE_DIR)/ff/MpFuncs.obj \
 $(MODULE_DIR)/ff/AmdSev.obj \
 $(MODULE_DIR)/ff/DxeMpLib.obj \
 $(MODULE_DIR)/ff/Microcode.obj \
 $(MODULE_DIR)/ff/MpLib.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/X64/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/X64/%.iii
	nasm  -I$(MODULE_DIR) -I$(MODULE_DIR)/X64 -IOVMF/MdePkg/Include/X64 -f elf64 -o $@ $<


clean:
	$(RM) $(MODULE_DIR)/ff/*.lib
	$(RM) $(MODULE_DIR)/ff/*.obj
	$(RM) $(MODULE_DIR)/ff/*.deps
	$(RM) $(MODULE_DIR)/ff/*.map
	$(RM) $(MODULE_DIR)/ff/*.efi
	$(RM) $(MODULE_DIR)/ff/*.dll
