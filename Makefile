THEOS_DEVICE_IP=192.168.7.146
THEOS_PACKAGE_DIR_NAME = debs

include $(THEOS)/makefiles/common.mk

after-install::
	install.exec "killall -9 SpringBoard"

#core projects
SUBPROJECTS += libguest
SUBPROJECTS += guestframeworksettings

#plugins / samples / etc
SUBPROJECTS += plugins/sample_plugin
SUBPROJECTS += plugins/spotlightplugin
SUBPROJECTS += plugins/iconrestrictorplugin

include $(THEOS_MAKE_PATH)/aggregate.mk
