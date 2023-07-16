#!/bin/sh

apk update
apk upgrade
apk add avahi
apk add samba
apk add e2fsprogs
rc-update add avahi-daemon default
rc-update add samba default


echo media | adduser media --no-create-home --shell=/bin/false -u 1000 -D
(echo "media"; echo "media") | smbpasswd -s media
lbu add /var/lib/samba/private/*.tdb

mkfs.ext4 /dev/mmcblk0p2
mkdir /media/data
echo "/dev/mmcblk0p2    /media/data ext4    noatime,rw 0 0" >> /etc/fstab
mount -a
chown -R media /media/data

cat | tee /etc/samba/smb.conf <<EOF
[global]
   netbios name = media
   ntlm auth = yes

[data]
    path = /media/data
    comment = Data Files
    browseable = yes
    create mask = 0755
    directory mask = 0755
    valid users = media
    guest ok = yes
    public = yes
    writeable = yes
EOF

echo "Committing changes"
lbu commit
sync
