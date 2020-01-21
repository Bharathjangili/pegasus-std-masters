include $(TOP)scripts/common.mk

PACKAGE?=upm
USER_NAME?=intel-iot-devkit
VER_NAME?=98811b0fb7279318d90a1a6243ff1b2314e550bf
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
ARCHIVE?=archive
EXT?=zip
UNPACK?=zip
SRC?=https://github.com/$(USER_NAME)/$(PACKAGE)/$(ARCHIVE)/$(VER_NAME)
PATCH_SRC?=.
PATCHES=upm-zilogic.patch

DESTDIR?=$(BUILD)/$(PKG_NAME)/binaries

configure:
	cd $(BUILD)/$(PKG_NAME); mkdir build;

compile: mraa-lib
	echo "upm compiling..."
	cd $(BUILD)/$(PKG_NAME)/build; export PKG_CONFIG_PATH=$(OUTPUT)/staging/usr/local/lib/pkgconfig; cmake -DBUILDSWIGNODE=OFF -DBUILDSWIGPYTHON=OFF -DCMAKE_C_COMPILER=/usr/bin/arm-none-linux-gnueabi-gcc -DCMAKE_CXX_COMPILER=/usr/bin/arm-none-linux-gnueabi-g++ -DMRAA_LIBRARY=$(OUTPUT)/staging/usr/local/lib -DMRAA_INCLUDE_DIRS=$(OUTPUT)/staging/usr/local/include ..
	cd $(BUILD)/$(PKG_NAME)/build; make

mraa-lib:
	make -C $(TOP)/packages/mraa pre-install

install:
	echo "upm installation"
	make -C $(BUILD)/$(PKG_NAME)/build install DESTDIR=$(DESTDIR)

packaging:
	echo "inside upm fpm"
	fpm -C $(BUILD)/$(PKG_NAME)/binaries/ -s dir -t deb -n upm -v 0.1 -a armel --after-install $(TOP)/packages/$(PACKAGE)/softlink.sh -p $(OUTPUT)/images ./
