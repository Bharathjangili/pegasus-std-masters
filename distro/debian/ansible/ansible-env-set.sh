#!/bin/bash

echo "ansible-env-set inside"
export ROOTFS=../../../output/target/rootfs-armel-jessie
export ANSIBLE_DIR=.
export LOCAL_REPO=../../../output/images

#copy the arch binary file
sudo cp /usr/bin/qemu-arm-static $ROOTFS/usr/bin/

sudo mount -t proc none $ROOTFS/proc
sudo mount -o bind /dev $ROOTFS/dev
sudo mount -t sysfs none $ROOTFS/sys

#To access ansible playbooks
sudo mount --bind $ANSIBLE_DIR $ROOTFS/mnt/
sudo mount --bind $LOCAL_REPO  $ROOTFS/tmp/

# ansible execute through chroot
sudo chroot $ROOTFS /bin/bash -c "ansible-playbook -i 'localhost,' -c local /mnt/playbook-main.yml; depmod 4.4.39"

sudo chroot $ROOTFS /sbin/fake-hwclock

#Delete downloaded packages(.deb) already installed
echo "apt-get clean"
sudo chroot $ROOTFS /bin/bash -c "apt-get clean; apt-get autoclean"

# remove qemu binary form rootfs
echo "delete qemu"
sudo rm $ROOTFS/usr/bin/qemu-arm-static

#umount the mnt
echo "umount all"
sudo umount -l $ROOTFS/mnt
sudo umount -l $ROOTFS/tmp

sudo umount -l $ROOTFS/sys
sudo umount -l $ROOTFS/dev
sudo umount -l $ROOTFS/proc
