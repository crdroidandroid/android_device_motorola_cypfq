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

    .model = "moto G51 5G",
    .name = "cypfq_g",
    .build_fingerprint = "motorola/cypfq_g/cypfq:12/S2RYAS32M.58-13-12-5-1-4/488d75:user/release-keys",
    .build_description = "cypfq_g-user 12 S2RYAS32M.58-13-12-5-1-4 488d75 test-keys",
};

static const std::vector<variant_info_t> variants = {
    global_info,
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
