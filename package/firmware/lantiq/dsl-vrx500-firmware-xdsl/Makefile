#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dsl_vr11_firmware_xdsl
PKG_RELEASE:=1
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_SOURCE_URL:=https://sources.openwrt.org/

ANNEX_A_VERSION:=8B0F07_8B0701
PKG_A_VERSION:=08.0B.00.0F.00.07_08.0B.00.07.00.01
PKG_A_HASH:=0e93f6daef17955555335aa71175051694c31a8ab926be60ac8f542b1928ec0c
PKG_A_SOURCE:=$(PKG_NAME)-$(PKG_A_VERSION).tar.gz

ANNEX_B_VERSION:=8C1717_8C1111
PKG_B_VERSION:=08.0C.01.07.01.07_08.0C.01.01.01.01
PKG_B_HASH:=add05c6b218ec0ae25443dcbb8ee01e045c1d794075f30e12846f043ce7f3fde
PKG_B_SOURCE:=$(PKG_NAME)-$(PKG_B_VERSION).tar.gz


include $(INCLUDE_DIR)/package.mk

define Package/dsl-vrx500-firmware-xdsl-a
	SECTION:=firmware
	CATEGORY:=Firmware
	TITLE:=VRX500 / VR11 CPE xDSL Annex A firmware
	URL:=http://www.lantiq.com/
	DEPENDS:=@TARGET_lantiq_xrx200||TARGET_ipq40xx
	PKG_SOURCE:=$(PKG_A_SOURCE)
	PKG_HASH:=$(PKG_A_HASH)
endef

define Package/dsl-vrx500-firmware-xdsl-b
	SECTION:=firmware
	CATEGORY:=Firmware
	TITLE:=VRX500 / VR11 CPE xDSL Annex B firmware
	URL:=http://www.lantiq.com/
	DEPENDS:=@TARGET_lantiq_xrx200||TARGET_ipq40xx
	PKG_SOURCE:=$(PKG_B_SOURCE)
	PKG_HASH:=$(PKG_B_HASH)
endef

define Download/dsl-vrx500-firmware-xdsl-b
	FILE:=$(PKG_B_SOURCE)
	URL:=$(PKG_SOURCE_URL)
	HASH:=$(PKG_B_HASH)
endef
$(eval $(call Download,dsl-vrx500-firmware-xdsl-b))

define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)
	mkdir -p $(PKG_BUILD_DIR)/$(PKG_A_SOURCE)
	mkdir -p $(PKG_BUILD_DIR)/$(PKG_B_SOURCE) 
	$(TAR) -C $(PKG_BUILD_DIR)/$(PKG_A_SOURCE) -xvf $(DL_DIR)/$(PKG_A_SOURCE)
	$(TAR) -C $(PKG_BUILD_DIR)/$(PKG_B_SOURCE) -xvf $(DL_DIR)/$(PKG_B_SOURCE)
endef

define Build/Compile
endef

define Package/dsl-vrx500-firmware-xdsl-a/install
	$(INSTALL_DIR) $(1)/lib/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(PKG_A_SOURCE)/LICENSE $(1)/lib/firmware/xcpe_$(ANNEX_A_VERSION).LICENSE
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(PKG_A_SOURCE)/xcpe_$(ANNEX_A_VERSION).bin $(1)/lib/firmware/
	ln -s /lib/firmware/xcpe_$(ANNEX_A_VERSION).bin $(1)/lib/firmware/vdsl.bin
endef

define Package/dsl-vrx500-firmware-xdsl-b/install
	$(INSTALL_DIR) $(1)/lib/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(PKG_B_SOURCE)/LICENSE $(1)/lib/firmware/xcpe_$(ANNEX_B_VERSION).LICENSE
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/$(PKG_B_SOURCE)/xcpe_$(ANNEX_B_VERSION).bin $(1)/lib/firmware/
	ln -s /lib/firmware/xcpe_$(ANNEX_B_VERSION).bin $(1)/lib/firmware/vdsl.bin
endef

$(eval $(call BuildPackage,dsl-vrx500-firmware-xdsl-a))
$(eval $(call BuildPackage,dsl-vrx500-firmware-xdsl-b))