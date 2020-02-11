#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ltq-vrx518-aca-fw
PKG_VERSION:=1.5.0
PKG_RELEASE:=1

PKG_BASE_NAME:=vrx518_aca_fw
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_BASE_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://sources.openwrt.org/
PKG_HASH:=36f811df89ecd659f94e7b55d6b18954ccb1712385bd35a8ab555955df412fb6


include $(INCLUDE_DIR)/package.mk

define Package/ltq-vrx518-aca-fw
	SECTION:=firmware
	CATEGORY:=Firmware
	TITLE:=VRX518 ACA firmware
	URL:=http://www.lantiq.com/
	DEPENDS:=@TARGET_lantiq_xrx200||TARGET_ipq40xx
endef


define Package/ltq-vrx518-aca-fw/config
	choice
		prompt "Platform selection"
		depends on PACKAGE_ltq-vdsl-app
		default XRX500

		config XRX320
			bool "XRX320 Family"

		config XRX500
			bool "XRX500 Family"
			depends on (TARGET_ipq80xx||TARGET_ipq40xx)

		config XRX750
			bool "XRX750 Family"
			depends on (TARGET_ipq80xx||TARGET_ipq40xx)

	endchoice
endef

ifeq ($(CONFIG_XRX320),y)
	LTQ_PLATFORM:= xrx320
else ifeq ($(CONFIG_XRX500),y)
	LTQ_PLATFORM:= xrx500
else ifeq ($(CONFIG_XRX750),y)
	LTQ_PLATFORM:= xrx750
else
	LTQ_PLATFORM:= xrx500
endif



define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)
	$(TAR) -C $(BUILD_DIR) -xvf $(DL_DIR)/$(PKG_SOURCE)
endef

define Build/Compile
endef

define Package/ltq-vrx518-aca-fw/install
	$(INSTALL_DIR) $(1)/lib/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/platform/$(LTQ_PLATFORM)/aca_fw.bin $(1)/lib/firmware/
endef

$(eval $(call BuildPackage,ltq-vrx518-aca-fw))