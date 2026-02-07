
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_NAME = QemuFwCfgPeiLib
MODULE_DIR = OVMF/OvmfPkg/Library/QemuFwCfgLib

INC = \
 -I$(MODULE_DIR)/QemuFwCfgPeiLib \
 -IOVMF/OvmfPkg/Include \
 -IOVMF/MdeModulePkg/Include \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) $(MODULE_DIR)/QemuFwCfgPeiLib/$(MODULE_NAME).lib
 
$(MODULE_DIR)/QemuFwCfgPeiLib/$(MODULE_NAME).lib: \
 $(MODULE_DIR)/QemuFwCfgPeiLib/QemuFwCfgLib.obj \
 $(MODULE_DIR)/QemuFwCfgPeiLib/QemuFwCfgPei.obj \
 $(MODULE_DIR)/QemuFwCfgPeiLib/QemuFwCfgCache.obj \
 $(MODULE_DIR)/QemuFwCfgPeiLib/QemuFwCfgCacheInit.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/QemuFwCfgPeiLib/object_files.lst

$(MODULE_DIR)/QemuFwCfgPeiLib/%.obj: $(MODULE_DIR)/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

clean:
	$(RM) $(MODULE_DIR)/QemuFwCfgPeiLib/*.lib
	$(RM) $(MODULE_DIR)/QemuFwCfgPeiLib/*.obj
	$(RM) $(MODULE_DIR)/QemuFwCfgPeiLib/*.deps
	$(RM) $(MODULE_DIR)/QemuFwCfgPeiLib/*.map
	$(RM) $(MODULE_DIR)/QemuFwCfgPeiLib/*.efi
	$(RM) $(MODULE_DIR)/QemuFwCfgPeiLib/*.dll
