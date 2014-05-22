ARCHS = armv7 armv7s arm64 
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LGPhoneAppHelper
LGPhoneAppHelper_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk