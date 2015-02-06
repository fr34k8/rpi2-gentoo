#!/bin/bash
if [[ $# < 1 ]]; then
	echo -e "usage: $0 /dev/sdX [-u]\n"
	echo -e "please specify devicenode for mounting (e.g. /dev/sdX)"
	echo -e "partitiontable MUST be like this sheme:"
	echo -e "/dev/sdX1 - boot (type 0x0c - vfat)"
	echo -e "/dev/sdX2 - root (type 0x83 - ext4)"
        echo -e "/dev/sdX3 - swap (type 0x82 - swap)"
        echo -e "please try again, launching: '$0 /dev/sdX'"
	exit 1
elif [[ ${EUID} != 0 ]] ; then
	echo -e "sorry, this script must be runned as 'root', exit."
	exit 2
fi

## device (/dev/sdX)
sdcard=$1

## checking if devices exists
for i in {1..3}; do
	if [[ -z ${sdcard}$i ]]; then
		echo -e "sorry, ${sdcard}$i was not found!"
		exit $($0)       
	fi	        
done

if [[ $2 == "-u" ]]; then
        echo -e "check successfull, trying to unmount $1"
	umount ${1}*
	echo -e "unmounted device $1"
	exit 0
else
	echo -e "check successfull, trying to mount $1"
fi

## mounting devices
mkdir -p ./mnt/gentoo
mount ${1}2 ./mnt/gentoo >/dev/null 2>&1
mkdir -p ./mnt/gentoo/boot
mount ${1}1 ./mnt/gentoo/boot >/dev/null 2>&1
echo -e "ok, sdcard mounted to: ./mnt/gentoo\n"
mount | grep $1
echo -e "\nhave a nice day! :)"
exit 0
