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

# Kernel
BOARD_BOOT_HEADER_VERSION ?= 3
BOARD_KERNEL_BASE ?= 0x00000000
BOARD_DTB_OFFSET ?= 0x01f00000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8
BOARD_KERNEL_CMDLINE += androidboot.hardware=qcom androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += androidboot.memcg=1 lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237
BOARD_KERNEL_CMDLINE += service_locator.enable=1 androidboot.usbcontroller=4e00000.dwc3
BOARD_KERNEL_CMDLINE += swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket
BOARD_KERNEL_CMDLINE += pcie_ports=compat loop.max_part=7 iptable_raw.raw_before_defrag=1
BOARD_KERNEL_CMDLINE += ip6table_raw.raw_before_defrag=1 androidboot.hab.csv=8
BOARD_KERNEL_CMDLINE += androidboot.hab.cid=50
BOARD_KERNEL_CMDLINE += androidboot.hab.product=cypfq
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware_mnt/image
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
TARGET_KERNEL_CONFIG := vendor/cypfq_defconfig
TARGET_KERNEL_SOURCE := kernel/motorola/cypfq

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)

# Clang
#TARGET_KERNEL_CLANG_VERSION := r450784e
TARGET_KERNEL_LLVM_BINUTILS := true

# Prebuilt
PREBUILT_KERNEL := true
ifeq ($(PREBUILT_KERNEL), true)
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/kernel/kernel
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/kernel/kernel:kernel
endif

# Partitions
BOARD_USERDATAIMAGE_PARTITION_SIZE := 102247673856

BOARD_PRODUCTIMAGE_PARTITION_SIZE := 2121900032
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1044381696
BOARD_SYSTEM_EXTIMAGE_PARTITION_SIZE := 780140544

BOARD_MOTOROLA_DYNAMIC_PARTITIONS_SIZE := 4961861632 # ((SUPER_PARTITION_SIZE / 2) - 4194304)
BOARD_SUPER_PARTITION_SIZE := 4966055936

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):init_cypfq
TARGET_RECOVERY_DEVICE_MODULES := init_cypfq

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/device_framework_matrix.xml

# Security
VENDOR_SECURITY_PATCH := 2023-12-01

# inherit from the proprietary version
include vendor/motorola/penang/BoardConfigVendor.mk
