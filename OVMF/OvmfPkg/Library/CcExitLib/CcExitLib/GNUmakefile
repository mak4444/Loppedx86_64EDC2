
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_NAME = CcExitLib
MODULE_DIR = OVMF/OvmfPkg/Library/CcExitLib

INC = \
 -I$(MODULE_DIR)/CcExitLib \
 -IOVMF/OvmfPkg/Include \
 -IOVMF/UefiCpuPkg/Include \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) $(MODULE_DIR)/CcExitLib/$(MODULE_NAME).lib
 
$(MODULE_DIR)/CcExitLib/$(MODULE_NAME).lib: \
 $(MODULE_DIR)/CcExitLib/CcExitLib.obj \
 $(MODULE_DIR)/CcExitLib/CcExitVcHandler.obj \
 $(MODULE_DIR)/CcExitLib/CcInstruction.obj \
 $(MODULE_DIR)/CcExitLib/PeiDxeCcExitVcHandler.obj \
 $(MODULE_DIR)/CcExitLib/CcExitVeHandler.obj \
 $(MODULE_DIR)/CcExitLib/TdVmcallCpuid.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/CcExitLib/object_files.lst

$(MODULE_DIR)/CcExitLib/%.obj: $(MODULE_DIR)/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/CcExitLib/%.obj: $(MODULE_DIR)/X64/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/CcExitLib/%.obj: $(MODULE_DIR)/X64/%.iii
	nasm -f elf64 -o $@ $<


clean:
	$(RM) $(MODULE_DIR)/CcExitLib/*.lib
	$(RM) $(MODULE_DIR)/CcExitLib/*.obj
	$(RM) $(MODULE_DIR)/CcExitLib/*.deps
	$(RM) $(MODULE_DIR)/CcExitLib/*.map
	$(RM) $(MODULE_DIR)/CcExitLib/*.efi
	$(RM) $(MODULE_DIR)/CcExitLib/*.dll
