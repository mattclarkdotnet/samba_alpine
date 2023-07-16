# Example answer file for setup-alpine script
# If you don't want to use a certain option, then comment it out

# Use US layout with US variant
# KEYMAPOPTS="us us"
KEYMAPOPTS=none

# Set hostname to 'media'
HOSTNAMEOPTS=media

# Set device manager to mdev
DEVDOPTS=mdev

# Contents of /etc/network/interfaces
INTERFACESOPTS="auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
"

# Search domain of example.com, Google public nameserver
# DNSOPTS="-d example.com 8.8.8.8"

# Set timezone to UTC
#TIMEZONEOPTS="UTC"
TIMEZONEOPTS="Australia/Perth"

# set http/ftp proxy
#PROXYOPTS="http://webproxy:8080"
PROXYOPTS=none

# Add first mirror (CDN)
APKREPOSOPTS="https://mirror.aarnet.edu.au/pub/alpine/latest-stable/main/"

# Create admin user
#USEROPTS="-a -u -g audio,video,netdev juser"
#USERSSHKEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOIiHcbg/7ytfLFHUNLRgEAubFz/13SwXBOM/05GNZe4 juser@example.com"
#USERSSHKEY="https://example.com/juser.keys"

# Don't install Openssh
SSHDOPTS=none

# Use busybox for ntp
# NTPOPTS="openntpd"
NTPOPTS=busybox

# No writeable system disk (only APK cache and LBU)
DISKOPTS=none

# Setup storage with label APKOVL for config storage
#LBUOPTS="LABEL=APKOVL"
LBUOPTS="mmcblk0p1"

#APKCACHEOPTS="/media/LABEL=APKOVL/cache"
APKCACHEOPTS=/media/mmcblk0p1/cache
