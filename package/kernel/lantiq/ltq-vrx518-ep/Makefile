include $(TOPDIR)/rules.mk

PKG_NAME:=ltq-vrx518
PKG_RELEASE=2

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

PKG_SOURCE_URL:=https://github.com/blocktrron/vrx518-pcie.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2018-12-06
PKG_SOURCE_VERSION:=0a301512ab063d82bd324d53f16379cdc3825e26

PKG_MAINTAINER:=David Bauer <mail@david-bauer.net>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

VRX518_MAKEDEFS += CONFIG_VRX518=m

define KernelPackage/ltq-vrx518-ep
	SECTION:=sys
	SUBMENU:=Network Devices
	TITLE:=PCIe driver for Intel VRX518
	FILES:=\
		$(PKG_BUILD_DIR)/vrx518.ko
	AUTOLOAD:=$(call AutoLoad,25,vrx518)
endef

define KernelPackage/ltq-vrx518-ep/description
	VRX518 endpoint driver
endef

NOSTDINC_FLAGS = \
	-I$(PKG_BUILD_DIR) \
	-I$(PKG_BUILD_DIR)/include

ifneq ($(findstring c,$(OPENWRT_VERBOSE)),)
	VRX518_MAKEDEFS += V=1
endif

define Build/Compile
	+$(MAKE) $(VRX518_MAKEDEFS) $(PKG_JOBS) -C "$(LINUX_DIR)" \
		$(KERNEL_MAKE_FLAGS) \
		SUBDIRS="$(PKG_BUILD_DIR)" \
		NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
		modules
endef

define Build/InstallDev
	$(INSTALL_DIR) $(LINUX_DIR)/include
	$(CP) $(PKG_BUILD_DIR)/tc/inc/dsl_tc.h $(LINUX_DIR)/include/net/
	$(CP) $(PKG_BUILD_DIR)/include/net/dc_ep.h $(LINUX_DIR)/include/net/
endef

$(eval $(call KernelPackage,ltq-vrx518-ep))
