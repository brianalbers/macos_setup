#!/bin/bash

# dockutil does not install properly with brew on Monterey
# https://github.com/kcrawford/dockutil/issues/127
brew install dockutil

###############################################################################
# Configure Dock                                                              #
###############################################################################
dockutil --remove all

dockutil --add /Applications/System\ Settings.app
dockutil --add /Applications/App\ Store.app

dockutil --add '' --type spacer --section apps

dockutil --add /Applications/Calendar.app
dockutil --add /Applications/Reminders.app
dockutil --add /Applications/Messages.app
dockutil --add /Applications/Notes.app
dockutil --add /Applications/Photos.app

dockutil --add '' --type spacer --section apps

dockutil --add /Applications/Safari.app
dockutil --add /Applications/Brave\ Browser.app

dockutil --add '' --type spacer --section apps

dockutil --add /Applications/Proton\ Mail.app
dockutil --add /Applications/Proton\ Pass.app
dockutil --add /Applications/ProtonVPN.app

dockutil --add '' --type spacer --section apps

dockutil --add /Applications/Visual\ Studio\ Code.app
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/Claude.app
dockutil --add /Applications/ChatGPT.app

dockutil --add '' --type spacer --section apps
dockutil --add /Applications/Home.app
dockutil --add /Users/balbers/Applications/Bedroom\ Lamp.app

# Icon size in points (16-128)
defaults write com.apple.dock tilesize -int 40
# Keep the Dock visible
defaults write com.apple.dock autohide -bool false
# Enlarge icons on hover
defaults write com.apple.dock magnification -bool true
# Magnified icon size in points (16-128); must be larger than tilesize or
# magnification has no visible effect. macOS stores this as a float.
defaults write com.apple.dock largesize -float 64

killall Dock
