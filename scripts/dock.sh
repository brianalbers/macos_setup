#!/bin/bash

# dockutil does not install properly with brew on Monterey
# https://github.com/kcrawford/dockutil/issues/127
brew install --cask hpedrorodrigues/tools/dockutil

###############################################################################
# Configure Dock                                                              #
###############################################################################
dockutil --remove all

dockutil --add /Applications/System\ Settings.app
dockutil --add /Applications/App\ Store.app
dockutil --add /Applications/1Password.app

dockutil --add '' --type spacer --section apps

dockutil --add /Applications/Calendar.app
dockutil --add /Applications/Reminders.app
dockutil --add /Applications/Messages.app
dockutil --add /Applications/Notes.app

dockutil --add '' --type spacer --section apps

dockutil --add /Applications/Safari.app
dockutil --add /Applications/Brave\ Browser.app

dockutil --add '' --type spacer --section apps

dockutil --add /Applications/Slack.app
dockutil --add /Applications/Microsoft\ Outlook.app
dockutil --add /Applications/Microsoft\ Teams.app

dockutil --add '' --type spacer --section apps

dockutil --add /Applications/Parallels\ Desktop.app
dockutil --add /Applications/Visual\ Studio\ Code.app
dockutil --add /Applications/IntelliJ\ IDEA.app
dockutil --add /Applications/iTerm.app

defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock magnification -bool true

killall Dock
