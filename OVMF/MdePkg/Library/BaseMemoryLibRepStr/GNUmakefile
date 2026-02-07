
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_NAME = BaseMemoryLibRepStr
MODULE_DIR = OVMF/MdePkg/Library/BaseMemoryLibRepStr

INC = \
 -I$(MODULE_DIR)/ff \
 -IOVMF/UefiCpuPkg/Include \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) $(MODULE_DIR)/ff/$(MODULE_NAME).lib
 
$(MODULE_DIR)/ff/$(MODULE_NAME).lib: \
 $(MODULE_DIR)/ff/ScanMem64Wrapper.obj \
 $(MODULE_DIR)/ff/ScanMem32Wrapper.obj \
 $(MODULE_DIR)/ff/ScanMem16Wrapper.obj \
 $(MODULE_DIR)/ff/ScanMem8Wrapper.obj \
 $(MODULE_DIR)/ff/ZeroMemWrapper.obj \
 $(MODULE_DIR)/ff/CompareMemWrapper.obj \
 $(MODULE_DIR)/ff/SetMemNWrapper.obj \
 $(MODULE_DIR)/ff/SetMem64Wrapper.obj \
 $(MODULE_DIR)/ff/SetMem32Wrapper.obj \
 $(MODULE_DIR)/ff/SetMem16Wrapper.obj \
 $(MODULE_DIR)/ff/SetMemWrapper.obj \
 $(MODULE_DIR)/ff/CopyMemWrapper.obj \
 $(MODULE_DIR)/ff/IsZeroBufferWrapper.obj \
 $(MODULE_DIR)/ff/MemLibGuid.obj \
 $(MODULE_DIR)/ff/ScanMem64.obj \
 $(MODULE_DIR)/ff/ScanMem32.obj \
 $(MODULE_DIR)/ff/ScanMem16.obj \
 $(MODULE_DIR)/ff/ScanMem8.obj \
 $(MODULE_DIR)/ff/CompareMem.obj \
 $(MODULE_DIR)/ff/ZeroMem.obj \
 $(MODULE_DIR)/ff/SetMem64.obj \
 $(MODULE_DIR)/ff/SetMem32.obj \
 $(MODULE_DIR)/ff/SetMem16.obj \
 $(MODULE_DIR)/ff/SetMem.obj \
 $(MODULE_DIR)/ff/CopyMem.obj \
 $(MODULE_DIR)/ff/IsZeroBuffer.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/ScanMem64Wrapper.obj: $(MODULE_DIR)/ScanMem64Wrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/ScanMem32Wrapper.obj: $(MODULE_DIR)/ScanMem32Wrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/ScanMem16Wrapper.obj: $(MODULE_DIR)/ScanMem16Wrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/ScanMem8Wrapper.obj: $(MODULE_DIR)/ScanMem8Wrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/ZeroMemWrapper.obj: $(MODULE_DIR)/ZeroMemWrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/CompareMemWrapper.obj: $(MODULE_DIR)/CompareMemWrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/SetMemNWrapper.obj: $(MODULE_DIR)/SetMemNWrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/SetMem64Wrapper.obj: $(MODULE_DIR)/SetMem64Wrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/SetMem32Wrapper.obj: $(MODULE_DIR)/SetMem32Wrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/SetMem16Wrapper.obj: $(MODULE_DIR)/SetMem16Wrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/SetMemWrapper.obj: $(MODULE_DIR)/SetMemWrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/CopyMemWrapper.obj: $(MODULE_DIR)/CopyMemWrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/IsZeroBufferWrapper.obj: $(MODULE_DIR)/IsZeroBufferWrapper.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/MemLibGuid.obj: $(MODULE_DIR)/MemLibGuid.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/ScanMem64.obj: $(MODULE_DIR)/X64/ScanMem64.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/ScanMem32.obj: $(MODULE_DIR)/X64/ScanMem32.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/ScanMem16.obj: $(MODULE_DIR)/X64/ScanMem16.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/ScanMem8.obj: $(MODULE_DIR)/X64/ScanMem8.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/CompareMem.obj: $(MODULE_DIR)/X64/CompareMem.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/ZeroMem.obj: $(MODULE_DIR)/X64/ZeroMem.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/SetMem64.obj: $(MODULE_DIR)/X64/SetMem64.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/SetMem32.obj: $(MODULE_DIR)/X64/SetMem32.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/SetMem16.obj: $(MODULE_DIR)/X64/SetMem16.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/SetMem.obj: $(MODULE_DIR)/X64/SetMem.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/CopyMem.obj: $(MODULE_DIR)/X64/CopyMem.iii
	nasm -f elf64 -o $@ $<

$(MODULE_DIR)/ff/IsZeroBuffer.obj: $(MODULE_DIR)/X64/IsZeroBuffer.iii
	nasm -f elf64 -o $@ $<

clean:
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).lib
	$(RM) $(MODULE_DIR)/ff/*.obj
	$(RM) $(MODULE_DIR)/ff/*.deps
	$(RM) $(MODULE_DIR)/ff/*.map
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).efi
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).dll
