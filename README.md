# rpi2-gentoo
*Prepare SD-Card for Raspberry Pi 2 with gentoo*

#### 1st Prepare your SD-Card, that it looks like:
```sh
/dev/sdX1 - boot (type 0x0c - vfat) - holdts the kernel image and firmware
/dev/sdX2 - root (type 0x83 - ext4) - root-filesystem (everything goes in here)
/dev/sdX3 - swap (type 0x82 - swap) - swap - (i use 2GiB for this partition)
```

#### 2nd checkout and run the scripts as root (and read the output):

```sh
$ cd /your/prefered/location
$ git clone https://github.com/aspann/rpi2-gentoo
$ cd rpi2-gentoo/gentoo-buildchain/
$ ./mount_sd.sh /dev/sdX
$ ./prepare_boot.sh
$ ./prepare_filesystem.sh
$ ./prepare_kernel.sh
$ ./mount_sd.sh /dev/sdX -u
```

#### (optional) Rebuilding/configuring your kernel:

```sh
$ cd /your/prefered/location/rpi2-gentoo/gentoo-buildchain/
$ ./mount_sd.sh /dev/sdX
$ ./prepare_kernel.sh
$ ./mount_sd.sh /dev/sdX -u
```


**That's it! :)**
