#!/bin/bash

brew install dockutil

###############################################################################
# Configure Dock                                                              #
###############################################################################
dockutil --remove all

dockutil --add /System/Applications/System\ Preferences.app
dockutil --add /System/Applications/Utilities/Keychain\ Access.app
#dockutil --add /Applications/Utilities/Grab.app
#dockutil --add '' --type spacer --section apps
dockutil --add /System/Applications/Reminders.app
dockutil --add /System/Applications/Calendar.app
dockutil --add /System/Applications/Notes.app
dockutil --add /System/Applications/Music.app
dockutil --add '' --type spacer --section apps
dockutil --add /Applications/Safari.app
dockutil --add /Applications/Google\ Chrome.app
dockutil --add /Applications/Firefox\ Developer\ Edition.app
dockutil --add /Applications/Slack.app
dockutil --add /Applications/Messages.app
dockutil --add /Applications/Signal.app
dockutil --add '' --type spacer --section apps
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/Sourcetree.app
dockutil --add /Applications/Atom.app
dockutil --add /Applications/WebStorm.app
dockutil --add /Applications/PyCharm\ CE.app
dockutil --add /Applications/Visual\ Studio\ Code.app
dockutil --add /Applications/VMware\ Fusion.app
# dockutil --add '' --type spacer --section apps


defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock magnification -bool true

killall Dock
