ARCHS = armv7 armv7s arm64 
CFLAGS = -fobjc-arc
TARGET = iphone:clang:7.1:7.1

include theos/makefiles/common.mk

TWEAK_NAME = LibGuestActivationMethods
LibGuestActivationMethods_FILES = Tweak.xm LGLibPassDelegate.m LGActivator.m
LibGuestActivationMethods_LIBRARIES = guest pass activator

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
