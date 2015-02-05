#!/bin/bash
oPath=$PWD
echo -e "getting kernel sources via git..."
if [[ ! -d "./mnt/gentoo/usr/src/linux/.git" ]]; then
	$(cd ./mnt/gentoo/usr/src && git clone -b rpi-3.18.y git://github.com/raspberrypi/linux.git)
else
	$(cd ./mnt/gentoo/usr/src/linux && git pull)
fi
echo -e "building kernel..."
cd ./mnt/gentoo/usr/src/linux
make ARCH=arm bcm2709_defconfig
make ARCH=arm CROSS_COMPILE=/usr/bin/armv7a-hardfloat-linux-gnueabi- oldconfig
make ARCH=arm CROSS_COMPILE=/usr/bin/armv7a-hardfloat-linux-gnueabi- -j8
make ARCH=arm CROSS_COMPILE=/usr/bin/armv7a-hardfloat-linux-gnueabi- modules_install INSTALL_MOD_PATH=${oPath}/mnt/gentoo/
cd $oPath
echo -e "copying image files..."
cp ./mnt/gentoo/usr/src/linux/arch/arm/boot/zImage ./mnt/gentoo/boot/kernel.img
echo -e "finish, next step is configure your boot-options, and... " \
	"hopefully start the Pi!"
exit 0