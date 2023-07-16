#!/bin/sh

echo "Unmounting media and partitioning"
diskutil unmountDisk $SDCARD
diskutil partitionDisk $SDCARD MBR FAT32 BOOTPART 1G FAT32 DATAPART R
diskutil unmountDisk $SDCARD
echo "f 1
w
q
" | sudo fdisk -e $SDCARD
diskutil mountDisk $SDCARD
echo "Copying boot files"
tar xf $ALPINEIMG -C $VOL
echo "modules=loop,squashfs,sd-mod,usb-storage console=serial0,115200" > $VOL/cmdline.txt
echo "enable_uart=1" > $VOL/usercfg.txt
cp ./answerfile.sh $VOL/answerfile.sh
cp ./appsetup.sh $VOL/appsetup.sh
echo "Syncing and waiting 10 seconds before unmounting"
sync
sleep 10
diskutil unmountDisk $SDCARD
echo "Done"