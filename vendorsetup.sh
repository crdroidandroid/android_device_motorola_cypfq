#!/bin/bash

# Clone Kernel Source
git clone https://github.com/cypfq-development/android_kernel_motorola_cypfq kernel/motorola/sm6375

#Clone vendor and vendor common
git clone https://github.com/cypfq-development/proprietary_vendor_motorola_sm6375-common vendor/motorola/sm6375-common

git clone https://github.com/cypfq-development/proprietary_vendor_motorola_cypfq vendor/motorola/cypfq

# Clone Device common
git clone https://github.com/cypfq-development/android_device_motorola_sm6375-common device/motorola/sm6375-common

# Clonar el repositorio android_system_qcom en el directorio system/qcom
git clone https://github.com/LineageOS/android_system_qcom system/qcom

# Hardware Motorola
git clone https://github.com/LineageOS/android_hardware_motorola hardware/motorola

# Clonar el repositorio packages_apps_ViPER4AndroidFX
git clone https://github.com/TogoFire/packages_apps_ViPER4AndroidFX packages/apps/ViPER4AndroidFX

# Clonar bcr
git clone https://github.com/kenway214/vendor_bcr.git vendor/bcr

# Configurar el uso de ccache
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
ccache -M 50G
ccache -o compression=true
