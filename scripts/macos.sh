#!/bin/bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'


###############################################################################
# Trackpad				                                                            #
###############################################################################

# Enable Dragging - Three finger drag
# Accessibility > Mouse and Trackpad > Trackpad Options
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Set tracking speed - how fast the cursor mouse with touchpad
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.0

defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 120

# Add top menu bar items
open '/System/Library/CoreServices/Menu Extras/Bluetooth.menu'
open '/System/Library/CoreServices/Menu Extras/Volume.menu'

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable AirDrop over Ethernet and on Unsupported Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"
mkdir ~/Pictures/Screen
defaults write com.apple.screencapture location ~/Pictures/ScreenCapture

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Clock - display day of week, 12-hour time (but no AM/PM) digital clock with a non-flashing separator.
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock DateFormat "EEE h:mm:ss"

# Battery - show percentage charged.
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Show file extensions.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files.
defaults write com.apple.finder AppleShowAllFiles -bool true

# Don't warn about changing a file extension.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Show Path Bar.
defaults write com.apple.finder ShowPathbar -bool true

# Show Status Bar.
defaults write com.apple.finder ShowStatusBar -bool true

# Show Tab Bar.
defaults write com.apple.finder ShowTabView -bool true

# Display full path in window titles.
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Show the ~/Library folder.
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Enable Dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0


###############################################################################
# Power 				                                                              #
###############################################################################

# Energy Saver Settings
sudo systemsetup -setcomputersleep Never
sudo systemsetup -setdisplaysleep 15
sudo systemsetup -setharddisksleep 180
sudo systemsetup -setwakeonnetworkaccess on


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write -g WebKitDeveloperExtras -bool true

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true


###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

# Auto-play videos when opened with QuickTime Player
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true


###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

#Finder Preferences
#- Finder>Preferences
#    - >General
#        - Uncheck all from desktop
#    - >Sidebar
#        - Check ‘balbers’
#        - Check Devices>’Brian’s Macbook Pro’
#    - Advanced
#        - Check ‘Show All Filename Extensions’
#        - Uncheck ‘Show warning before changing an extension

# Don't show any special icons on desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder FXICloudDriveEnabled -bool true


###############################################################################
# Desktop																															#
###############################################################################

# Set screensaver
cp -f ../wallpaper/*.jpg ~/Pictures/
model_name=$(sysctl hw.model)
if [[ $model_name = *"MacBookPro"* ]]; then
	m wallpaper ~/Pictures/minimalist_orange-wallpaper-2560x1440.jpg
else
	osascript -e 'tell application "System Events" to set picture of (reference to every desktop) to "~/Pictures/minimalist_orange-wallpaper-2560x1440.jpg"'
fi

# Set wallpaper
cp -rf "../wallpaper/Epoch Flip Clock.saver" /Users/balbers/Library/Screen\ Savers
defaults -currentHost write com.apple.screensaver modulePath -string "/Users/balbers/Library/Screen Savers/Epoch Flip Clock.saver"; defaults -currentHost write com.apple.screensaver moduleName -string "Epoch Flip Clock"; defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName "Epoch Flip Clock" path "/Users/balbers/Library/Screen Savers/Epoch Flip Clock.saver/" type 0


###############################################################################
# Security																																		#
###############################################################################

# Enable firewall and block all incoming connections
# Due to new SIP features in High Sierra, this command requires a machine Restart
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 2


###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" \
	"cfprefsd" \
	"Dock" \
	"Finder" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
