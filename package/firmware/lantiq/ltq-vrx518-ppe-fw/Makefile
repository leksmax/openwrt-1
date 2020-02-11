#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ltq-vrx518-ppe-fw
PKG_VERSION:=1.3.7
PKG_RELEASE:=1

PKG_BASE_NAME:=vrx518_ppe_fw
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_BASE_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://sources.openwrt.org/
PKG_HASH:=ca34f7997b9f363f3427ae25a2c0cd1eff8ee1bd9ff1413d8cb52e1d9a3aceff


include $(INCLUDE_DIR)/package.mk

define Package/ltq-vrx518-ppe-fw
	SECTION:=firmware
	CATEGORY:=Firmware
	TITLE:=VRX518 PPE firmware
	URL:=http://www.lantiq.com/
	DEPENDS:=@TARGET_lantiq_xrx200||TARGET_ipq40xx
endef


define Package/ltq-vrx518-ppe-fw/config
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

define Package/ltq-vrx518-ppe-fw/install
	$(INSTALL_DIR) $(1)/lib/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/platform/$(LTQ_PLATFORM)/ppe_fw.bin $(1)/lib/firmware/
endef

$(eval $(call BuildPackage,ltq-vrx518-ppe-fw))