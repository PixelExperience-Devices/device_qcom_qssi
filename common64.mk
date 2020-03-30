$(call inherit-product, device/qcom/qssi/base.mk)

# For PRODUCT_COPY_FILES, the first instance takes precedence.
# Since we want use QC specific files, we should inherit
# device-vendor.mk first to make sure QC specific files gets installed.
$(call inherit-product-if-exists, $(QCPATH)/common/config/device-vendor-qssi.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

PRODUCT_BRAND := qcom
PRODUCT_AAPT_CONFIG += hdpi mdpi

PRODUCT_MANUFACTURER := QUALCOMM

PRODUCT_PROPERTY_OVERRIDES += \
    persist.backup.ntpServer=0.pool.ntp.org \
    sys.vendor.shutdown.waittime=500

ifneq ($(BOARD_FRP_PARTITION_NAME),)
    PRODUCT_PROPERTY_OVERRIDES += ro.frp.pst=/dev/block/bootdevice/by-name/$(BOARD_FRP_PARTITION_NAME)
else
    PRODUCT_PROPERTY_OVERRIDES += ro.frp.pst=/dev/block/bootdevice/by-name/config
endif

# whitelisted app
PRODUCT_COPY_FILES += \
    device/qcom/qssi/qti_whitelist.xml:system/etc/sysconfig/qti_whitelist.xml \
    device/qcom/qssi/qti_whitelist_system_ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/qti_whitelist_system_ext.xml

PRODUCT_COPY_FILES += \
    device/qcom/qssi/privapp-permissions-qti.xml:system/etc/permissions/privapp-permissions-qti.xml \
    device/qcom/qssi/privapp-permissions-qti-system-ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-qti-system-ext.xml

PRODUCT_PRIVATE_KEY := vendor/qcom/opensource/core-utils/build/qcom.key

ifneq ($(TARGET_DEFINES_DALVIK_HEAP), true)
ifneq ($(TARGET_HAS_LOW_RAM), true)
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)
endif
endif

#$(call inherit-product, frameworks/base/data/fonts/fonts.mk)
#$(call inherit-product, frameworks/base/data/keyboards/keyboards.mk)
