-include $(TOP).config

download:
	wget -c -O $(DOWNLOAD)/$(PKG_NAME).$(EXT) $(SRC).$(EXT)

unpack:
	@if [ "$(UNPACK)" = "tar" ]; then tar -xf $(DOWNLOAD)/$(PKG_NAME).$(EXT) -C $(BUILD); fi
	@if [ "$(UNPACK)" = "zip" ]; then unzip -q $(DOWNLOAD)/$(PKG_NAME).$(EXT) -d $(BUILD); fi

patch: download_patch
	@if [ "$(PATCHES)" != "." ]; then \
	cd $(BUILD)/$(PKG_NAME); \
	for i in $(PATCHES); \
	do \
		patch -p1 < $(PATCH)/$(PACKAGE)/$$i; \
	done; \
	fi

download_patch:
	@if [ "$(PATCH_SRC)" != "." ]; then \
	for i in $(PATCHES); \
	do \
		wget -c -O $(PATCH)/$(PACKAGE)/$$i $(PATCH_SRC)/$$i; \
	done; \
	fi
