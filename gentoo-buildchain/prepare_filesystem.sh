#!/bin/bash
if [[ ! -f "./mnt/stage3.tar.bz2"  ]]; then
	echo -e "fetching stage3-tarball (armv7)..."
	wget -qq -O ./mnt/stage3.tar.bz2 \
	ftp://de-mirror.org/gentoo/releases/arm/autobuilds/current-stage3-armv7a_hardfp/stage3-armv7a_hardfp-20141023.tar.bz2
fi
echo -e "unpacking stage3-tarball (this can take several minutes)..."
tar -xjf ./mnt/stage3.tar.bz2 -C ./mnt/gentoo/
rm ./mnt/stage3.tar.bz2

if [[ ! -f "./mnt/portage.tar.bz2" ]]; then
	echo -e "fetching portage tree..."
	wget -qq -O ./mnt/portage.tar.bz2 \
	http://distfiles.gentoo.org/snapshots/portage-latest.tar.bz2
fi
echo -e "unpacking portage (this can take several minutes)..."
tar -xjf ./mnt/portage.tar.bz2 -C ./mnt/gentoo/usr
rm ./mnt/portage.tar.bz2

echo -e "patching fstab..."
echo -e \
"/dev/mmcblk0p1               /boot           vfat            noauto,noatime  1 2
/dev/mmcblk0p2               /               ext4            noatime         0 1
/dev/mmcblk0p3               none            swap            sw              0 0"\
> ./mnt/gentoo/etc/fstab

echo -e "patching make.conf..."
cat ./mnt/gentoo/etc/portage/make.conf | egrep -v "CHOST|CFLAGS|#"\
> ./mnt/gentoo/etc/portage/make.conf_new
echo -e \
'CFLAGS="-O2 -pipe -march=armv7a -mfpu=vfp -mfloat-abi=hard"
CXXFLAGS="${CFLAGS}"
CHOST="armv7a-hardfloat-linux-gnueabi"' > ./mnt/gentoo/etc/portage/make.conf
cat ./mnt/gentoo/etc/portage/make.conf_new >> ./mnt/gentoo/etc/portage/make.conf
rm ./mnt/gentoo/etc/portage/make.conf_new

echo -e "setting new root-password..."
### if this does not work, do it manually
sed -i "s/root:\*/root:$(openssl passwd -1)/g" ./mnt/gentoo/etc/shadow

echo -e "done, ther rest must be configured manually.. :)\n\n"
echo -e "next is to install the crossdev-toolchain and the kernel.."
echo -e "emerge -a crossdev"
echo -e "crossdev -S -v -t armv7a-hardfloat-linux-gnueabi"
exit 0
