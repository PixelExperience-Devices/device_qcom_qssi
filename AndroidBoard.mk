LOCAL_PATH := $(call my-dir)

#----------------------------------------------------------------------
# Host compiler configs
# #---------------------------------------------------------------------
SOURCE_ROOT := $(shell pwd)

TARGET_HOST_CC_OVERRIDE  := $(shell pwd)/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/bin/x86_64-linux-gcc
TARGET_HOST_CXX_OVERRIDE := $(shell pwd)/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/bin/x86_64-linux-g++
TARGET_HOST_AR_OVERRIDE  := $(shell pwd)/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/bin/x86_64-linux-ar
TARGET_HOST_LD_OVERRIDE  := $(shell pwd)/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8/bin/x86_64-linux-ld


#----------------------------------------------------------------------
# Compile (L)ittle (K)ernel bootloader and the nandwrite utility
#----------------------------------------------------------------------
ifneq ($(strip $(TARGET_NO_BOOTLOADER)),true)

# Compile
include bootable/bootloader/edk2/AndroidBoot.mk

$(INSTALLED_BOOTLOADER_MODULE): $(TARGET_EMMC_BOOTLOADER) | $(ACP)
	$(transform-prebuilt-to-target)
$(BUILT_TARGET_FILES_PACKAGE): $(INSTALLED_BOOTLOADER_MODULE)

droidcore: $(INSTALLED_BOOTLOADER_MODULE)
endif


DTC := $(HOST_OUT_EXECUTABLES)/dtc$(HOST_EXECUTABLE_SUFFIX)
UFDT_APPLY_OVERLAY := $(HOST_OUT_EXECUTABLES)/ufdt_apply_overlay$(HOST_EXECUTABLE_SUFFIX)



# ../../ prepended to paths because kernel is at ./kernel/msm-x.x


PWD := $(shell pwd)
TARGET_KERNEL_MAKE_ENV := DTC_EXT=dtc$(HOST_EXECUTABLE_SUFFIX)
TARGET_KERNEL_MAKE_ENV += DTC_OVERLAY_TEST_EXT=$(PWD)/$(UFDT_APPLY_OVERLAY)
TARGET_KERNEL_MAKE_ENV += CONFIG_BUILD_ARM64_DT_OVERLAY=y
TARGET_KERNEL_MAKE_ENV += HOSTCC=$(TARGET_HOST_CC_OVERRIDE)
TARGET_KERNEL_MAKE_ENV += HOSTAR=$(TARGET_HOST_AR_OVERRIDE)
TARGET_KERNEL_MAKE_ENV += HOSTLD=$(TARGET_HOST_LD_OVERRIDE)
ifeq ($(TARGET_USES_NEW_ION), false)
TARGET_KERNEL_MAKE_ENV += HOSTCFLAGS="-I/usr/include -I/usr/include/x86_64-linux-gnu -L/usr/lib -L/usr/lib/x86_64-linux-gnu"
else
TARGET_KERNEL_MAKE_ENV += HOSTCFLAGS="-I$(shell pwd)/kernel/msm-4.14/include/uapi -I/usr/include -I/usr/include/x86_64-linux-gnu -L/usr/lib -L/usr/lib/x86_64-linux-gnu"
endif
TARGET_KERNEL_MAKE_ENV += HOSTLDFLAGS="-L/usr/lib -L/usr/lib/x86_64-linux-gnu"
KERNEL_LLVM_BIN := $(lastword $(sort $(wildcard $(shell pwd)/$(LLVM_PREBUILTS_BASE)/$(BUILD_OS)-x86/clang-4*)))/bin/clang


$(warning Kernel source tree path is: $(TARGET_KERNEL_SOURCE))
$(warning Kernel version  is: $(TARGET_KERNEL_VERSION))
$(warning Kernel version  is: $(KERNEL_DEFCONFIG))
include $(TARGET_KERNEL_SOURCE)/AndroidKernel.mk
$(TARGET_PREBUILT_KERNEL): $(DTC) $(UFDT_APPLY_OVERLAY)

$(INSTALLED_KERNEL_TARGET): $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

#----------------------------------------------------------------------
# Copy additional target-specific files
#----------------------------------------------------------------------
include $(CLEAR_VARS)
LOCAL_MODULE       := vold.fstab
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)


include $(CLEAR_VARS)
LOCAL_MODULE       := gpio-keys.kl
LOCAL_MODULE_TAGS  := optional eng
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES    := $(LOCAL_MODULE)
LOCAL_MODULE_PATH  := $(TARGET_OUT_KEYLAYOUT)
include $(BUILD_PREBUILT)

#----------------------------------------------------------------------
# Radio image
#----------------------------------------------------------------------
ifeq ($(ADD_RADIO_FILES), true)
radio_dir := $(LOCAL_PATH)/radio
RADIO_FILES := $(shell cd $(radio_dir) ; ls)
$(foreach f, $(RADIO_FILES), \
	$(call add-radio-file,radio/$(f)))
endif

#----------------------------------------------------------------------
# extra images
#----------------------------------------------------------------------
ifeq ($(TARGET_PRODUCT),qssi)
include device/qcom/common/generate_extra_images.mk
endif

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
ifeq ($(TARGET_PRODUCT),qssi)
ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
include device/qcom/wlan/msmnile/AndroidBoardWlan.mk
endif
endif

#create firmware directory for qssi
$(shell  mkdir -p $(TARGET_OUT_VENDOR)/firmware)
