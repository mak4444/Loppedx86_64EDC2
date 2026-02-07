
RM = rm -f

WORKSPACE=$(shell pwd)


all: $(eval export PATH = $(PATH):$(WORKSPACE)/BaseTools:$(WORKSPACE)/../edk2:.) OVMF/FV/Ffs/ResetVector.ffs


OVMF/FV/Ffs/ResetVector.ffs: OVMF/OvmfPkg/ResetVector/ResetVector.1.raw
	GenFfs -t EFI_FV_FILETYPE_RAW \
 -g 1BA0062E-C779-4582-8566-336AE8F78F09 -o $@ -oi $< -n 16

OVMF/OvmfPkg/ResetVector/ResetVector.1.raw: OVMF/OvmfPkg/ResetVector/ResetVector.bin
	GenSec -s EFI_SECTION_RAW -o $@ $<

OVMF/OvmfPkg/ResetVector/ResetVector.bin:
	nasm -f bin  -IOVMF/OvmfPkg/ResetVector/ \
 -IOVMF/UefiCpuPkg/ResetVector/Vtf0/ \
 -o OVMF/OvmfPkg/ResetVector/ResetVector.bin  \
 OVMF/OvmfPkg/ResetVector/ResetVector.iii

#	OVMF/OvmfPkg/ResetVector/ResetVector.sh

clean:
	$(RM) OVMF/FV/Ffs/ResetVector.ffs
	$(RM) OVMF/OvmfPkg/ResetVector/ResetVector.1.raw
	$(RM) OVMF/OvmfPkg/ResetVector/ResetVector.bin
