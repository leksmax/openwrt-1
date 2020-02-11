# Copyright (C) 2012 OpenWrt.org
# Copyright (C) 2015-2016 Lantiq Beteiligungs GmbH & Co KG.
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=ltq-vdsl-vr11-mei
PKG_VERSION:=1.7.2
PKG_RELEASE:=1

PKG_BASE_NAME:=drv_mei_cpe
PKG_SOURCE:=$(PKG_BASE_NAME)-$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://sources.openwrt.org/
PKG_HASH:=c69d4c00406ae6efd3c8a68eab662855be751666c72f35315d414d5d9fcf3b74
PKG_FIXUP:=autoreconf
PKG_FLAGS:=nonshared
PKG_MAINTAINER:=John Crispin <john@phrozen.org>
PKG_LICENSE:=GPL-2.0 BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define KernelPackage/ltq-vdsl-vr11-mei
	TITLE:=mei driver for vdsl
	SECTION:=sys
	SUBMENU:=Network Devices
	DEPENDS:=@TARGET_ipq40xx +kmod-ltq-ifxos +PACKAGE_kmod-ltq-vrx518-tc-drv:kmod-ltq-vrx518-ep
	KCONFIG:=CONFIG_LTQ_DSL_CPE_MEI_VRX=y
	FILES:=$(PKG_BUILD_DIR)/src/drv_mei_cpe.ko
	AUTOLOAD:=$(call AutoLoad,50,drv_mei_cpe)
endef

define KernelPackage/ltq-vdsl-vr11-mei/description
	Lantiq MEI CPE Kernel Module Driver
endef


define Package/ltq-vdsl-vr11-mei_test
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Lantiq mei driver test tool
	URL:=http://www.lantiq.com/
	DEPENDS:=@TARGET_ipq40xx
endef

define Package/ltq-vdsl-vr11-mei_test/description
	Userland tool to directly control the mei driver, this is only needed
	for test and development purposes.
endef

MEI_DRV_CFLAGS= \
	-DMEI_SUPPORT_DSM=1 \
	-DMEI_TARGET_x86=0 \
	-I$(STAGING_DIR)/include

MAKE_FLAGS += \
	SHELL="$(BASH)"

CONFIGURE_ARGS += \
	--enable-kernelincl="$(LINUX_DIR)/include" \
	--enable-device=vr11 \
	--with-max-device=1 \
	--with-lines-per-device=1 \
	--enable-debug \
	--enable-error_print \
	--enable-ifxos-include="-I$(STAGING_DIR)/usr/include/ifxos/" \
	--enable-ifxos-library="-L$(STAGING_DIR)/usr/lib" \
	--enable-linux-26 \
	--enable-kernelbuild="$(LINUX_DIR)" \
	--enable-drv_test_appl=yes \
	ARCH=$(LINUX_KARCH)

# There was this line in CONFIGURE_ARGS
# --enable-add_drv_cflags="-DMEI_DRV_ATM_PTM_INTERFACE_ENABLE=1" \

CONFIGURE_ARGS += --enable-add_drv_cflags="${MEI_DRV_CFLAGS} -fno-pic -O2 -g0"

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include/vdsl
	$(CP) $(PKG_BUILD_DIR)/src/drv_mei_cpe_api_intern.h $(1)/usr/include/vdsl/
	$(CP) $(PKG_BUILD_DIR)/src/drv_mei_cpe_api_atm_ptm_intern.h $(1)/usr/include/vdsl/
	$(CP) $(PKG_BUILD_DIR)/src/drv_mei_cpe_interface.h $(1)/usr/include/vdsl
	$(CP) $(PKG_BUILD_DIR)/src/drv_mei_cpe_config.h $(1)/usr/include/vdsl/
	$(CP) $(PKG_BUILD_DIR)/src/cmv_message_format.h $(1)/usr/include/vdsl/
endef

$(eval $(call KernelPackage,ltq-vdsl-vr11-mei))

define Package/ltq-vdsl-vr11-mei_test/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/mei_cpe_drv_test $(1)/bin
endef

$(eval $(call BuildPackage,ltq-vdsl-vr11-mei_test))
