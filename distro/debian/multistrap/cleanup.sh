#!/bin/bash

# It's time to pack the rootfs.
# Remove the arm-static binary before packing it to a filesystem
# archive/image.
rm $TARGET_FS_DIR/usr/bin/qemu-$CFG_QEMU_ARCH-static
