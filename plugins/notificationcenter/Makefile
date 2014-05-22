ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NotificationCenter
NotificationCenter_FILES = Plugin.xm
NotificationCenter_FRAMEWORKS = UIKit
NotificationCenter_LIBRARIES = guest substrate
NotificationCenter_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk