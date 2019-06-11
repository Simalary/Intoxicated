include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Intoxicated
Intoxicated_FILES = $(wildcard ./*.xm)
Intoxicated_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
