brew install dockutil

###############################################################################
# Configure Dock                                                              #
###############################################################################
dockutil --remove all

dockutil --add /Applications/System\ Preferences.app
dockutil --add /Applications/Reminders.app
dockutil --add /Applications/Calendar.app
dockutil --add '' --type spacer --section apps
dockutil --add /Applications/Safari.app
dockutil --add /Applications/Google\ Chrome.app
dockutil --add /Applications/Slack.app
dockutil --add /Applications/Rocket.Chat+.app
dockutil --add /Applications/Messages.app
dockutil --add '' --type spacer --section apps
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/Atom.app
dockutil --add /Applications/Sourcetree.app
dockutil --add /Applications/PyCharm\ CE.app
dockutil --add /Applications/Webstorm.app
dockutil --add /Applications/VMware\ Fusion.app
dockutil --add '' --type spacer --section apps
dockutil --add /Applications/Notes.app
dockutil --add /Applications/Evernote.app
dockutil --add '' --type spacer --section apps
dockutil --add /Applications/Spotify.app --section others


defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock magnification -bool true

killall Dock
