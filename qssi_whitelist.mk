# Files common to all SIs
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
system/app/Protips/Protips.apk \
system/app/Protips/oat/arm64/Protips.odex \
system/app/Protips/oat/arm64/Protips.vdex \
system/bin/curl \
system/etc/apns-conf.xml \
system/etc/permissions/privapp-permissions-qti.xml \
system/etc/sysconfig/qti_whitelist.xml \
system/framework/QPerformance.jar \
system/framework/UxPerformance.jar \
system/framework/QXPerformance.jar \
system/framework/WfdCommon.jar \
system/framework/qcom.fmradio.jar \
system/framework/tcmiface.jar \
system/framework/tcmclient.jar \
system/framework/telephony-ext.jar \
system/lib/libcurl.so \
system/lib64/libbluetooth-binder.so \
system/lib64/libmediaplayerservice.so \
system/lib64/libstagefright_httplive.so \
system/usr/keylayout/gpio-keys.kl \
system/etc/sysconfig/preinstalled-packages-platform-full-base.xml \
system/framework/oat/arm/tcmclient.odex \
system/framework/oat/arm/tcmclient.vdex \
system/framework/oat/arm64/tcmclient.odex \
system/framework/oat/arm64/tcmclient.vdex \
system/lib/com.dsi.ant@1.0.so \
system/lib/libnbaio.so \
system/lib/libtextclassifier_hash.so \
system/lib/libtflite.so \
system/lib64/com.dsi.ant@1.0.so \
system/lib64/libtextclassifier_hash.so \
system/lib64/libtflite.so \
system/lib/android.hardware.nfc@1.0.so \
system/lib/android.hardware.nfc@1.1.so \
system/lib/android.hardware.nfc@1.2.so \
system/lib64/android.hardware.nfc@1.0.so \
system/lib64/android.hardware.nfc@1.1.so \
system/lib64/android.hardware.nfc@1.2.so \
system/app/GoogleExtShared/GoogleExtShared.apk \
system/app/GooglePrintRecommendationService/GooglePrintRecommendationService.apk \
system/etc/init.graphics.test.rc \
system/etc/init/init.graphics.test.rc \
system/etc/permissions/privapp-permissions-google-system.xml \
system/lib/android.hardware.sensors@2.0-ScopedWakelock.so \
system/lib/hw/vendor.qti.hardware.qccsyshal@1.0-impl.so \
system/lib/libavservices_minijail.so \
system/lib/libminijail.so \
system/lib/libtextclassifier.so \
system/lib/vendor.qti.hardware.secureprocessor.common@1.0-helper.so \
system/lib64/android.hardware.sensors@2.0-ScopedWakelock.so \
system/lib64/hw/vendor.qti.hardware.qccsyshal@1.0-impl.so \
system/lib64/libQOC.qti.so \
system/lib64/libtextclassifier.so \
system/lib64/vendor.qti.hardware.secureprocessor.common@1.0-helper.so \
system/priv-app/GooglePackageInstaller/GooglePackageInstaller.apk \
system/bin/tinycap \
system/bin/tinymix \
system/bin/tinypcminfo \
system/bin/tinyplay \
system/bin/update_engine_client \
system/lib/android.hardware.secure_element@1.1.so \
system/lib/android.hardware.secure_element@1.2.so \
system/lib64/android.hardware.secure_element@1.1.so \
system/lib64/android.hardware.secure_element@1.2.so

#Temporarily add thermal hal lib
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
system/lib64/android.hardware.thermal@2.0.so \
system/lib/android.hardware.thermal@2.0.so

# Files specific to 9.8 and 9.11
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
system/lib/vendor.qti.hardware.improvetouch.touchcompanion@1.0.so \
system/lib64/vendor.qti.hardware.improvetouch.touchcompanion@1.0.so

# Files specific to 9.11
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
system/lib/libjni_imageutil.so \
system/lib/libjni_snapcammosaic.so \
system/lib/libjni_snapcamtinyplanet.so \
system/lib64/libjni_imageutil.so \
system/lib64/libjni_snapcammosaic.so \
system/lib64/libjni_snapcamtinyplanet.so \
system/priv-app/SnapdragonCamera/SnapdragonCamera.apk

# Files specific to 9.11, 9.15, 9.12.c9
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
system/etc/preferred-apps/google.xml

# Files specific to 9.12.c9
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
system/app/SoundRecorder/SoundRecorder.apk \
system/app/SoundRecorder/oat/arm64/SoundRecorder.odex \
system/app/SoundRecorder/oat/arm64/SoundRecorder.vdex

# _base_mk_allowed_list represent second whitelist define in mainline_system.mk
# append with additional files. Will be removed once similar change merged
# to mainline_system.mk
override _base_mk_allowed_list := \
$(TARGET_COPY_OUT_SYSTEM_EXT)/lib/vendor.qti.hardware.display.composer@3.0.so \
$(TARGET_COPY_OUT_SYSTEM_EXT)/lib64/vendor.qti.hardware.display.composer@3.0.so
