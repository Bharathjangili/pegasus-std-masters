#!/bin/bash

# Fix for dash configuration error as mentioned in
# https://wiki.debian.org/Multistrap#Debconf_and_pre-seeding
chroot $TARGET_FS_DIR /var/lib/dpkg/info/dash.preinst install

# Fix for systemd configuration error
chroot $TARGET_FS_DIR mknod /dev/urandom c 1 9

# dpkg configure is by default interactive,
# DEBIAN_FRONTEND=noninteractive and DEBCONF_NONINTERACTIVE_SEEN=true
# disables those prompts. Allow them to pass through even if it fails.
DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    LC_ALL=C LANGUAGE=C LANG=C chroot $TARGET_FS_DIR dpkg --configure -a
