LOCAL_PATH := $(call my-dir)

#----------------------------------------------------------------------
# Compile Linux Kernel
#----------------------------------------------------------------------
ifeq ($(KERNEL_DEFCONFIG),)
    KERNEL_DEFCONFIG := sdm845_defconfig
    ifeq ($(wildcard kernel/msm-$(TARGET_KERNEL_VERSION)/arch/arm64/configs/$(KERNEL_DEFCONFIG)),)
        KERNEL_DEFCONFIG := $(shell ls ./kernel/msm-$(TARGET_KERNEL_VERSION)/arch/arm64/configs/ | grep sm8..._defconfig)
    endif
endif

ifeq ($(TARGET_KERNEL_SOURCE),)
    TARGET_KERNEL_SOURCE := kernel
endif

KERNEL_MAJOR := $(shell echo $(TARGET_KERNEL_VERSION) | cut -f1 -d .)
KERNEL_MINOR := $(shell echo $(TARGET_KERNEL_VERSION) | cut -f2 -d .)
ifeq ($(shell [ $(KERNEL_MAJOR) -gt 4 -o \( $(KERNEL_MAJOR) -eq 4 -a $(KERNEL_MINOR) -ge 14 \) ] && echo true),true)
  #Enable llvm support for kernel
  KERNEL_LLVM_SUPPORT := true

  #Enable sd-llvm suppport for kernel
  KERNEL_SD_LLVM_SUPPORT := true

  DTC := $(HOST_OUT_EXECUTABLES)/dtc$(HOST_EXECUTABLE_SUFFIX)

  TARGET_KERNEL_MAKE_ENV := DTC_EXT=dtc$(HOST_EXECUTABLE_SUFFIX)
  TARGET_KERNEL_MAKE_ENV += CONFIG_BUILD_ARM64_DT_OVERLAY=y
endif


# TODO:  Need to generate the sanitized kernel headers
include $(TARGET_KERNEL_SOURCE)/AndroidKernel.mk

$(TARGET_PREBUILT_KERNEL): $(DTC)

$(INSTALLED_KERNEL_TARGET): $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

#----------------------------------------------------------------------
# extra images
#----------------------------------------------------------------------
#ifeq ($(TARGET_USES_QSSI),true)
#  include vendor/qcom/opensource/core-utils/build/generate_extra_images.mk
#else
#  include device/qcom/common/generate_extra_images.mk
#endif
