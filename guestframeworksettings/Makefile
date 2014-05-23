ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = GuestFrameworkSettings
GuestFrameworkSettings_FILES = GuestFrameworkSettings.mm LGPluginsController.m LGPluginSettingsPanel.m LGHeaderCell.m LGSwitchCell.m LGPluginSubPanel.m LGPluginsController2.m
GuestFrameworkSettings_INSTALL_PATH = /Library/PreferenceBundles
GuestFrameworkSettings_FRAMEWORKS = UIKit CoreGraphics Foundation
GuestFrameworkSettings_PRIVATE_FRAMEWORKS = Preferences
GuestFrameworkSettings_LIBRARIES = Guest

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/GuestFrameworkSettings.plist$(ECHO_END)
