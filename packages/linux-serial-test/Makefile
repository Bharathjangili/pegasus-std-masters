include $(TOP)scripts/common.mk

PACKAGE?=linux-serial-test
USER_NAME?=cbrake
VER_NAME?=d5b01cbd0c12ba27a9283a1ca47e0f0b30787885
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
ARCHIVE?=archive
EXT?=zip
UNPACK?=zip
SRC?=https://github.com/$(USER_NAME)/$(PACKAGE)/$(ARCHIVE)/$(VER_NAME)
PATCH_SRC?=.
PATCHES=.

DESTDIR=$(BUILD)/$(PKG_NAME)/binaries/

configure:
	cd $(BUILD)/$(PKG_NAME); mkdir build;

compile:
	echo "linux-serial-test compiling..."
	cd $(BUILD)/$(PKG_NAME)/build; cmake .. -DBUILD_ARCH=arm -DCMAKE_C_COMPILER=/usr/bin/arm-none-linux-gnueabi-gcc
	make -C $(BUILD)/$(PKG_NAME)/build

install:
	echo "linux-serial-test installation"
	make -C $(BUILD)/$(PKG_NAME)/build install DESTDIR=$(DESTDIR)

packaging:
	fpm -C $(BUILD)/$(PKG_NAME)/binaries -s dir -t deb -n linux-serial-test -v 0.1 -a armel -p $(OUTPUT)/images ./
