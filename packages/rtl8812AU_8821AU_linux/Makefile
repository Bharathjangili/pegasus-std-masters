include $(TOP)scripts/common.mk

PACKAGE?=rtl8812AU_8821AU_linux
USER_NAME?=abperiasamy
VER_NAME?=0292aa694d85e8f9120479604e98693f20d5da02
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
ARCHIVE?=archive
EXT?=tar.gz
UNPACK?=tar
SRC?=https://github.com/$(USER_NAME)/$(PACKAGE)/$(ARCHIVE)/$(VER_NAME)
PATCH_SRC?=.
PATCHES=.

MODDESTDIR=$(BUILD)/$(PKG_NAME)/binaries/lib/modules/4.4.39/kernel/drivers/wireless
KSRC=$(BUILD)/linux-4.4.39

configure:
	echo "configure not needed"

compile:
	echo "$(PKG_NAME) compilling..."
	make -C $(BUILD)/$(PKG_NAME) ARCH=$(ARCH) CROSS_COMPILE=$(LINUX_CROSS_COMPILE) KSRC=$(KSRC) $(JOBS)
	echo "finished rtl88 compile"

install:
	echo "$(PKG_NAME) installation"
	mkdir -p $(MODDESTDIR); make -C $(BUILD)/$(PKG_NAME) install MODDESTDIR=$(MODDESTDIR)

packaging:
	fpm -C $(BUILD)/$(PKG_NAME)/binaries -s dir -t deb -n rtl8812au-8821au-linux -v 0.1 -a armel -p $(OUTPUT)/images ./
