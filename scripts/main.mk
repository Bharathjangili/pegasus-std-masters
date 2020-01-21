-include $(O)/.config

TOP=$(PWD)/
DOWNLOAD=$(TOP)/downloads/
BOARD=$(TOP)/board/
PLATFORM=$(BOARD)/zkit-arm-vf5x/
PATCH=$(PLATFORM)/patches/
OUTPUT=$(TOP)/output/
BUILD=$(OUTPUT)/build/

export BUILD
export TOP
export DOWNLOAD
export BOARD
export PLATFORM
export PATCH
export OUTPUT
export BUILD

build: host_dep build_setup download unpack patch configure compile install package run_ansible rootfs_image

host_dep:
	make -C $(TOP)/distro/debian/ansible-host

build_setup:
	mkdir -p $(DOWNLOAD)
	mkdir -p $(OUTPUT)/build $(OUTPUT)/staging $(OUTPUT)/target $(OUTPUT)/images
	echo "directories are created"

download: firmware_dl packages_dl rootfs_dl

firmware_dl:
	echo "firmware_dl $(BOOTLOADER)"
	make -C boot/$(BOOTLOADER) download
	echo "firmware_dl linux"
	make -C linux download

packages_dl:
	echo "Packages_dl"
	for i in $(PACKAGES); \
	do \
		make -C $(TOP)/packages/$$i download; \
	done

rootfs_dl:
	echo "rootfs_dl"
	make -C ./distro/debian/multistrap -f build.mk

unpack: firmware_unpack packages_unpack

firmware_unpack:
	echo "firmware_unpack $(BOOTLOADER)"
	make -C boot/$(BOOTLOADER) unpack
	echo "firmware_unpack linux"
	make -C linux unpack

packages_unpack:
	echo "packages_unpack"
	for i in $(PACKAGES); \
	do \
		make -C $(TOP)/packages/$$i unpack; \
	done

patch:  firmware_patch packages_patch

firmware_patch:
	echo "firmware_patch $(BOOTLOADER)"
	make -C boot/$(BOOTLOADER) patch
	echo "firmware_patch linux"
	make -C linux patch

packages_patch:
	echo "packages_patch"
	for i in $(PACKAGES); \
	do \
		make -C $(TOP)/packages/$$i patch; \
	done

configure: firmware_configure packages_configure

firmware_configure:
	echo "firmware_configure $(BOOTLOADER)"
	make -C boot/$(BOOTLOADER) configure
	echo "firmware_configure linux"
	make -C linux configure

packages_configure:
	echo "packages_configure"
	for i in $(PACKAGES); \
	do \
		make -C $(TOP)/packages/$$i configure; \
	done


compile: firmware_compile packages_compile

firmware_compile:
	echo "firmware_compile $(BOOTLOADER)"
	make -C boot/$(BOOTLOADER) compile
	echo "firmware_compile linux"
	make -C linux compile

packages_compile:
	echo "packages_compile"
	for i in $(PACKAGES); \
	do \
		make -C $(TOP)/packages/$$i compile; \
	done

install: firmware_install packages_install

firmware_install:
	echo "firmware_install $(BOOTLOADER)"
	make -C boot/$(BOOTLOADER) install
	echo "firmware_install linux"
	make -C linux install

packages_install:
	echo "packages_install"
	for i in $(PACKAGES); \
	do \
		make -C $(TOP)/packages/$$i install; \
	done

package: firmware_packaging packages_packaging

firmware_packaging:
	echo "firmware_packaging $(BOOTLOADER)"
	make -C boot/$(BOOTLOADER) packaging
	echo "firmware_packaging linux"
	make -C linux packaging

packages_packaging:
	echo "packages_packaging"
	for i in $(PACKAGES); \
	do \
		make -C $(TOP)/packages/$$i packaging; \
	done

run_ansible: scan_packages
	echo "running ansible"
	make -C $(TOP)/distro/debian/ansible

scan_packages:
	echo "scanning packages"
	cd $(OUTPUT)/images; dpkg-scanpackages ./ /dev/null | gzip -9c > ./Packages.gz

rootfs_image:
	echo "rootfs image creation"
	make -C $(TOP)/fs/ext-image -f build.mk
