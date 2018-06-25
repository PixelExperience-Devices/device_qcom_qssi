DEVICE_DIR := $(call my-dir)

##########
# QTI platform name
# - use for TARGET_BOARD_PLATFORM logic during compile-time and runtime
# - for QSSI target, the reference chipset for compilation
VENDOR_QTI_PLATFORM := sdm845
VENDOR_QTI_DEVICE := qssi

##########
# QSSI configuration
# - Single System Image project structure
TARGET_USES_QSSI := true

# Enable AVB 2.0
BOARD_AVB_ENABLE := true

TARGET_DEFINES_DALVIK_HEAP := true


$(call inherit-product, device/qcom/$(VENDOR_QTI_DEVICE)/common64.mk)

PRODUCT_NAME := qssi
PRODUCT_DEVICE := $(VENDOR_QTI_DEVICE)
PRODUCT_MODEL := QSSI system image for arm64

#Inherit all except heap growth limit from phone-xhdpi-2048-dalvik-heap.mk
PRODUCT_PROPERTY_OVERRIDES  += \
  dalvik.vm.heapstartsize=8m \
  dalvik.vm.heapsize=512m \
  dalvik.vm.heaptargetutilization=0.75 \
  dalvik.vm.heapminfree=512k \
  dalvik.vm.heapmaxfree=8m

# system prop for opengles version
#
# 196608 is decimal for 0x30000 to report version 3
# 196609 is decimal for 0x30001 to report version 3.1
# 196610 is decimal for 0x30002 to report version 3.2
PRODUCT_PROPERTY_OVERRIDES  += \
  ro.opengles.version=196610

# Default A/B configuration.
ENABLE_AB ?= true

TARGET_KERNEL_VERSION := 4.9
TARGET_KERNEL_VERSION ?= $(patsubst kernel/msm-%,%,$(firstword $(wildcard kernel/msm-*)))
ifeq ($(TARGET_KERNEL_VERSION),)
  $(error Unable to find a usable kernel tree at kernel/msm-*)
endif

TARGET_USES_NQ_NFC := false
ifeq ($(TARGET_USES_NQ_NFC),true)
# Flag to enable and support NQ3XX chipsets
NQ3XX_PRESENT := true
endif

# default is nosdcard, S/W button enabled in resource
PRODUCT_CHARACTERISTICS := nosdcard

BOARD_FRP_PARTITION_NAME := frp

# WLAN chipset
WLAN_CHIPSET := qca_cld3

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

-include $(QCPATH)/common/config/qtic-config.mk

PRODUCT_BOOT_JARS += telephony-ext \
                     tcmiface
PRODUCT_PACKAGES += telephony-ext
TARGET_ENABLE_QC_AV_ENHANCEMENTS := false

TARGET_DISABLE_DASH := true

ifneq ($(TARGET_DISABLE_DASH), true)
    PRODUCT_BOOT_JARS += qcmediaplayer
endif

PRODUCT_PACKAGES += android.hardware.media.omx@1.0-impl

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/qssi/qssi.mk

PRODUCT_PACKAGES += fs_config_files

ifeq ($(ENABLE_AB), true)
#A/B related packages
PRODUCT_PACKAGES += update_engine \
    update_engine_client \
    update_verifier \
    brillo_update_payload \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service

#Boot control HAL test app
PRODUCT_PACKAGES_DEBUG += bootctl
endif

#DEVICE_MANIFEST_FILE := device/qcom/qssi/manifest.xml
#DEVICE_MATRIX_FILE   := device/qcom/qssi/compatibility_matrix.xml

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener

# Display/Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.mapper@2.0-impl-qti-display \
    vendor.qti.hardware.display.allocator@1.0-service \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service \
    android.hardware.configstore@1.0-service \
    android.hardware.broadcastradio@1.0-impl \
    modetest

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service \

# Camera configuration file. Shared by passthrough/binderized camera HAL
PRODUCT_PACKAGES += camera.device@3.2-impl
PRODUCT_PACKAGES += camera.device@1.0-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-impl
# Enable binderized camera HAL
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-service

PRODUCT_PACKAGES += android.hardware.usb@1.0-service

# WLAN host driver
ifneq ($(WLAN_CHIPSET),)
PRODUCT_PACKAGES += $(WLAN_CHIPSET)_wlan.ko
endif

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

#for wlan
PRODUCT_PACKAGES += \
    wificond \
    wifilogd

#Enable debug libraries
ifeq ($(TARGET_BUILD_VARIANT),userdebug)
PRODUCT_PACKAGES += libstagefright_debug \
                    libmediaplayerservice_debug
endif

# Kernel modules install path
KERNEL_MODULES_INSTALL := dlkm
KERNEL_MODULES_OUT := out/target/product/$(PRODUCT_NAME)/$(KERNEL_MODULES_INSTALL)/lib/modules

#Enable full treble flag

#Add soft home, back and multitask keys
PRODUCT_PROPERTY_OVERRIDES += \
    qemu.hw.mainkeys=0

# system prop for opengles version
#
# 196608 is decimal for 0x30000 to report version 3
# 196609 is decimal for 0x30001 to report version 3.1
# 196610 is decimal for 0x30002 to report version 3.2
PRODUCT_PROPERTY_OVERRIDES  += \
    ro.opengles.version=196610

#system prop for bluetooth SOC type
PRODUCT_PROPERTY_OVERRIDES += \
    qcom.bluetooth.soc=cherokee

PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true

PRODUCT_PROPERTY_OVERRIDES += rild.libpath=/vendor/lib64/libril-qc-hal-qmi.so

#Enable QTI KEYMASTER and GATEKEEPER HIDLs
KMGK_USE_QTI_SERVICE := true

DEVICE_PACKAGE_OVERLAYS += device/qcom/qssi/overlay

#VR
PRODUCT_PACKAGES += android.hardware.vr@1.0-impl \
                    android.hardware.vr@1.0-service
#Thermal
PRODUCT_PACKAGES += android.hardware.thermal@1.0-impl \
                    android.hardware.thermal@1.0-service

# for HIDL related packages
PRODUCT_PACKAGES += \
  android.hardware.audio@2.0-service \
  android.hardware.audio@2.0-impl \
  android.hardware.audio.effect@2.0-impl \
  android.hardware.soundtrigger@2.0-impl

# Camera HIDL configuration file. Shared by passthrough/binderized camera HAL
PRODUCT_PACKAGES += camera.device@3.2-impl
PRODUCT_PACKAGES += camera.device@1.0-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-impl
# Enable binderized camera HAL
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-service

TARGET_SCVE_DISABLED := true
#TARGET_USES_QTIC := false
#TARGET_USES_QTIC_EXTENSION := false

SDM845_DISABLE_MODULE := true

ENABLE_VENDOR_RIL_SERVICE := true
