ARCHS = armv7 armv7s arm64
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Siri
Siri_FILES = Plugin.xm
Siri_FRAMEWORKS = UIKit
Siri_LIBRARIES = guest substrate
Siri_INSTALL_PATH = /Library/GuestFramework/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk