include $(TOP).config
include $(TOP)scripts/common.mk

PACKAGE?=u-boot
VER_NAME?=2016.11
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
SRC?=ftp://ftp.denx.de/pub/u-boot/$(PKG_NAME)
PATCH_SRC?=.
PATCHES?=u-boot-toradex.patch u-boot-zilogic.patch
EXT?=tar.bz2
UNPACK?=tar

configure:
	make -C $(BUILD)/$(PKG_NAME) colibri_vf_defconfig

compile:
	echo "uboot compiling..."
	make -C $(BUILD)/$(PKG_NAME) CROSS_COMPILE=$(UBOOT_CROSS_COMPILE) $(JOBS) 

install:
	echo "uboot installation"
	mkdir -p $(BUILD)/$(PKG_NAME)/binaries/boot/uboot
	sudo cp $(BUILD)/$(PKG_NAME)/u-boot.bin $(BUILD)/$(PKG_NAME)/binaries/boot/uboot

packaging:
	fpm -C $(BUILD)/$(PKG_NAME)/binaries -s dir -t deb -n u-boot -v $(VER_NAME) -a armel --after-install $(TOP)/boot/u-boot/softlink.sh -p $(OUTPUT)/images ./
