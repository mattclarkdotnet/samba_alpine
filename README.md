# Background

These are instructions for using Alpine Linux to run an SMB server from a Raspberry Pi.  The advantage of Alpine is that is can run entirely from memory, causing no wear on any attached storage.  It is also very reproducible, as packages are installed to the ram drive on each boot, so it is very hard to mess up the config.

This example uses serial terminal access, not ssh.  To enable ssh you would change the SSHDOPTS value in answerfile.sh to `SSHDOPTS=-c openssh`

The `bootmedia.sh` script splits an SD card into a 1GB boot partition and uses the rest of the card for data storage.

# Create boot media from MacOS

You'll need to set the correct values for $VOL and $SDCARD.  You'll also need to provide a sudo password interactively so the script can run fdisk.

``` sh
export SDCARD=/dev/disk4
export VOL=/Volumes/BOOTPART
export ALPINEIMG=~/Downloads/alpine-rpi-3.18.0-armhf.tar
sh bootmedia.sh
```

# Setup alpine

Move the SD card to the RPi

Connect a USB UART to the RPi, and use minicom to connect to it. The actual USB serial device name will vary depending on your local setup and the hardware's device ID

``` sh
minicom -b 115200 -D /dev/tty.usbserial-AG0JUPBU
```

Boot the RPi, and log in as root with no password.  If you want wifi you will need to run "setup-interfaces" first to configure the wlan SSID and passphrase.  You will also need to create a root password interactively during the setup process.  

``` sh
#setup-interfaces
setup-alpine -f /media/mmcblk0p1/answerfile.sh
lbu commit
```

After setup add necessary packages and configure them to start

``` sh
sh /media/mmcblk0p1/appsetup.sh
```



