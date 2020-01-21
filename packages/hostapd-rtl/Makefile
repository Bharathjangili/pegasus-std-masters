include $(TOP)scripts/common.mk

PACKAGE?=hostapd-rtl
USER_NAME?=jekader
VER_NAME?=83181e6335b46f6eb7c90746acafcb3065f4f5c0
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
ARCHIVE?=archive
EXT?=tar.gz
UNPACK?=tar
SRC?=https://github.com/$(USER_NAME)/$(PACKAGE)/$(ARCHIVE)/$(VER_NAME)
PATCH_SRC?=.
PATCHES=.

DESTDIR=$(BUILD)/$(PKG_NAME)/binaries/usr/share/bin/hostapd/

configure:
	echo "configure not needed"

compile:
	echo "hostapd compilling..."
	make -C $(BUILD)/$(PKG_NAME) CC=$(CC)
	echo "finished hostapd compile"

install:
	echo "hostapd installation"
	make -C $(BUILD)/$(PKG_NAME) install DESTDIR=$(DESTDIR)

packaging:
	fpm -C $(BUILD)/$(PKG_NAME)/binaries -s dir -t deb -n hostapd-rtl -v 0.1 -a armel -p $(OUTPUT)/images ./
