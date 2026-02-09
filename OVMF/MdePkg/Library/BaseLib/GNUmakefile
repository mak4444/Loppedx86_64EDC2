
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_NAME = BaseLib
MODULE_DIR = OVMF/MdePkg/Library/BaseLib

INC = \
 -I$(MODULE_DIR) \
 -I$(MODULE_DIR)/ff \
 -IOVMF/UefiCpuPkg/Include \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) MKDIR $(MODULE_DIR)/ff/$(MODULE_NAME).lib

MKDIR:
	mkdir -p $(MODULE_DIR)/ff/X64
 
$(MODULE_DIR)/ff/$(MODULE_NAME).lib: \
 $(MODULE_DIR)/ff/CheckSum.obj \
 $(MODULE_DIR)/ff/SwitchStack.obj \
 $(MODULE_DIR)/ff/SwapBytes64.obj \
 $(MODULE_DIR)/ff/SwapBytes32.obj \
 $(MODULE_DIR)/ff/SwapBytes16.obj \
 $(MODULE_DIR)/ff/LongJump.obj \
 $(MODULE_DIR)/ff/SetJump.obj \
 $(MODULE_DIR)/ff/QuickSort.obj \
 $(MODULE_DIR)/ff/RShiftU64.obj \
 $(MODULE_DIR)/ff/RRotU64.obj \
 $(MODULE_DIR)/ff/RRotU32.obj \
 $(MODULE_DIR)/ff/MultU64x64.obj \
 $(MODULE_DIR)/ff/MultU64x32.obj \
 $(MODULE_DIR)/ff/MultS64x64.obj \
 $(MODULE_DIR)/ff/ModU64x32.obj \
 $(MODULE_DIR)/ff/LShiftU64.obj \
 $(MODULE_DIR)/ff/LRotU64.obj \
 $(MODULE_DIR)/ff/LRotU32.obj \
 $(MODULE_DIR)/ff/LowBitSet64.obj \
 $(MODULE_DIR)/ff/LowBitSet32.obj \
 $(MODULE_DIR)/ff/HighBitSet64.obj \
 $(MODULE_DIR)/ff/HighBitSet32.obj \
 $(MODULE_DIR)/ff/GetPowerOfTwo64.obj \
 $(MODULE_DIR)/ff/GetPowerOfTwo32.obj \
 $(MODULE_DIR)/ff/DivU64x64Remainder.obj \
 $(MODULE_DIR)/ff/DivU64x32Remainder.obj \
 $(MODULE_DIR)/ff/DivU64x32.obj \
 $(MODULE_DIR)/ff/DivS64x64Remainder.obj \
 $(MODULE_DIR)/ff/ARShiftU64.obj \
 $(MODULE_DIR)/ff/BitField.obj \
 $(MODULE_DIR)/ff/CpuDeadLoop.obj \
 $(MODULE_DIR)/ff/Cpu.obj \
 $(MODULE_DIR)/ff/LinkedList.obj \
 $(MODULE_DIR)/ff/SafeString.obj \
 $(MODULE_DIR)/ff/String.obj \
 $(MODULE_DIR)/ff/FilePaths.obj \
 $(MODULE_DIR)/ff/X64/Thunk16.obj \
 $(MODULE_DIR)/ff/X64/CpuIdEx.obj \
 $(MODULE_DIR)/ff/X64/CpuId.obj \
 $(MODULE_DIR)/ff/X64/LongJump.obj \
 $(MODULE_DIR)/ff/X64/SetJump.obj \
 $(MODULE_DIR)/ff/X64/SwitchStack.obj \
 $(MODULE_DIR)/ff/X64/EnableCache.obj \
 $(MODULE_DIR)/ff/X64/DisableCache.obj \
 $(MODULE_DIR)/ff/X64/WriteTr.obj \
 $(MODULE_DIR)/ff/X64/Lfence.obj \
 $(MODULE_DIR)/ff/X64/TdCall.obj \
 $(MODULE_DIR)/ff/X64/TdVmcall.obj \
 $(MODULE_DIR)/ff/X64/TdProbe.obj \
 $(MODULE_DIR)/ff/X64/Non-existing.obj \
 $(MODULE_DIR)/ff/Math64.obj \
 $(MODULE_DIR)/ff/Unaligned.obj \
 $(MODULE_DIR)/ff/X86WriteIdtr.obj \
 $(MODULE_DIR)/ff/X86WriteGdtr.obj \
 $(MODULE_DIR)/ff/X86Thunk.obj \
 $(MODULE_DIR)/ff/X86ReadIdtr.obj \
 $(MODULE_DIR)/ff/X86ReadGdtr.obj \
 $(MODULE_DIR)/ff/X86Msr.obj \
 $(MODULE_DIR)/ff/X86GetInterruptState.obj \
 $(MODULE_DIR)/ff/X86FxSave.obj \
 $(MODULE_DIR)/ff/X86FxRestore.obj \
 $(MODULE_DIR)/ff/X86EnablePaging64.obj \
 $(MODULE_DIR)/ff/X86EnablePaging32.obj \
 $(MODULE_DIR)/ff/X86DisablePaging64.obj \
 $(MODULE_DIR)/ff/X86DisablePaging32.obj \
 $(MODULE_DIR)/ff/X86RdRand.obj \
 $(MODULE_DIR)/ff/X86PatchInstruction.obj \
 $(MODULE_DIR)/ff/X86SpeculationBarrier.obj \
 $(MODULE_DIR)/ff/X64/GccInline.obj \
 $(MODULE_DIR)/ff/X64/GccInlinePriv.obj \
 $(MODULE_DIR)/ff/X64/EnableDisableInterrupts.obj \
 $(MODULE_DIR)/ff/X64/DisablePaging64.obj \
 $(MODULE_DIR)/ff/X64/Pvalidate.obj \
 $(MODULE_DIR)/ff/X64/RdRand.obj \
 $(MODULE_DIR)/ff/X64/RmpAdjust.obj \
 $(MODULE_DIR)/ff/X64/XGetBv.obj \
 $(MODULE_DIR)/ff/X64/XSetBv.obj \
 $(MODULE_DIR)/ff/X64/VmgExit.obj \
 $(MODULE_DIR)/ff/X64/VmgExitSvsm.obj \
 $(MODULE_DIR)/ff/ChkStkGcc.obj 
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/X64/%.obj: $(MODULE_DIR)/X64/%.iii
	nasm -f elf64 -o $@ $< \
 -IOVMF/MdePkg/Include/X64

$(MODULE_DIR)/ff/TdProbe.obj: $(MODULE_DIR)/X64/TdProbe.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/Non-existing.obj: $(MODULE_DIR)/X64/Non-existing.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).lib
	$(RM) $(MODULE_DIR)/ff/X64/*.obj
	$(RM) $(MODULE_DIR)/ff/X64/*.deps
	$(RM) $(MODULE_DIR)/ff/*.obj
	$(RM) $(MODULE_DIR)/ff/*.deps
	$(RM) $(MODULE_DIR)/ff/*.map
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).efi
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).dll
