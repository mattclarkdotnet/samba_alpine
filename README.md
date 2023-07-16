# Background

These are instructions for using Alpine Linux to run an SMB server from a Raspberry Pi.  You may know Alpine as a minimal Linux distro for containers, but it's also rather good for Raspberry Pi.  The advantage of Alpine is that it can run entirely from memory, causing no wear on any attached storage.  It is also very reproducible, as packages are installed to the ram drive on each boot, so it is very hard to mess up the config.

I created this to make a reliable low power music server for my Sonos system at home.  The Samba settings are minimal and insecure, as Sonos requires crazy legacy SMB stuff.

This example uses serial terminal access, not ssh, as bringing up Alpine on real hardware instead of a container is tough without some kind of direct access.  It also doesn't enable ssh.  To enable ssh you would change the SSHDOPTS value in answerfile.sh to `SSHDOPTS=-c openssh`

Once you complete the steps, the data partitin wil be available at \\media.local\data, with username "media" and whatever password you set in stage 4 of setup.

## Required hardware

* Raspberry Pi 3B or later
* USB UART
* SD card

## Overview of steps

It's a four step process to get a running system:
1. Download the Alpine image for your Pi
1. The `bootmedia.sh` script splits an SD card into two partitions: a 1GB boot partition is created and the rest of the card is used for data storage.  The Alpine Linux image is then copied to the boot partition, followed by the anserfile.sh and appsetup.sh scripts.
1. Move the SD card to the Pi, power it up, and set up the base system using the answerfile.  If you want wifi this is where you will set that up too.  See https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html
1. Add packages, format the data partition and configure Samba.

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

Boot the RPi, and log in as root with no password.  You will need to create a root password interactively during the setup process.  Wired ethernet is set up using DHCP.  Wifi is not enabled by default, see https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html

``` sh
setup-alpine -f /media/mmcblk0p1/answerfile.sh
lbu commit
```

# Add packages and configure samba

After setup add necessary packages and configure them to start.  The scripts assumes the username is "media" for the SMB user.

``` sh
export MEDIAPASSWORD=yourpassword
sh /media/mmcblk0p1/appsetup.sh
```



