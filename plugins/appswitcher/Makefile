ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = AppSwitcher
AppSwitcher_FILES = Plugin.xm CKBlurView.m
AppSwitcher_FRAMEWORKS = UIKit QuartzCore CoreGraphics
AppSwitcher_PRIVATE_FRAMEWORKS = Preferences
AppSwitcher_LIBRARIES = guest substrate
AppSwitcher_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk