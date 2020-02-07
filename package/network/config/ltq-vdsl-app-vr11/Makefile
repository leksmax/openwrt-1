# Copyright (C) 2010 OpenWrt.org
# Copyright (C) 2015-2016 Lantiq Beteiligungs GmbH & Co KG.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ltq-vdsl-app-vr11
# PKG_VERSION:=4.17.18.6
PKG_VERSION:=4.19.3
PKG_RELEASE:=3
PKG_BASE_NAME:=dsl_cpe_control
PKG_SOURCE:=$(PKG_BASE_NAME)_vrx-$(PKG_VERSION).tar.gz
# PKG_SOURCE_URL:=http://mirror2.openwrt.org/sources
# PKG_HASH:=da8bb929526a61aea0e153ef524331fcd472a1ebbc6d88ca017735a4f82ece02
PKG_SOURCE_URL:=https://sources.openwrt.org/
PKG_HASH:=d89a2db8a75cdfff77ad568fda5e56407b0df057e9b147df203f1f8587b5b0f8
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_LICENSE:=BSD-2-Clause

PKG_BUILD_DEPENDS:=ltq-vdsl-vr11

PKG_FLAGS:=nonshared

include $(INCLUDE_DIR)/package.mk

define Package/ltq-vdsl-app-vr11
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Lantiq VDSL userland tool for vr11 devices
  URL:=http://www.lantiq.com/
  DEPENDS:+libpthread +librt
endef

define Package/ltq-vdsl-app-vr11/description
  Userland tool needed to control Lantiq VDSL CPE for vr11 devices
endef

CONFIGURE_ARGS += \
	--enable-vrx \
	--enable-vrx-device=vr11 \
	--enable-driver-include="-I$(STAGING_DIR)/usr/include/drv_vdsl_cpe_api" \
	--enable-device-driver-include="-I$(STAGING_DIR)/usr/include/vdsl/" \
	--enable-ifxos \
	--enable-ifxos-include="-I$(STAGING_DIR)/usr/include/ifxos" \
	--enable-ifxos-library="-I$(STAGING_DIR)/usr/lib" \
	--enable-add-appl-cflags="-DMAX_CLI_PIPES=1"  \
	--enable-debug \
	--disable-dti \
	--with-channels-per-line="1" \

#CONFIGURE_ARGS += --enable-model=full
#CONFIGURE_ARGS += --enable-model=lite
#CONFIGURE_ARGS += --enable-model=footprint
CONFIGURE_ARGS += \
	--enable-model=typical \
	--enable-dsl-pm-showtime \
	--disable-dsl-ceoc
#CONFIGURE_ARGS += --enable-model=debug

define Package/ltq-vdsl-app-vr11/install
	$(INSTALL_DIR) $(1)/etc/init.d $(1)/sbin $(1)/etc/hotplug.d/dsl
	$(INSTALL_BIN) ./files/dsl_control $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/10_atm.sh $(1)/etc/hotplug.d/dsl
	$(INSTALL_BIN) ./files/10_ptm.sh $(1)/etc/hotplug.d/dsl

	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/dsl_cpe_control $(1)/sbin/vdsl_cpe_control
	$(INSTALL_BIN) ./files/dsl_cpe_pipe.sh $(1)/sbin/
endef

$(eval $(call BuildPackage,ltq-vdsl-app-vr11))
