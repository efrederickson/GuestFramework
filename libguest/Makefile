ARCHS = armv7 armv7s arm64 
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = libGuest
libGuest_FILES = LGSettings.m Tweak.xm LibGuest.m LGLibPassDelegate.m
libGuest_LIBRARIES = Pass

include $(THEOS_MAKE_PATH)/tweak.mk