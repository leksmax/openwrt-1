# Copyright (C) 2010 OpenWrt.org
# Copyright (C) 2015-2016 Lantiq Beteiligungs GmbH & Co KG.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ltq-vdsl-app
PKG_VERSION:=4.19.3
PKG_RELEASE:=4
PKG_BASE_NAME:=dsl_cpe_control
PKG_SOURCE:=$(PKG_BASE_NAME)_vrx-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://sources.openwrt.org/
PKG_HASH:=d89a2db8a75cdfff77ad568fda5e56407b0df057e9b147df203f1f8587b5b0f8
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_LICENSE:=BSD-2-Clause

PKG_BUILD_DEPENDS:=ltq-vdsl

PKG_FLAGS:=nonshared

include $(INCLUDE_DIR)/package.mk

define Package/ltq-vdsl-app
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lantiq VDSL userland tool
	URL:=http://www.lantiq.com/
	DEPENDS:=@TARGET_lantiq_xrx200||TARGET_ipq40xx +libpthread +librt
endef

define Package/ltq-vdsl-app/description
	Userland tool needed to control Lantiq VDSL CPE
endef

define Package/ltq-vdsl-app/config
	choice
		prompt "Device selection"
		depends on PACKAGE_ltq-vdsl-app
		default VR9

		config VR9
			bool "VRX200 Family"

		config VR10
			bool "VRX300 Family"
			depends on (TARGET_ipq80xx||TARGET_ipq40xx)

		config VR10_320
			bool "VRX320 Family"
			depends on (TARGET_ipq80xx||TARGET_ipq40xx)

		config VR11
			bool "VRX500 Family"
			depends on (TARGET_ipq80xx||TARGET_ipq40xx)

	endchoice
endef

CONFIGURE_ARGS += \
	--enable-vrx \
	--enable-driver-include="-I$(STAGING_DIR)/usr/include/drv_vdsl_cpe_api" \
	--enable-device-driver-include="-I$(STAGING_DIR)/usr/include/vdsl/" \
	--enable-ifxos \
	--enable-ifxos-include="-I$(STAGING_DIR)/usr/include/ifxos" \
	--enable-ifxos-library="-I$(STAGING_DIR)/usr/lib" \
	--enable-add-appl-cflags="-DMAX_CLI_PIPES=1"  \
	--enable-debug \
	--disable-dti \
	--with-channels-per-line="1" \

ifeq ($(CONFIG_VR9),y)
	CONFIGURE_ARGS += --enable-vrx-device=vr9
else ifeq ($(CONFIG_VR10),y)
	CONFIGURE_ARGS += --enable-vrx-device=vr10
else ifeq ($(CONFIG_VR10_320),y)
	CONFIGURE_ARGS += --enable-vrx-device=vr10_320
else ifeq ($(CONFIG_VR11),y)
	CONFIGURE_ARGS += --enable-vrx-device=vr11
else
	CONFIGURE_ARGS += --enable-vrx-device=vr9
endif

#CONFIGURE_ARGS += --enable-model=full
#CONFIGURE_ARGS += --enable-model=lite
#CONFIGURE_ARGS += --enable-model=footprint
CONFIGURE_ARGS += \
	--enable-model=typical \
	--enable-dsl-pm-showtime \
	--disable-dsl-ceoc
#CONFIGURE_ARGS += --enable-model=debug

define Package/ltq-vdsl-app/install
	$(INSTALL_DIR) $(1)/etc/init.d $(1)/sbin $(1)/etc/hotplug.d/dsl
	$(INSTALL_BIN) ./files/dsl_control $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/10_atm.sh $(1)/etc/hotplug.d/dsl
	$(INSTALL_BIN) ./files/10_ptm.sh $(1)/etc/hotplug.d/dsl

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/dsl_cpe_control $(1)/sbin/vdsl_cpe_control
	$(INSTALL_BIN) ./files/dsl_cpe_pipe.sh $(1)/sbin/
endef

$(eval $(call BuildPackage,ltq-vdsl-app))
