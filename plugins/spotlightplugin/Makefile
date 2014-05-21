ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SpotlightPlugin
SpotlightPlugin_FILES = Plugin.m
SpotlightPlugin_FRAMEWORKS = UIKit
SpotlightPlugin_LIBRARIES = guest substrate
SpotlightPlugin_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk