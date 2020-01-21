#!/bin/bash

if [ -c "$TARGET_FS_DIR/dev/urandom" ];then
    rm $TARGET_FS_DIR/dev/urandom
fi

mknod $TARGET_FS_DIR/dev/urandom c 1 9
chmod 666 $TARGET_FS_DIR/dev/urandom

if [ -c "$TARGET_FS_DIR/dev/null" ];then
    rm $TARGET_FS_DIR/dev/null
fi

mknod $TARGET_FS_DIR/dev/null c 1 3
chmod 666 $TARGET_FS_DIR/dev/null

if [ -c "$TARGET_FS_DIR/dev/console" ];then
    rm $TARGET_FS_DIR/dev/console
fi

mknod $TARGET_FS_DIR/dev/console c 5 1
chmod 660 $TARGET_FS_DIR/dev/console

if [ -c "$TARGET_FS_DIR/dev/ttyS0" ];then
    rm $TARGET_FS_DIR/dev/ttyS0
fi

mknod $TARGET_FS_DIR/dev/ttyS0 c 4 64
chmod 666 $TARGET_FS_DIR/dev/ttyS0
