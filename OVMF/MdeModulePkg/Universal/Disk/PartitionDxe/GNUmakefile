
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_DIR = OVMF/MdeModulePkg/Universal/Disk/PartitionDxe

INC = \
 -I$(MODULE_DIR)/ff \
 -IOVMF/OvmfPkg/Include \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) OVMF/FV/Ffs/PartitionDxe.ffs

OVMF/FV/Ffs/PartitionDxe.ffs: $(MODULE_DIR)/ff/PartitionDxe.1.pe32
	GenFfs -t EFI_FV_FILETYPE_DRIVER \
 -g 1FA1F39E-FEFF-4aae-BD7B-38A070A3B609 -o $@ -oi $< \
 -oi $(MODULE_DIR)/ff/PartitionDxe.ui \
 -oi OVMF/FV/Ffsv/one.ver

$(MODULE_DIR)/ff/PartitionDxe.1.pe32: $(MODULE_DIR)/ff/PartitionDxe.efi
	GenSec -s EFI_SECTION_PE32 -o $@ $<

$(MODULE_DIR)/ff/PartitionDxe.efi: $(MODULE_DIR)/ff/PartitionDxe.dll
	GenFw -e DXE_RUNTIME_DRIVER -o $@ $< --zero

$(MODULE_DIR)/ff/PartitionDxe.dll: $(MODULE_DIR)/ff/PartitionDxe.lib
	gcc -o $@ \
 -nostdlib -Wl,-n,-q,--gc-sections -z common-page-size=0x40 -Wl,--entry,_ModuleEntryPoint \
 -u _ModuleEntryPoint \
 -Wl,-Map,$(MODULE_DIR)/ff/PartitionDxe.map,--whole-archive \
 -Wl,-melf_x86_64,--oformat=elf64-x86-64,-pie -flto -Os \
 -Wl,--start-group,@$(MODULE_DIR)/ff/static_library_files.lst,--end-group \
 $(CC_FLAGS) \
 -Wl,--defsym=PECOFF_HEADER_SIZE=0x228 \
 -Wl,--script=BaseTools/Scripts/GccBase.lds -Wno-error
	objcopy --strip-unneeded -R .eh_frame $@
 
$(MODULE_DIR)/ff/PartitionDxe.lib: \
 $(MODULE_DIR)/ff/ComponentName.obj \
 $(MODULE_DIR)/ff/Mbr.obj \
 $(MODULE_DIR)/ff/Gpt.obj \
 $(MODULE_DIR)/ff/ElTorito.obj \
 $(MODULE_DIR)/ff/Udf.obj \
 $(MODULE_DIR)/ff/Partition.obj \
 $(MODULE_DIR)/ff/AutoGen.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/ComponentName.obj: $(MODULE_DIR)/ComponentName.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Mbr.obj: $(MODULE_DIR)/Mbr.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Gpt.obj: $(MODULE_DIR)/Gpt.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/ElTorito.obj: $(MODULE_DIR)/ElTorito.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Udf.obj: $(MODULE_DIR)/Udf.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/Partition.obj: $(MODULE_DIR)/Partition.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) \
 -IOVMF/MdeModulePkg \
 -IOVMF/MdeModulePkg/Include $< 

$(MODULE_DIR)/ff/AutoGen.obj: $(MODULE_DIR)/ff/AutoGen.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) OVMF/FV/Ffs/PartitionDxe.ffs
	$(RM) $(MODULE_DIR)/ff/PartitionDxe.1.pe32 
	$(RM) $(MODULE_DIR)/ff/PartitionDxe.lib
	$(RM) $(MODULE_DIR)/ff/ComponentName.obj
	$(RM) $(MODULE_DIR)/ff/Mbr.obj
	$(RM) $(MODULE_DIR)/ff/Gpt.obj
	$(RM) $(MODULE_DIR)/ff/ElTorito.obj
	$(RM) $(MODULE_DIR)/ff/Udf.obj
	$(RM) $(MODULE_DIR)/ff/Partition.obj
	$(RM) $(MODULE_DIR)/ff/AutoGen.obj
	$(RM) $(MODULE_DIR)/ff/PartitionDxe.efi
	$(RM) $(MODULE_DIR)/ff/PartitionDxe.dll
