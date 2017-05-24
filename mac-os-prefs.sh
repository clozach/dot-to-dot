#!/bin/bash

echo "🔫  TextEdit 🔫 "
# http://www.defaults-write.com/plain-text-default-textedit/#more-1349
defaults write com.apple.TextEdit RichText -int 0
"Defaulted TextEdit to plaintext…"
echo "  👉  Revert with: defaults delete com.apple.TextEdit RichText"
echo "🏁  TextEdit 🏁"

echo
echo "☑️  TODO"
echo "• Set tap-to-click in Preferences > Trackpad > Point & Click"
echo "• Set App Exposé in Preferences > Trackpad > Scroll & Zoom"
# (The below seems to be broken…)
# Enable tap-to-click (http://osxdaily.com/2014/01/31/turn-on-mac-touch-to-click-command-line/)
# sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

