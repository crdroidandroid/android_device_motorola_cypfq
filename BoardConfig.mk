#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/penang

# Inherit from motorola sm6375-common
include device/motorola/sm6375-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := penang

# Kernel
BOARD_KERNEL_CMDLINE += androidboot.hab.product=penang
#TARGET_KERNEL_CONFIG := vendor/holi-qgki_defconfig

BOARD_KERNEL_BINARIES := kernel
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)-kernel/dtbo.img
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)-kernel/kernel
TARGET_KERNEL_CONFIG := holi_QGKI
TARGET_PREBUILT_DTB := $(DEVICE_PATH)-kernel/dtb.img
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)-kernel/dtb.img:$(TARGET_COPY_OUT)/dtb.img \
    $(DEVICE_PATH)-kernel/kernel:kernel \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)-kernel/ramdisk-modules/,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules) \
    $(call find-copy-subdir-files,*,$(DEVICE_PATH)-kernel/vendor-modules/,$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules)

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES := \
    $(wildcard $(DEVICE_PATH)-kernel/vendor-modules/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)

# Partitions
BOARD_USERDATAIMAGE_PARTITION_SIZE := 102247673856

BOARD_PRODUCTIMAGE_PARTITION_SIZE := 2121900032
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1044381696
BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE := 780140544

BOARD_MOT_DP_GROUP_SIZE := 4961861632 # ((SUPER_PARTITION_SIZE / 2) - 4194304)
BOARD_SUPER_PARTITION_SIZE := 4966055936

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)

# Security
VENDOR_SECURITY_PATCH := 2023-09-01

# inherit from the proprietary version
include vendor/motorola/penang/BoardConfigVendor.mk
