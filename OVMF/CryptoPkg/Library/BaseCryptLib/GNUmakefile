
CC_FLAGS = -g -Os -fshort-wchar -fno-builtin -fno-strict-aliasing -Wall -Werror -Wno-array-bounds \
 -include AutoGen.h -fno-common -fstack-protector -ffunction-sections -fdata-sections \
 -DSTRING_ARRAY_NAME=$(BASE_NAME)Strings -mstack-protector-guard=global -m64 \
 "-DEFIAPI=__attribute__((ms_abi))" -maccumulate-outgoing-args -mno-red-zone -Wno-address \
 -mcmodel=small -fpie -fno-asynchronous-unwind-tables -Wno-address -fno-omit-frame-pointer \
 -flto -DUSING_LTO -Wno-unused-but-set-variable -Wno-unused-const-variable -DMDEPKG_NDEBUG \
 -mno-mmx -mno-sse -D DISABLE_NEW_DEPRECATED_INTERFACES -D TDX_GUEST_SUPPORTED

DEPS_FLAGS = -MMD -MF $@.deps

MODULE_NAME = SecCryptLib
BASE_NAME = $(MODULE_NAME)
MODULE_DIR = OVMF/CryptoPkg/Library/BaseCryptLib

INC = \
 -IOVMF/CryptoPkg/Library/BaseCryptLib \
 -I$(MODULE_DIR)/ff \
 -IOVMF/MdePkg \
 -IOVMF/MdePkg/Include \
 -IOVMF/MdePkg/Include/X64 \
 -IOVMF/CryptoPkg \
 -IOVMF/CryptoPkg/Include \
 -IOVMF/CryptoPkg/Private \
 -IOVMF/CryptoPkg/Library/Include \
 -IOVMF/CryptoPkg/Library/OpensslLib/openssl/include \
 -IOVMF/CryptoPkg/Library/OpensslLib/OpensslGen/include

RM = rm -f

WORKSPACE=$(shell pwd)

all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/.) $(MODULE_DIR)/ff/$(MODULE_NAME).lib
 
$(MODULE_DIR)/ff/$(MODULE_NAME).lib: \
 $(MODULE_DIR)/ff/CryptSha512.obj \
 $(MODULE_DIR)/ff/CryptMd5Null.obj \
 $(MODULE_DIR)/ff/CryptSha1Null.obj \
 $(MODULE_DIR)/ff/CryptSha256Null.obj \
 $(MODULE_DIR)/ff/CryptSm3Null.obj \
 $(MODULE_DIR)/ff/CryptParallelHashNull.obj \
 $(MODULE_DIR)/ff/CryptHmacNull.obj \
 $(MODULE_DIR)/ff/CryptHkdfNull.obj \
 $(MODULE_DIR)/ff/CryptAesNull.obj \
 $(MODULE_DIR)/ff/CryptAeadAesGcmNull.obj \
 $(MODULE_DIR)/ff/CryptRsaBasicNull.obj \
 $(MODULE_DIR)/ff/CryptRsaExtNull.obj \
 $(MODULE_DIR)/ff/CryptPkcs1OaepNull.obj \
 $(MODULE_DIR)/ff/CryptPkcs5Pbkdf2Null.obj \
 $(MODULE_DIR)/ff/CryptPkcs7SignNull.obj \
 $(MODULE_DIR)/ff/CryptPkcs7VerifyNull.obj \
 $(MODULE_DIR)/ff/CryptPkcs7VerifyEkuNull.obj \
 $(MODULE_DIR)/ff/CryptDhNull.obj \
 $(MODULE_DIR)/ff/CryptX509Null.obj \
 $(MODULE_DIR)/ff/CryptAuthenticodeNull.obj \
 $(MODULE_DIR)/ff/CryptTsNull.obj \
 $(MODULE_DIR)/ff/CryptPemNull.obj \
 $(MODULE_DIR)/ff/CryptRandNull.obj \
 $(MODULE_DIR)/ff/CryptRsaPssNull.obj \
 $(MODULE_DIR)/ff/CryptRsaPssSignNull.obj \
 $(MODULE_DIR)/ff/CryptEcNull.obj \
 $(MODULE_DIR)/ff/CryptBnNull.obj \
 $(MODULE_DIR)/ff/CrtWrapper.obj \
 $(MODULE_DIR)/ff/ConstantTimeClock.obj \
 $(MODULE_DIR)/ff/BaseMemAllocation.obj
	rm -f $@
	gcc-ar cr $@ @$(MODULE_DIR)/ff/object_files.lst

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/SysCall/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Bn/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Pen/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Rand/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Pem/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Pk/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Cipher/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Kdf/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Hmac/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 

$(MODULE_DIR)/ff/%.obj: $(MODULE_DIR)/Hash/%.c
	gcc $(DEPS_FLAGS) $(CC_FLAGS) -c -o $@ $(INC) $< 


clean:
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).lib
	$(RM) $(MODULE_DIR)/ff/*.obj
	$(RM) $(MODULE_DIR)/ff/*.deps
	$(RM) $(MODULE_DIR)/ff/*.map
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).efi
	$(RM) $(MODULE_DIR)/ff/$(MODULE_NAME).dll
