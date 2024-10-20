#----------------------------------------------------------------------
# Generate device tree image (dt.img)
#----------------------------------------------------------------------
ifneq (,$(filter $(QCOM_BOARD_PLATFORMS),$(TARGET_BOARD_PLATFORM)))
ifeq ($(strip $(BOARD_CUSTOM_BOOTIMG_MK)),)
ifeq ($(strip $(BOARD_KERNEL_SEPARATED_DT)),true)

INSTALLED_DTIMAGE_TARGET := $(PRODUCT_OUT)/dt.img

ifeq ($(strip $(BOARD_KERNEL_PREBUILT_DT)),)

ifeq ($(strip $(TARGET_CUSTOM_DTBTOOL)),)
DTBTOOL_NAME := dtbToolCM
else
DTBTOOL_NAME := $(TARGET_CUSTOM_DTBTOOL)
endif

ifneq ($(TARGET_KERNEL_ARCH),)
KERNEL_ARCH := $(TARGET_KERNEL_ARCH)
else
KERNEL_ARCH := $(TARGET_ARCH)
endif

DTBTOOL := $(HOST_OUT_EXECUTABLES)/$(DTBTOOL_NAME)$(HOST_EXECUTABLE_SUFFIX)

possible_dtb_dirs = $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/dts/ $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/

define build-dtimage-target
    $(call pretty,"Target dt image: $@")
    $(hide) for dir in $(possible_dtb_dirs); do \
        if [ -d "$$dir" ]; then \
            dtb_dir="$$dir"; \
            break; \
        fi; \
    done; \
    $(DTBTOOL) $(BOARD_DTBTOOL_ARGS) -o $@ -s $(BOARD_KERNEL_PAGESIZE) -p $(KERNEL_OUT)/scripts/dtc/ "$$dtb_dir";
    $(hide) chmod a+r $@
endef

ifeq ($(strip $(BOARD_KERNEL_LZ4C_DT)),true)
LZ4_DT_IMAGE := $(PRODUCT_OUT)/dt-lz4.img
endif

$(INSTALLED_DTIMAGE_TARGET): $(DTBTOOL) $(INSTALLED_KERNEL_TARGET)
	$(build-dtimage-target)
ifeq ($(strip $(BOARD_KERNEL_LZ4C_DT)),true)
	$(LZ4) -9 < $@ > $(LZ4_DT_IMAGE) || lz4c -c1 -y $@ $(LZ4_DT_IMAGE)
	$(hide) $(ACP) $(LZ4_DT_IMAGE) $@
endif
	@echo -e ${CL_CYN}"Made DT image: $@"${CL_RST}

else

$(INSTALLED_DTIMAGE_TARGET) : $(BOARD_KERNEL_PREBUILT_DT) | $(ACP)
	$(transform-prebuilt-to-target)

endif # BOARD_KERNEL_PREBUILT_DT

ALL_DEFAULT_INSTALLED_MODULES += $(INSTALLED_DTIMAGE_TARGET)
ALL_MODULES.$(LOCAL_MODULE).INSTALLED += $(INSTALLED_DTIMAGE_TARGET)

endif
endif
endif
