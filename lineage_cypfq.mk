#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from penang device
$(call inherit-product, device/motorola/cypfq/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_cypfq
PRODUCT_DEVICE := cypfq
PRODUCT_MANUFACTURER := motorola
PRODUCT_BRAND := motorola
PRODUCT_MODEL := Moto G51 5G

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=cypfq_g \
    PRIVATE_BUILD_DESC="cypfq_g-user 12 S2RYAS32M.58-13-12-5-1-4 488d75 test-keys"

BUILD_FINGERPRINT := motorola/cypfq_g/cypfq:12/S2RYAS32M.58-13-12-5-1-4/488d75:user/release-keys
