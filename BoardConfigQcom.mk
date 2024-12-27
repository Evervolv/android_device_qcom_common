ifeq ($(QCOM_HARDWARE_VARIANT),)
include device/qcom/common/qcom_hardware.mk
endif

BOARD_USES_ADRENO := true

# Disable thermal HAL netlink framework on UM platforms that do not support it
ifneq ($(filter $(LEGACY_UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
    $(call soong_config_set,qti_thermal,netlink,false)
endif

# Add qtidisplay to soong config namespaces
SOONG_CONFIG_NAMESPACES += qtidisplay

# Add supported variables to qtidisplay config
SOONG_CONFIG_qtidisplay += \
    drmpp \
    headless \
    llvmsa \
    gralloc4 \
    displayconfig_enabled \
    udfps \
    default \
    shift_horizontal \
    shift_vertical \
    var1 \
    var2 \
    var3 \
    wide_color \
    target_no_raw10_custom_format \
    target_uses_unaligned_nv21_zsl \
    target_uses_unaligned_ycrcb \
    target_uses_ycrcb_camera_encode \
    target_uses_ycrcb_camera_preview \
    target_uses_ycrcb_venus_camera_preview

# Set default values for qtidisplay config
SOONG_CONFIG_qtidisplay_drmpp ?= false
SOONG_CONFIG_qtidisplay_headless ?= false
SOONG_CONFIG_qtidisplay_llvmsa ?= false
SOONG_CONFIG_qtidisplay_gralloc4 ?= false
SOONG_CONFIG_qtidisplay_displayconfig_enabled ?= false
SOONG_CONFIG_qtidisplay_udfps ?= false
SOONG_CONFIG_qtidisplay_default ?= true
SOONG_CONFIG_qtidisplay_shift_horizontal ?= 0
SOONG_CONFIG_qtidisplay_shift_vertical ?= 0
SOONG_CONFIG_qtidisplay_var1 ?= false
SOONG_CONFIG_qtidisplay_var2 ?= false
SOONG_CONFIG_qtidisplay_var3 ?= false
SOONG_CONFIG_qtidisplay_wide_color ?= false
SOONG_CONFIG_qtidisplay_target_no_raw10_custom_format ?= false
SOONG_CONFIG_qtidisplay_target_uses_unaligned_nv21_zsl ?= false
SOONG_CONFIG_qtidisplay_target_uses_unaligned_ycrcb ?= false
SOONG_CONFIG_qtidisplay_target_uses_ycrcb_camera_encode ?= false
SOONG_CONFIG_qtidisplay_target_uses_ycrcb_camera_preview ?= false
SOONG_CONFIG_qtidisplay_target_uses_ycrcb_venus_camera_preview ?= false

ifneq ($(TARGET_DISPLAY_SHIFT_HORIZONTAL),)
    SOONG_CONFIG_qtidisplay_shift_horizontal := $(TARGET_DISPLAY_SHIFT_HORIZONTAL)
endif

ifneq ($(TARGET_DISPLAY_SHIFT_VERTICAL),)
    SOONG_CONFIG_qtidisplay_shift_vertical := $(TARGET_DISPLAY_SHIFT_VERTICAL)
endif

ifeq ($(TARGET_HAS_WIDE_COLOR_DISPLAY), true)
    SOONG_CONFIG_qtidisplay_wide_color := true
endif

ifeq ($(TARGET_USES_FOD_ZPOS),true)
    SOONG_CONFIG_qtidisplay_udfps := true
endif

# For libgrallocutils features
ifeq ($(TARGET_NO_RAW10_CUSTOM_FORMAT),true)
    SOONG_CONFIG_qtidisplay_target_no_raw10_custom_format := true
endif

ifeq ($(TARGET_USES_UNALIGNED_NV21_ZSL),true)
    SOONG_CONFIG_qtidisplay_target_uses_unaligned_nv21_zsl := true
endif

ifeq ($(TARGET_USES_UNALIGNED_YCRCB),true)
    SOONG_CONFIG_qtidisplay_target_uses_unaligned_ycrcb := true
endif

ifeq ($(TARGET_USES_YCRCB_CAMERA_ENCODE),true)
    SOONG_CONFIG_qtidisplay_target_uses_ycrcb_camera_encode := true
endif

ifeq ($(TARGET_USES_YCRCB_CAMERA_PREVIEW),true)
    SOONG_CONFIG_qtidisplay_target_uses_ycrcb_camera_preview := true
else ifeq ($(TARGET_USES_YCRCB_VENUS_CAMERA_PREVIEW),true)
    SOONG_CONFIG_qtidisplay_target_uses_ycrcb_venus_camera_preview := true
endif

# Add rmnetctl to soong config namespaces
SOONG_CONFIG_NAMESPACES += rmnetctl

# Add supported variables to rmnetctl config
SOONG_CONFIG_rmnetctl += \
    old_rmnet_data

# Set default values for rmnetctl config
SOONG_CONFIG_rmnetctl_old_rmnet_data ?= false

# Tell HALs that we're compiling an AOSP build with an in-line kernel
TARGET_COMPILE_WITH_MSM_KERNEL := true

# Enable media extensions
TARGET_USES_MEDIA_EXTENSIONS := true

# Allow building audio encoders
TARGET_USES_QCOM_MM_AUDIO := true

# Enable color metadata
TARGET_USES_COLOR_METADATA := true

# Enable DRM PP driver on UM platforms that support it
ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY) $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    SOONG_CONFIG_qtidisplay_drmpp := true
    TARGET_USES_DRM_PP := true
endif

# Enable Gralloc4 on UM platforms that support it
ifneq ($(filter $(UM_5_4_FAMILY) $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    SOONG_CONFIG_qtidisplay_gralloc4 := true
endif

# Select AR variant of A-HAL dependencies
ifneq ($(filter $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_USES_QCOM_AUDIO_AR ?= true
endif

# Enable displayconfig on every UM platform
ifeq ($(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),)
    SOONG_CONFIG_qtidisplay_displayconfig_enabled := true
endif

TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0

# Mark GRALLOC_USAGE_EXTERNAL_DISP as valid gralloc bit
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 13)

# Mark GRALLOC_USAGE_PRIVATE_WFD as valid gralloc bit
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 21)

# Mark GRALLOC_USAGE_PRIVATE_HEIF_VIDEO as valid gralloc bit on UM platforms that support it
ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY) $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 27)
endif

# List of targets that use master side content protection
MASTER_SIDE_CP_TARGET_LIST := msm8996 $(UM_4_4_FAMILY) $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY)

# Opt-in for old rmnet_data driver
ifeq ($(filter $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    SOONG_CONFIG_rmnetctl_old_rmnet_data := true
endif

# Use full QTI gralloc struct for GKI 2.0 targets
ifneq ($(filter $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE ?= true
    TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= true
endif
