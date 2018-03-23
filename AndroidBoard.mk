LOCAL_PATH := $(call my-dir)

#----------------------------------------------------------------------
# Compile Linux Kernel
#----------------------------------------------------------------------
ifeq ($(KERNEL_DEFCONFIG),)
    KERNEL_DEFCONFIG := sdm845_defconfig
endif

ifeq ($(TARGET_KERNEL_SOURCE),)
    TARGET_KERNEL_SOURCE := kernel
endif

# TODO:  Need to generate the sanitized kernel headers
#include $(TARGET_KERNEL_SOURCE)/AndroidKernel.mk
#
#$(INSTALLED_KERNEL_TARGET): $(TARGET_PREBUILT_KERNEL) | $(ACP)
#	$(transform-prebuilt-to-target)

#----------------------------------------------------------------------
# extra images
#----------------------------------------------------------------------
ifeq ($(TARGET_USES_QSSI),true)
  include vendor/qcom/opensource/core-utils/build/generate_extra_images.mk
else
  include device/qcom/common/generate_extra_images.mk
endif
