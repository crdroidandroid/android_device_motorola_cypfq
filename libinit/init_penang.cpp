/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_dalvik_heap.h>
#include <libinit_variant.h>
#include <libinit_utils.h>

#include <sys/stat.h>

#include "vendor_init.h"

static const variant_info_t global_info = {
    .sku_value = "XT2335-5",

    .model = "moto g53j 5G",
    .name = "penang_g",
    .build_fingerprint = "motorola/penang_g/penang:13/T1TPS33M.1-73-2-2/723bee5:user/release-keys",
};

static const variant_info_t ym_info = {
    .sku_value = "XT2335-4",

    .model = "moto g53y 5G",
    .name = "penang_sb",
    .build_fingerprint = "motorola/penang_sb/penang:13/T1TPJ33M.75-17-3/9c2f6:user/release-keys",
};

static const std::vector<variant_info_t> variants = {
    global_info,
    ym_info,
};

/* From Magisk@jni/magiskhide/hide_utils.c */
static const char *snet_prop_key[] = {
    "ro.boot.vbmeta.device_state",
    "ro.boot.verifiedbootstate",
    "ro.boot.flash.locked",
    "ro.boot.selinux",
    "ro.boot.veritymode",
    "ro.boot.warranty_bit",
    "ro.warranty_bit",
    "ro.debuggable",
    "ro.secure",
    "ro.build.type",
    "ro.build.tags",
    "ro.build.selinux",
    "sys.oem_unlock_allowed",
    NULL
};

static const char *snet_prop_value[] = {
    "locked",
    "green",
    "1",
    "enforcing",
    "enforcing",
    "0",
    "0",
    "0",
    "1",
    "user",
    "release-keys",
    "1",
    "0",
    NULL
};

static void workaround_snet_properties() {

    // Hide all sensitive props
    for (int i = 0; snet_prop_key[i]; ++i) {
        property_override(snet_prop_key[i], snet_prop_value[i]);
    }

    chmod("/sys/fs/selinux/enforce", 0640);
    chmod("/sys/fs/selinux/policy", 0440);
}

void vendor_load_properties() {
    search_variant(variants);
    set_dalvik_heap();

    // Workaround SafetyNet
    workaround_snet_properties();
}
