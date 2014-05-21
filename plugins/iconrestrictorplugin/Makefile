ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = IconRestrictorPlugin
IconRestrictorPlugin_FILES = Plugin.m
IconRestrictorPlugin_FRAMEWORKS = UIKit
IconRestrictorPlugin_PRIVATE_FRAMEWORKS = Preferences
IconRestrictorPlugin_LIBRARIES = guest substrate
IconRestrictorPlugin_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk