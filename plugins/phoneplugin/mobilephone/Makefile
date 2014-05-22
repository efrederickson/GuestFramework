ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = MobilePhone
MobilePhone_FILES = Plugin.m
MobilePhone_FRAMEWORKS = UIKit
MobilePhone_LIBRARIES = guest substrate
MobilePhone_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk