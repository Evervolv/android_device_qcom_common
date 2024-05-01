# Platform name variables - used in makefiles everywhere
MSMSTEPPE := sm6150
TRINKET := trinket #SM6125

# UM families
UM_3_18_FAMILY := msm8996 msm8937 msm8953
UM_4_4_FAMILY := msm8998 sdm660
UM_4_9_FAMILY := sdm845 sdm710
UM_4_14_FAMILY := msmnile $(MSMSTEPPE) $(TRINKET) atoll
UM_4_19_FAMILY := kona lito bengal
UM_5_4_FAMILY := lahaina holi
UM_5_10_FAMILY := taro parrot
UM_5_15_FAMILY := kalama crow

LEGACY_UM_PLATFORMS := \
    $(UM_3_18_FAMILY) \
    $(UM_4_4_FAMILY) \
    $(UM_4_9_FAMILY) \
    $(UM_4_14_FAMILY) \
    $(UM_4_19_FAMILY) \
    $(UM_5_4_FAMILY)

UM_PLATFORMS := \
    $(UM_3_18_FAMILY) \
    $(UM_4_4_FAMILY) \
    $(UM_4_9_FAMILY) \
    $(UM_4_14_FAMILY) \
    $(UM_4_19_FAMILY) \
    $(UM_5_4_FAMILY) \
    $(UM_5_10_FAMILY) \
    $(UM_5_15_FAMILY)

# Upgraded legacy families
UM_4_9_LEGACY_FAMILY :=
UM_4_19_LEGACY_FAMILY :=
ifeq ($(TARGET_ENFORCES_QSSI),true)
UM_3_18_FAMILY := msm8996
UM_4_4_FAMILY := msm8998
UM_4_9_LEGACY_FAMILY += msm8937 msm8953
UM_4_19_LEGACY_FAMILY += sdm660
endif

# QSSI families
QSSI_SUPPORTED_PLATFORMS := \
    $(UM_4_9_FAMILY) \
    $(UM_4_9_LEGACY_FAMILY) \
    $(UM_4_14_FAMILY) \
    $(UM_4_19_FAMILY) \
    $(UM_4_19_LEGACY_FAMILY) \
    $(UM_5_4_FAMILY) \
    $(UM_5_10_FAMILY) \
    $(UM_5_15_FAMILY)

