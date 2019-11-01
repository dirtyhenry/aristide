#!/usr/bin/env bash -xe

UUID="$1"
LANGUAGE="$2"
LOCALE="$3"

PLIST=~/Library/Developer/CoreSimulator/Devices/$UUID/data/Library/Preferences/.GlobalPreferences.plist

plutil -replace AppleLocale -string $LOCALE $PLIST
plutil -replace AppleLanguages -json "[ \"$LANGUAGE\" ]" $PLIST
