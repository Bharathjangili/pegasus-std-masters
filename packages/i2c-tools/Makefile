include $(TOP)scripts/common.mk

PACKAGE?=i2c-tools
USER_NAME?=pub
VER_NAME?=4.0
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
ARCHIVE?=archive
EXT?=tar.gz
UNPACK?=tar
SRC?=https://www.kernel.org/pub/software/utils/$(PACKAGE)/$(PKG_NAME)
PATCH_SRC?=.
PATCHES=.

DESTDIR=$(BUILD)/$(PKG_NAME)/binaries/

configure:
	echo "Configure not needed..."

compile:
	echo "i2c-tools compiling..." 
	make -C $(BUILD)/$(PKG_NAME) ARCH=arm CC=/usr/bin/arm-none-linux-gnueabi-gcc

install:
	echo "i2c-tools installation"
	make -C $(BUILD)/$(PKG_NAME) install DESTDIR=$(DESTDIR)

packaging:
	echo "i2c-tools packaging"
	fpm -C $(BUILD)/$(PKG_NAME)/binaries -s dir -t deb -n i2ctool -v 0.1 -a armel --after-install $(TOP)/packages/$(PACKAGE)/softlink.sh -p $(OUTPUT)/images ./
