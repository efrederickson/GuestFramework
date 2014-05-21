ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = sample_plugin
sample_plugin_FILES = Plugin.m
sample_plugin_FRAMEWORKS = UIKit
sample_plugin_LIBRARIES = guest
sample_plugin_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk