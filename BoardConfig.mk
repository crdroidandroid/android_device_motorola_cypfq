#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/cypfq

# Inherit from motorola sm6375-common
include device/motorola/sm6375-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := cypfq

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml
ODM_MANIFEST_SKUS += b d dn n
ODM_MANIFEST_B_FILES := $(DEVICE_PATH)/sku/manifest_b.xml
ODM_MANIFEST_D_FILES := $(DEVICE_PATH)/sku/manifest_d.xml
ODM_MANIFEST_DN_FILES := $(DEVICE_PATH)/sku/manifest_dn.xml
ODM_MANIFEST_N_FILES := $(DEVICE_PATH)/sku/manifest_n.xml

# Kernel

BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_CONFIG := vendor/cypfq_defconfig
TARGET_KERNEL_LLVM_BINUTILS := true

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)

# Partitions
BOARD_USERDATAIMAGE_PARTITION_SIZE := 111537008640

BOARD_SUPER_PARTITION_SIZE := 13757317120
BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 6874464256

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_cypfq
TARGET_RECOVERY_DEVICE_MODULES := init_cypfq

# Security
VENDOR_SECURITY_PATCH := 2023-12-01

# inherit from the proprietary version
include vendor/motorola/cypfq/BoardConfigVendor.mk
