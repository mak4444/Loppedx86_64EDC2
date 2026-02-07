
CC_FLAGS = \
 -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_NAME = PeiQemuFwCfgS3LibFwCfg
MODULE_DIR = OVMF/OvmfPkg/Library/QemuFwCfgS3Lib

INC = \
 -IOVMF/OvmfPkg/Library/QemuFwCfgS3Lib \
 -I$(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64 \
 -IOVMF/OvmfPkg/Include

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/$(MODULE_NAME).lib
 
$(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/$(MODULE_NAME).lib: \
 $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/QemuFwCfgS3BasePei.obj \
 $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/QemuFwCfgS3Pei.obj \
 $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/QemuFwCfgS3PeiDxe.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/object_files.lst

$(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/%.obj: $(MODULE_DIR)/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/*.lib
	$(RM) $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/*.obj
	$(RM) $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/*.deps
	$(RM) $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/*.map
	$(RM) $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/*.efi
	$(RM) $(MODULE_DIR)/PeiQemuFwCfgS3LibFwCfg/*.dll
