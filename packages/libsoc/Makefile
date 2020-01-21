include $(TOP)/scripts/common.mk

PACKAGE?=libsoc
USER_NAME?=jackmitch
VER_NAME?=78f80bb759fc21d344b3687ce9bd9c45d3f8ea67
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
ARCHIVE?=archive
EXT?=tar.gz
UNPACK?=tar
SRC?=https://github.com/$(USER_NAME)/$(PACKAGE)/$(ARCHIVE)/$(VER_NAME)
PATCH_SRC?=.
PATCHES=libsoc-zilogic.patch

DESTDIR=$(BUILD)/$(PKG_NAME)/binaries/usr/local

configure:
	cd $(BUILD)/$(PKG_NAME); autoreconf -i
	cd $(BUILD)/$(PKG_NAME); ./configure --enable-debug  CC=arm-none-linux-gnueabi-gcc --host=arm-none-linux-gnueabi --target=arm-none-linux-gnueabi --enable-board=VF51 --prefix=$(DESTDIR)

compile:
	echo "libsoc compiling..."
	make -C $(BUILD)/$(PKG_NAME)

install:
	echo "libsoc installation"
	mkdir -p $(BUILD)/$(PKG_NAME)/binaries; make -C $(BUILD)/$(PKG_NAME) install
	cp -r $(BUILD)/$(PKG_NAME)/lib/include/linux $(DESTDIR)/include
	cp -r $(BUILD)/$(PKG_NAME)/lib/include/libsoc_file.h $(DESTDIR)/include

packaging:
	fpm -C $(BUILD)/$(PKG_NAME)/binaries -s dir -t deb -n libsoc -v 0.1 -a armel --after-install $(TOP)/packages/$(PACKAGE)/softlink.sh -p $(OUTPUT)/images ./ 
