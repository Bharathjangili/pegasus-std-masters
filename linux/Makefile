include $(TOP)/.config
include $(TOP)/scripts/common.mk

PACKAGE?=linux
VER_NAME?=4.4.39
PKG_NAME?=$(PACKAGE)-$(VER_NAME)
SRC?=https://www.kernel.org/pub/linux/kernel/v4.x/$(PKG_NAME)
PATCH_SRC?=.
PATCHES?=linux-toradex.patch
EXT?=tar.xz
UNPACK?=tar

INSTALL_MOD_PATH?=$(BUILD)/$(PKG_NAME)/binaries/
INSTALL_PATH?=$(BUILD)/$(PKG_NAME)/binaries/boot

configure:
	cp $(TOP)/linux/linux-configuration $(BUILD)/$(PKG_NAME)/arch/arm/configs/colibri_vf_defconfig
	make -C $(BUILD)/$(PKG_NAME) ARCH=$(ARCH) colibri_vf_defconfig

compile:
	echo "linux compiling..."
	make -C $(BUILD)/$(PKG_NAME) ARCH=$(ARCH) CROSS_COMPILE=$(LINUX_CROSS_COMPILE) $(JOBS) uImage LOADADDR=80008000
	make -C $(BUILD)/$(PKG_NAME) ARCH=$(ARCH) CROSS_COMPILE=$(LINUX_CROSS_COMPILE) vf500-colibri-eval-v3.dtb
	make -C $(BUILD)/$(PKG_NAME) ARCH=$(ARCH) CROSS_COMPILE=$(LINUX_CROSS_COMPILE) $(JOBS) modules 

install:
	echo "linux installation"
	mkdir -p $(INSTALL_PATH); sudo cp $(BUILD)/$(PKG_NAME)/arch/arm/boot/uImage $(INSTALL_PATH)/uImage-4.4.39-armel
	sudo cp $(BUILD)/$(PKG_NAME)/arch/arm/boot/dts/vf500-colibri-eval-v3.dtb $(INSTALL_PATH)
	sudo make -C $(BUILD)/$(PKG_NAME) ARCH=$(ARCH) modules_install INSTALL_MOD_PATH=$(INSTALL_MOD_PATH)

packaging:
	fpm -C $(BUILD)/$(PKG_NAME)/binaries -s dir -t deb -n linux -v $(VER_NAME) -a armel --after-install $(TOP)/linux/softlink.sh -p $(OUTPUT)/images ./ 

