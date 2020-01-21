SHELL = /bin/bash
BUILD ?= build
Q ?= @
O ?= .
-include $(O)/config

ifeq ($(Q),@)
MAKEFLAGS = --no-print-directory -s
endif

VER = 1.12.0
export O
include scripts/main.mk

all:build

%_defconfig:
	@if [ "$(Q)" == "@" ]; then echo " CONF " $(notdir $@); fi
	$(Q)cp configs/$@ $(O)/.config

.PHONY:distclean clean

distclean: clean
	rm -rf $(O)/downloads; echo "downloads directory deleted"
clean:
	rm -rf $(O)/.config; echo ".config deleted"
	sudo rm -rf output; echo "output directory deleted"
