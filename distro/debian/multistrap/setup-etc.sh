#!/bin/bash

# Rootfs configuration script

# User Configurable Parameters
username="root"
password="zilogic"
#SSH_NOT_PERMIT=PermitRootLogin without-password
#SSH_PERMIT=PermitRootLogin yes


# Configuring the necessary files for boot-up.
# Set the target board hostname
filename=$TARGET_FS_DIR/etc/hostname
echo Creating $filename
echo emdebian > $filename

# Set the defalt name server
filename=$TARGET_FS_DIR/etc/resolv.conf
echo Creating $filename
echo nameserver 8.8.8.8 > $filename
echo nameserver 8.8.4.4 >> $filename

# Set the default network interfaces
filename=$TARGET_FS_DIR/etc/network/interfaces
echo Updating $filename
echo allow-hotplug eth0 >> $filename
echo iface eth0 inet dhcp >> $filename

if [ $CFG_SERIAL_CONSOLE == "y" ]
then
    # Set a terminal to the debug port
    filename=$TARGET_FS_DIR/etc/securetty
    echo Updating $filename
    echo ttyLP0 >> $filename
fi

# Set how to mount the proc
filename=$TARGET_FS_DIR/etc/fstab
echo Creating $filename
echo proc /proc proc defaults 0 0 >> $filename

#  ssh allow the root rootuser
#sed "s/$SSH_NOT_PERMIT/$SSH__PERMIT/" $TARGET_FS_DIR/etc/ssh/sshd_config


# Add the standard Debian repositories. In this way it is possible
# to install packages not included in the Emdebian/Grip repositories
filename=$TARGET_FS_DIR/etc/apt/sources.list
echo Creating $filename
echo deb http://ftp.us.debian.org/debian $CFG_DEB_RELEASE main contrib non-free > $filename
echo deb http://security.debian.org/ $CFG_DEB_RELEASE/updates main >> $filename

# Create a login password for root.
echo $username:$password | chroot $TARGET_FS_DIR /usr/sbin/chpasswd
