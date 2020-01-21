include $(TOP)scripts/common.mk

PACKAGE?=mraa
USER_NAME?=intel-iot-devkit
VER_NAME?=08c7c0215e069b8f5c817abee1cb3a875bb3be11
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
ARCHIVE?=archive
EXT?=zip
UNPACK?=zip
SRC?=https://github.com/$(USER_NAME)/$(PACKAGE)/$(ARCHIVE)/$(VER_NAME)
PATCH_SRC?=.
PATCHES=mraa-zilogic.patch

DESTDIR?=$(BUILD)/$(PKG_NAME)/binaries/

configure:
	cd $(BUILD)/$(PKG_NAME); mkdir build;

compile:
	echo "mraa compiling..."
	cd $(BUILD)/$(PKG_NAME)/build; cmake .. -DBUILDSWIGNODE=OFF -DBUILDSWIGPYTHON=OFF -DBUILDARCH=arm -DCMAKE_C_COMPILER=/usr/bin/arm-none-linux-gnueabi-gcc -DCMAKE_CXX_COMPILER=/usr/bin/arm-none-linux-gnueabi-g++ -DJSONPLAT=OFF
	make -C $(BUILD)/$(PKG_NAME)/build

pre-install:
	echo "mraa pre-installation"
	make -C $(BUILD)/$(PKG_NAME)/build install DESTDIR=$(OUTPUT)/staging/

install:
	echo "mraa installation"
	make -C $(BUILD)/$(PKG_NAME)/build install DESTDIR=$(DESTDIR)

packaging:
	fpm -C $(BUILD)/$(PKG_NAME)/binaries/ -s dir -t deb -n mraa -v 0.1 -a armel --after-install $(TOP)/packages/$(PACKAGE)/softlink.sh -p $(OUTPUT)/images ./
