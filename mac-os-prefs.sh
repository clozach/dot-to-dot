#!/bin/bash

echo
echo "🔫   TextEdit 🔫 "
# http://www.defaults-write.com/plain-text-default-textedit/#more-1349
defaults write com.apple.TextEdit RichText -int 0
echo "Defaulted TextEdit to plaintext…"
echo "  👉  Revert with: defaults delete com.apple.TextEdit RichText"
echo "🏁   TextEdit 🏁"

echo
echo "🔫   Enable full keyboard access for all controls 🔫"
echo " (e.g. enable tabbing between _all_ controls)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
echo "🏁   Enable full keyboard access for all controls 🏁"

echo
echo "☑️   TODO"
echo "• Set tap-to-click in Preferences > Trackpad > Point & Click"
echo "• Set App Exposé in Preferences > Trackpad > More Gestures"
echo "• Remap CAPS LOCK in Preferences > Keyboard > Keyboard Tab -> Modifier Keys"
echo "  (Remember: this needs to be done once for every keyboard!)"
echo "• Install Dropbox"
echo "• Install 1Password"
echo "• Install SizeUp"
echo "• Install SourceTree"
echo "• Install LaunchBar"
echo "• Install Atom, then use the `sync-settings` package to restore"
echo "    the full Atom environment."
echo "    https://github.com/atom-community/sync-settings"
# (The below seems to be broken…)
# Enable tap-to-click (http://osxdaily.com/2014/01/31/turn-on-mac-touch-to-click-command-line/)
# sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
