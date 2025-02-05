#!/bin/bash

yum install -y lvm2 nano

pvcreate /dev/vdb /dev/vdc
vgcreate dba_storage /dev/vdb /dev/vdc
lvcreate -l 100%FREE -n volume_1 dba_storage
mkfs.xfs /dev/mapper/dba_storage-volume_1

mkdir -p /mnt/dba_storage
echo "/dev/mapper/dba_storage-volume_1 /mnt/dba_storage xfs defaults 0 0" >> /etc/fstab
mount -a

groupadd dba_users
usermod -aG dba_users bob

chown root:dba_users /mnt/dba_storage
chmod 770 /mnt/dba_storage

