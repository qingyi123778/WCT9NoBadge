ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = wxkb

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WCT26NoBadge

WCT26NoBadge_FILES = 调整.x
WCT26NoBadge_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
