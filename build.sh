#export ARCH="arm"
#export CROSS_COMPILE="arm-none-linux-gnueabi-"
#export PATH="/opt/arm-2009q3/bin:$PATH"
export LOCALVERSION="-SC02BOMKF2-CL271364"
export KBUILD_BUILD_VERSION="kyapaKR#17"
export INSTALL_MOD_PATH=./mod_inst

if [ ! -e ./.config ]; then
 make aries_jpn_defconfig
fi;

make modules -j`grep 'processor' /proc/cpuinfo | wc -l`
make modules_install

for i in `find ./ -name "*.ko"`; do
 cp $i ../initramfs5/lib/modules/
done

rm -rf ./mod_inst
rm -rf ./release

make -j`grep 'processor' /proc/cpuinfo | wc -l`

mkdir ./release

cp arch/arm/boot/zImage release

echo "Finished."
