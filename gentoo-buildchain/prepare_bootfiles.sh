#!/bin/bash
echo -e "fetching firmware..."
if [[ ! -d ./mnt/gentoo/boot ]]; then
	echo -e "please mount sdcard."
	exit 1
fi

wget -qq -O ./mnt/gentoo/boot/start.elf \
https://github.com/raspberrypi/firmware/raw/master/boot/start.elf
wget -qq -O ./mnt/gentoo/boot/bootcode.bin \
https://github.com/raspberrypi/firmware/raw/master/boot/bootcode.bin
wget -qq -O ./mnt/gentoo/boot/fixup.dat \
https://github.com/raspberrypi/firmware/raw/master/boot/fixup.dat

echo -e "patching boot/cmdline.txt..."
echo -e "root=/dev/mmcblk0p2 rootfstype=ext4 rootdelay=2" > ./mnt/gentoo/boot/cmdline.txt

echo -e "patching boot/config.txt..."
echo -e \
'framebuffer_depth=24
boot_delay=1' > ./mnt/gentoo/boot/config.txt


echo -e "done, have a nice day! :)"
