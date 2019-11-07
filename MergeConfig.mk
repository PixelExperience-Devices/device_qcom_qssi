# QSSI merge config files
ifeq ($(ENABLE_AB), true)
    # Handle Case for QSSI-Dynamic Partition
    ifeq ($(BOARD_DYNAMIC_PARTITION_ENABLE), true)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/dynamic_partition/ab/merge_config_system_misc_info_keys)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/dynamic_partition/ab/merge_config_other_item_list)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/dynamic_partition/ab/merge_config_system_item_list)
    else
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/without_dynamic_partition/ab/merge_config_system_misc_info_keys)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/without_dynamic_partition/ab/merge_config_other_item_list)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/without_dynamic_partition/ab/merge_config_system_item_list)
    endif
else
    # Handle Case for QSSI-Dynamic Partition
    ifeq ($(BOARD_DYNAMIC_PARTITION_ENABLE), true)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/dynamic_partition/non_ab/merge_config_system_item_list)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/dynamic_partition/non_ab/merge_config_other_item_list)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/dynamic_partition/non_ab/merge_config_system_misc_info_keys)
    else
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/without_dynamic_partition/non_ab/merge_config_system_item_list)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/without_dynamic_partition/non_ab/merge_config_other_item_list)
        $(call dist-for-goals,droidcore,device/qcom/qssi/ota_merge_configs/without_dynamic_partition/non_ab/merge_config_system_misc_info_keys)
    endif
endif
