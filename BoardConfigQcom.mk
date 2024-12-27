ifeq ($(QCOM_HARDWARE_VARIANT),)
include device/qcom/common/qcom_hardware.mk
endif

# Audio
TARGET_USES_QCOM_MM_AUDIO := true
TARGET_USES_QCOM_AUDIO_AR ?= $(if $(filter $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),true,false)

# Media
MASTER_SIDE_CP_TARGET_LIST := msm8996 $(UM_4_4_FAMILY) $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY)
TARGET_USES_MEDIA_EXTENSIONS := true

# Display
BOARD_USES_ADRENO ?= true
TARGET_DISPLAY_SHIFT_HORIZONTAL ?= 0
TARGET_DISPLAY_SHIFT_VERTICAL ?= 0
TARGET_USES_COLOR_METADATA ?= true
TARGET_USES_DRM_PP ?= $(if $(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY) $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),true,false)
TARGET_USES_GRALLOC4 ?= $(if $(filter $(UM_5_4_FAMILY) $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),true,false)
TARGET_USES_FOD_ZPOS ?= false
TARGET_HAS_WIDE_COLOR_DISPLAY ?= $(if $(filter $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY) $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),true,false)
$(call soong_config_set,qtidisplay,headless,false)
$(call soong_config_set,qtidisplay,llvmsa,false)
$(call soong_config_set,qtidisplay,default,true)
$(call soong_config_set,qtidisplay,var1,false)
$(call soong_config_set,qtidisplay,var2,false)
$(call soong_config_set,qtidisplay,var3,false)
$(call soong_config_set,qtidisplay,displayconfig_enabled,$(if $(filter $(UM_PLATFORMS),$(TARGET_BOARD_PLATFORM)),true,false))
$(call soong_config_set,qtidisplay,drmpp,$(TARGET_USES_DRM_PP))
$(call soong_config_set,qtidisplay,gralloc4,$(TARGET_USES_GRALLOC4))
$(call soong_config_set,qtidisplay,udfps,$(TARGET_USES_FOD_ZPOS))
$(call soong_config_set,qtidisplay,shift_horizontal,$(TARGET_DISPLAY_SHIFT_HORIZONTAL))
$(call soong_config_set,qtidisplay,shift_vertical,$(TARGET_DISPLAY_SHIFT_VERTICAL))
$(call soong_config_set,qtidisplay,wide_color,$(TARGET_HAS_WIDE_COLOR_DISPLAY))

# Gralloc
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS ?= 0
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 13) # GRALLOC_USAGE_EXTERNAL_DISP
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 21) # GRALLOC_USAGE_PRIVATE_WFD
ifneq ($(filter $(UM_4_9_FAMILY) $(UM_4_14_FAMILY) $(UM_4_19_FAMILY) $(UM_5_4_FAMILY) $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS += | (1 << 27) # GRALLOC_USAGE_PRIVATE_HEIF_VIDEO
endif
ifneq ($(filter $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    TARGET_GRALLOC_HANDLE_HAS_CUSTOM_CONTENT_MD_RESERVED_SIZE ?= true
    TARGET_GRALLOC_HANDLE_HAS_RESERVED_SIZE ?= true
endif

# Kernel
TARGET_COMPILE_WITH_MSM_KERNEL := true

# Thermal HAL
$(call soong_config_set,qti_thermal,netlink,$(if $(filter $(UM_5_10_FAMILY) $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),true,false))

# Rmnet
ifeq ($(filter $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),)
    $(call soong_config_set,rmnetctl,old_rmnet_data,$(if $(filter $(UM_5_15_FAMILY),$(TARGET_BOARD_PLATFORM)),false,true))
endif
