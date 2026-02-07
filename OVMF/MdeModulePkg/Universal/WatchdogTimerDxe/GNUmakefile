
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_DIR = OVMF/MdeModulePkg/Universal/WatchdogTimerDxe
INC = \
 -I$(MODULE_DIR) \
 -I$(MODULE_DIR)/WatchdogTimer \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/:.) OVMF/FV/Ffs/WatchdogTimer.ffs

OVMF/FV/Ffs/WatchdogTimer.ffs: $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.1.pe32
	GenFfs -t EFI_FV_FILETYPE_DRIVER \
 -g F099D67F-71AE-4c36-B2A3-DCEB0EB2B7D8 -o $@ \
 -oi $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.1.dpx -oi $< \
 -oi $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.ui \
 -oi OVMF/FV/Ffsv/one.ver

#F099D67F-71AE-4c36-B2A3-DCEB0EB2B7D8SEC2.1.pe32
$(MODULE_DIR)/WatchdogTimer/WatchdogTimer.1.pe32: $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.efi
	GenSec -s EFI_SECTION_PE32 -o $@ $<

$(MODULE_DIR)/WatchdogTimer/WatchdogTimer.efi: $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.dll
	GenFw -e DXE_DRIVER -o $@ $< --zero

$(MODULE_DIR)/WatchdogTimer/WatchdogTimer.dll: $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.lib
	gcc -o $@ \
 -nostdlib -Wl,-n,-q,--gc-sections -z common-page-size=0x40 -Wl,--entry,_ModuleEntryPoint \
 -u _ModuleEntryPoint \
 -Wl,-Map,$(MODULE_DIR)/WatchdogTimer/WatchdogTimer.map,--whole-archive \
 -Wl,-melf_x86_64,--oformat=elf64-x86-64,-pie -flto -Os \
 -Wl,--start-group,@$(MODULE_DIR)/WatchdogTimer/static_library_files.lst,--end-group \
 -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 $(CC_FLAGS) \
 -Wl,--defsym=PECOFF_HEADER_SIZE=0x228 \
 -Wl,--script=BaseTools/Scripts/GccBase.lds -Wno-error
	objcopy --strip-unneeded -R .eh_frame $@

$(MODULE_DIR)/WatchdogTimer/WatchdogTimer.lib: \
 $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.obj \
 $(MODULE_DIR)/WatchdogTimer/AutoGen.obj
	rm -f $@
	gcc-ar cr $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.lib \
 @$(MODULE_DIR)/WatchdogTimer/object_files.lst

$(MODULE_DIR)/WatchdogTimer/WatchdogTimer.obj: $(MODULE_DIR)/WatchdogTimer.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/WatchdogTimer/AutoGen.obj: $(MODULE_DIR)/WatchdogTimer/AutoGen.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) OVMF/FV/Ffs/WatchdogTimer.ffs
	$(RM) $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.1.pe32
	$(RM) $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.efi
	$(RM) $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.dll
	$(RM) $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.lib
	$(RM) $(MODULE_DIR)/WatchdogTimer/WatchdogTimer.obj
	$(RM) $(MODULE_DIR)/WatchdogTimer/AutoGen.obj
