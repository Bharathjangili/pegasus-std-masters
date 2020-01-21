include $(TOP)scripts/common.mk

PACKAGE?=rtl8192eu-linux-driver
USER_NAME?=Mange
VER_NAME?=409400432038394358ddb7395ccf4910f09bf054
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
ARCHIVE?=archive
EXT?=zip
UNPACK?=zip
SRC?=https://github.com/$(USER_NAME)/$(PACKAGE)/$(ARCHIVE)/$(VER_NAME)
PATCH_SRC?=.
PATCHES=.

MODDESTDIR=$(BUILD)/$(PKG_NAME)/binaries/lib/modules/4.4.39/kernel/drivers/wireless
KSRC=$(BUILD)/linux-4.4.39

configure:
	echo "configure not needed"

compile:
	echo "$(PKG_NAME) compiling..."
	make -C $(BUILD)/$(PKG_NAME) ARCH=$(ARCH) CROSS_COMPILE=$(LINUX_CROSS_COMPILE) KSRC=$(KSRC) $(JOBS)

install:
	echo "$(PKG_NAME) install"
	mkdir -p $(MODDESTDIR); make -C $(BUILD)/$(PKG_NAME) install MODDESTDIR=$(MODDESTDIR)

packaging:
	fpm -C $(BUILD)/$(PKG_NAME)/binaries -s dir -t deb -n rtl8192eu-linux-driver -v 0.1 -a armel -p $(OUTPUT)/images ./
