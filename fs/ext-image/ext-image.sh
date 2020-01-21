#!/bin/bash
ROOTFS_IMAGE=../../output/images/
DISKIMG=pegasus-std-rootfs

function DBG() {
    echo ">>> " $1
}

# Find the unused loop device
DBG "Find the unused loop device"
LOOPDEVICE=$(sudo /sbin/losetup -f)

# Create a disk image in a raw format using dd
DBG "Create a disk image"
dd if=/dev/zero of=$DISKIMG.img bs=1M count=1024

# Associate the disk image with the available loop device
DBG "Associate the disk"
sudo /sbin/losetup $LOOPDEVICE $DISKIMG.img

# Create a partitions
DBG "Create a partitions"
sudo /sbin/fdisk $LOOPDEVICE<<EOF
n
p
1


w
EOF

# Create a device map from the device partition table
DBG "Create a device map for loop device"
sudo /sbin/kpartx -a -v $LOOPDEVICE

# Format the disk with a ext4 filesystem
DBG "Format the disk"
LOOPDEV1=$(sudo /sbin/fdisk -l $LOOPDEVICE | grep ${LOOPDEVICE}p | awk '{print $1}' | head -n 1 | cut -d "/" -f 3)
sleep 2  # Waiting for detecting devices
sudo /sbin/mkfs.ext4 -F -L "pegasus-std-rootfs" /dev/mapper/$LOOPDEV1

# Mount the `uImage` partition and copy uImage, dtb, uboot's image
DBG "Mount the first partition & Copy the data"

sudo mount /dev/mapper/$LOOPDEV1 /mnt
sudo cp -R ../../output/target/rootfs-armel-jessie/* /mnt

# Unmount all the filesystem and disassociate the loopdevice
DBG "Umount all the filesystems"
sudo umount /mnt 
sudo /sbin/kpartx -d $LOOPDEVICE
sudo /sbin/losetup -d $LOOPDEVICE
mv ./pegasus-std-rootfs.img $ROOTFS_IMAGE 
