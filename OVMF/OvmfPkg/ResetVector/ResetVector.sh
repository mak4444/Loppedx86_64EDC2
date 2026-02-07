
nasm -l OVMF/OvmfPkg/ResetVector/ResetVector.lst \
 -f bin  -IOVMF/OvmfPkg/ResetVector/ \
 -IOVMF/UefiCpuPkg/ResetVector/Vtf0/ \
 -o OVMF/OvmfPkg/ResetVector/ResetVector.bin  \
 OVMF/OvmfPkg/ResetVector/ResetVector.iii

