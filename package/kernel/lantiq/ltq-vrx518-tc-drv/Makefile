include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk


PKG_NAME:=ltq-vrx518-tc-drv
PKG_VERSION:=1.1.1
PKG_RELEASE:=4

PKG_BASE_NAME:=vrx518_tc_drv
PKG_VERSION_REVISION:=333c1357024faca227fba39a58744dda3332cc59
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_BASE_NAME)-$(PKG_VERSION)-$(PKG_VERSION_REVISION).tar.gz
PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_BASE_NAME)-$(PKG_VERSION)
PKG_SOURCE_URL:=https://sources.openwrt.org/
PKG_HASH:=0e037f613ee93102e66c50c35a9af1fe6d3690ed7176c1c5fef99d3db751c7e4
PKG_FIXUP:=autoreconf
PKG_FLAGS:=nonshared
PKG_LICENSE:=GPL-2.0 BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

PLAT_DIR:=dcdp

define KernelPackage/ltq-vrx518-tc-drv
	SECTION:=sys
	SUBMENU:=Network Devices
	TITLE:=VRX518 TC driver
	KCONFIG:= \
		CONFIG_VRX518_TC=m \
		CONFIG_VRX518_PCIE_SWITCH_BONDING=y \
		CONFIG_ATM=y \
		CONFIG_ATM_BR2684=y \
		CONFIG_ATM_LANE=y \
		CONFIG_ATM_CLIP=y \
		CONFIG_ATM_MPOA=y \
		CONFIG_ATM_BR2684_MINI_JUMBO_FRAME_SUPPORT=y \
		CONFIG_LTQ_DATAPATH_ACA_CSUM_WORKAROUND=y
	DEPENDS:=@TARGET_ipq40xx +kmod-ltq-vrx518-ep +ltq-vrx518-ppe-fw +ltq-vrx518-aca-fw +dsl-vrx500-firmware-xdsl-b
ifeq ($(CONFIG_TARGET_lantiq_xrx330),y)
	AUTOLOAD:=$(call AutoLoad,42,vrx518)
else
	AUTOLOAD:=$(call AutoLoad,26,vrx518_tc)
endif
	FILES:=$(PKG_BUILD_DIR)/$(PLAT_DIR)/vrx518_tc.$(LINUX_KMOD_SUFFIX)
	MENU:=1
endef

define KernelPackage/ltq-vrx518-tc-drv/description
	VRX518 TC Driver
endef

define KernelPackage/ltq-vrx518-tc-drv/config
	config vrx518_tc_drv_FEATURE_SELECT_CPUPATH
		depends on PACKAGE_kmod-ltq-vrx518-tc-drv
		bool "Select CPU Path"
		default n
		help
			Select CPU path. No dependency on any other library/function except linux kernel
			and works on any platform.
endef

MAKE_OPTS := FEATURE_VRX518_CPU=y

include $(INCLUDE_DIR)/kernel-defaults.mk

define Build/Prepare
	rm -rf $(PKG_BUILD_DIR)
	mkdir -p $(PKG_BUILD_DIR)
	$(PKG_UNPACK)
	dos2unix $(PKG_BUILD_DIR)/$(PLAT_DIR)/platform/*
	$(Build/Patch)
	#$(if $(CONFIG_vrx518_tc_drv_USE_CUSTOM_SOURCE_DIR),,$(CP) -L ./src/* $(PKG_BUILD_DIR)/)
	#$(if $(CONFIG_vrx518_tc_drv_USE_CUSTOM_SOURCE_DIR),,$(CP) -L ./* $(PKG_BUILD_DIR)/)
endef
	#$(call Build/Prepare/Default)

define Build/InstallDev
	$(INSTALL_DIR) $(1)/include/net/
	$(CP) $(PKG_BUILD_DIR)/$(PLAT_DIR)/inc/dsl_tc.h $(1)/include/net/
	# $(CP) $(PKG_BUILD_DIR)/$(PLAT_DIR)/inc/dsl_tc.h $(LINUX_DIR)/include/net/
	# $(CP) $(PKG_BUILD_DIR)/include/net/dc_ep.h $(LINUX_DIR)/include/net/
endef

NOSTDINC_FLAGS = \
	-I$(PKG_BUILD_DIR)/$(PLAT_DIR) \
	-I$(PKG_BUILD_DIR)/include \
	-I$(PKG_BUILD_DIR)/$(PLAT_DIR)/inc

define Build/Compile
	$(MAKE) $(MAKE_OPTS) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)/$(PLAT_DIR)" NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" modules
endef

define Build/Clean
	if [ -d "$(PKG_BUILD_DIR)" ]; then \
		$(MAKE) $(MAKE_OPTS) $(KERNEL_MAKEOPTS) SUBDIRS="$(PKG_BUILD_DIR)" clean; \
		$(RM) -r $(PKG_BUILD_DIR)/ipkg-$(BOARD); \
		$(RM) $(PKG_BUILD_DIR)/$(PLAT_DIR)/*.o; \
		$(RM) $(PKG_BUILD_DIR)/$(PLAT_DIR)/*.ko; \
	fi
endef

$(eval $(call KernelPackage,ltq-vrx518-tc-drv))
