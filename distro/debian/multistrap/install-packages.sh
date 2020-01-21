#!/bin/bash

# Replace @SUITE@ with Debian Release information
sed "s/@SUITE@/$CFG_DEB_RELEASE/" multistrap.conf.in > multistrap.conf

# Building the filesystem from the scratch
/usr/sbin/multistrap -a $CFG_DEB_ARCH -d $TARGET_FS_DIR -f multistrap.conf

# Copying the qemu-arm-static binary into the filesystem
# directory. This enables us to chroot into the filesystem for
# installing any packages.
cp /usr/bin/qemu-$CFG_QEMU_ARCH-static $TARGET_FS_DIR/usr/bin
