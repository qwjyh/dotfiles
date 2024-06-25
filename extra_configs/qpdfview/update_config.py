#!/usr/bin/env python
"""
Modify qpdfview config.
"""

import configparser
import os
import shutil

# =======================================================================================

QPDFVIEW_CONFIGDIR = os.path.expanduser("~/.config/qpdfview/")
if not os.path.exists(QPDFVIEW_CONFIGDIR):
    print("qpdfview config directory not found.")
    print("Install qpdfview first and rerun this script.")
    print("Exiting...")
    exit(1)

# =======================================================================================

QPDFVIEW_CONFIG_CONFIG = QPDFVIEW_CONFIGDIR + "qpdfview.conf"
print(f"{QPDFVIEW_CONFIG_CONFIG=}")

if os.path.exists(QPDFVIEW_CONFIG_CONFIG):
    shutil.copyfile(QPDFVIEW_CONFIG_CONFIG, QPDFVIEW_CONFIG_CONFIG + ".orig")

config = configparser.RawConfigParser()
config.optionxform = lambda optionstr: optionstr
config.read(QPDFVIEW_CONFIG_CONFIG)

config["documentView"]["autoRefresh"] = "true"
config["documentView"]["highlightAll"] = "true"
config["documentView"]["highlightCurrentThumbnail"] = "true"
config["documentView"]["highlightDuration"] = "5000"
config["documentView"]["prefetch"] = "true"
config["documentView"]["prefetchDistance"] = "5"
config["documentView"]["relativeJumps"] = "true"

config["mainWindow"]["restorePerFileSettings"] = "true"
config["mainWindow"]["restoreTabs"] = "true"
config["mainWindow"]["tabVisibility"] = "0"
config["mainWindow"]["trackRecentlyUsed"] = "true"
config["mainWindow"]["viewToolBar"] = "scaleFactor, zoomIn, zoomOut, fitToPageWidthMode"

config["pageItem"]["cacheSize"] = "131072K"

with open(QPDFVIEW_CONFIG_CONFIG, "w") as file:
    config.write(file, space_around_delimiters=False)

# =======================================================================================

QPDFVIEW_CONFIG_SHORTCUTS = QPDFVIEW_CONFIGDIR + "shortcuts.conf"

if os.path.exists(QPDFVIEW_CONFIG_SHORTCUTS):
    shutil.copyfile(QPDFVIEW_CONFIG_SHORTCUTS, QPDFVIEW_CONFIG_SHORTCUTS + ".orig")

config = configparser.RawConfigParser()
config.optionxform = lambda optionstr: optionstr
config.read(QPDFVIEW_CONFIG_SHORTCUTS)

config["General"]["nextPage"] = "Space, N"
config["General"]["previousPage"] = "Backspace, P"

with open(QPDFVIEW_CONFIG_SHORTCUTS, "w") as file:
    config.write(file, space_around_delimiters=False)
