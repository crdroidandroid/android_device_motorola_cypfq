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
    .build_description = "penang_g-user 13 T1TPS33M.1-73-2-2 723bee5 release-keys",
};

static const variant_info_t ym_info = {
    .sku_value = "XT2335-4",

    .model = "moto g53y 5G",
    .name = "penang_sb",
    .build_fingerprint = "motorola/penang_sb/penang:13/T1TPJ33M.75-17-3/9c2f6:user/release-keys",
    .build_description = "penang_sb-user 13 T1TPJ33M.75-17-3 9c2f6 release-keys",
};

static const std::vector<variant_info_t> variants = {
    global_info,
    ym_info,
};

static void workaround_snet_properties() {
    chmod("/sys/fs/selinux/enforce", 0640);
    chmod("/sys/fs/selinux/policy", 0440);
}

void vendor_load_properties() {
    search_variant(variants);
    set_dalvik_heap();

    // Workaround SafetyNet
    workaround_snet_properties();
}
