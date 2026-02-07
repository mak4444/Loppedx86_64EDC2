

tmp0="/home/max/work/os/OVMF/edk2/Build/OvmfX64/RELEASE_GCC5/X64/MdePkg/Library/PeiPcdLib/PeiPcdLib/OUTPUT/PeiPcdLib.lib"
tmp1="OVMF/MdePkg/Library/PeiPcdLib/ff/PeiPcdLib.lib"
find ./ -name \*.lst -exec sed -i "s#$tmp0#$tmp1#"  {} \;

tmp0="/home/max/work/os/OVMF/edk2/Build/OvmfX64/RELEASE_GCC5/X64/MdePkg/Library/PeimEntryPoint/PeimEntryPoint/OUTPUT/PeimEntryPoint.lib"
tmp1="OVMF/MdePkg/Library/PeimEntryPoint/ff/PeimEntryPoint.lib"
find ./ -name \*.lst -exec sed -i "s#$tmp0#$tmp1#"  {} \;

