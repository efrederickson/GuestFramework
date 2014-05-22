ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NewsStand
NewsStand_FILES = Plugin.xm
NewsStand_FRAMEWORKS = UIKit
NewsStand_LIBRARIES = guest substrate
NewsStand_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk