# Background

These are instructions for using Alpine Linux to run an SMB server from a Raspberry Pi.  The advantage of Alpine is that is can run entirely from memory, causing no wear on any attached storage.  It is also very reproducible, as packages are installed to the ram drive on each boot, so it is very hard to mess up the config.

This example uses serial terminal access, not ssh.  To enable ssh you would change the SSHDOPTS value in answerfile.sh to `SSHDOPTS=-c openssh`

The Samba settings are minimal and insecure, as these are used by me to run a media server for my Sonos audio players, which require crazy SMB settings!

## Required hardware

* Raspberry Pi 3B or later
* USB UART
* SD card

## Overview of steps

It's a four step process to get a running system:
1. Download the Alpine image for your Pi
1. The `bootmedia.sh` script splits an SD card into two partitions: a 1GB boot partition is created and the rest of the card is used for data storage.  The Alpine Linux image is then copied to the boot partition, followed by the anserfile.sh and appsetup.sh scripts.
1. Move the SD card to the Pi, power it up, and set up the base system using the answerfile.  If you want wifi this is where you will set that up too.
1. Add packages and configure Samba.  

# Download a suitable Alpine image for your Raspberry Pi

See https://alpinelinux.org/downloads/, and if you are not sure then use the armhf image

# Create boot media from MacOS

You'll need to set the correct values for $VOL and $SDCARD.  You'll also need to provide a sudo password interactively so the script can run fdisk.

``` sh
export SDCARD=/dev/disk4
export VOL=/Volumes/BOOTPART
export ALPINEIMG=~/Downloads/alpine-rpi-3.18.0-armhf.tar
sh bootmedia.sh
```

# Setup alpine base system

Move the SD card to the Pi

Connect a USB UART to the Pi, and use minicom to connect to it. The actual USB serial device name will vary depending on your local setup and the hardware's device ID

``` sh
minicom -b 115200 -D /dev/tty.usbserial-AG0JUPBU
```

Boot the RPi, and log in as root with no password.  If you want wifi you will need to run "setup-interfaces" first to configure the wlan SSID and passphrase.  You will also need to create a root password interactively during the setup process.  

``` sh
#setup-interfaces
setup-alpine -f /media/mmcblk0p1/answerfile.sh
lbu commit
```

# Add packages and configure samba

After setup add necessary packages and configure them to start.  The scripts assumes the username is "media" for the SMB user.

``` sh
export MEDIAPASSWORD=yourpassword
sh /media/mmcblk0p1/appsetup.sh
```



