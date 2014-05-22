ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ControlCenter
ControlCenter_FILES = Plugin.xm
ControlCenter_FRAMEWORKS = UIKit
ControlCenter_LIBRARIES = guest substrate
ControlCenter_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk