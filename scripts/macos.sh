#!/bin/bash

# Close any open System Settings (System Preferences before Ventura) panes,
# to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Settings" to quit' 2>/dev/null
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null


###############################################################################
# Trackpad				                                                            #
###############################################################################

# Enable Dragging - Three finger drag, plus tap to click
# Accessibility > Pointer Control > Trackpad Options > Dragging style
#
# Newer macOS reads these from both the trackpad driver domains (built-in and
# Bluetooth) and the per-host global domain, so all three have to agree.
# Three finger drag also takes over three-finger swipes, so those are turned
# off and Mission Control / App Exposé / switching spaces move to four fingers,
# which is what System Settings does when you enable it by hand.
for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
	defaults write "$domain" Clicking -bool true
	defaults write "$domain" Dragging -bool false
	defaults write "$domain" DragLock -bool false
	defaults write "$domain" TrackpadThreeFingerDrag -bool true
	defaults write "$domain" TrackpadThreeFingerHorizSwipeGesture -int 0
	defaults write "$domain" TrackpadThreeFingerVertSwipeGesture -int 0
	defaults write "$domain" TrackpadFourFingerHorizSwipeGesture -int 2
	defaults write "$domain" TrackpadFourFingerVertSwipeGesture -int 2
done
# Must be a boolean; delete first so an older integer value doesn't keep its type
defaults -currentHost delete NSGlobalDomain com.apple.trackpad.threeFingerDragGesture 2>/dev/null
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerHorizSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -int 2

# Set tracking speed - how fast the cursor mouse with touchpad
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.0

# Tap to click (login screen reads the plain domain, the user session reads currentHost)
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Apply trackpad changes without logging out (falls back to needing a logout
# if the helper isn't present on this macOS version)
activate_settings=/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings
[ -x "$activate_settings" ] && "$activate_settings" -u


# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Max (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Apple Initial Bitpool Min (editable)" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Max" 80
defaults write com.apple.BluetoothAudioAgent "Negotiated Bitpool Min" 80

# Add top menu bar items (Bluetooth and Sound)
# The old /System/Library/CoreServices/Menu Extras/*.menu files are gone; these
# are Control Center modules now. 18 = always show in menu bar. The second pair
# is the key name newer macOS versions use.
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18
defaults -currentHost write com.apple.controlcenter Sound -int 18
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool true
killall ControlCenter &> /dev/null

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
mkdir ~/Pictures/ScreenCapture
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
# systemsetup's sleep options are broken on newer macOS (Error:-99), so use pmset.
# -a = all power sources, -b = battery, -c = charger
sudo pmset -a sleep 180
sudo pmset -a disksleep 180
sudo pmset -c womp 1
sudo pmset -a displaysleep 15
sudo pmset -b disksleep 60
sudo pmset -b powernap 0
sudo pmset -c disksleep 180
sudo pmset -c powernap 1


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Safari keeps its preferences in a sandbox container, which only apps with
# Full Disk Access can write to. Without it every write below fails, so check
# first and skip the section with instructions instead.
if ! defaults write com.apple.Safari UniversalSearchEnabled -bool false 2>/dev/null; then
	echo "Skipping Safari settings: your terminal app needs Full Disk Access."
	echo "  Add it in System Settings > Privacy & Security > Full Disk Access,"
	echo "  quit and reopen the terminal, then run this script again."
	open "x-apple.systempreferences:com.apple.settings.PrivacySecurity.extension?Privacy_AllFiles"
else

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

fi

# Show the Develop menu ("Show features for web developers"). Newer Safari
# reads this from outside the sandbox, so it works without Full Disk Access.
defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true


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

# Set wallpaper
cp -f ../wallpaper/*.jpg ~/Pictures/
wallpaper="$HOME/Pictures/apple-logo-orange-liquid-art-white-background-apple-event-3840x3840-5871.jpg"
if command -v m &> /dev/null; then
	m wallpaper --set "$wallpaper"
else
	osascript -e "tell application \"System Events\" to set picture of every desktop to \"$wallpaper\""
fi

# Set screensaver
cp -rf "../wallpaper/Epoch Flip Clock.saver" ~/Library/Screen\ Savers
defaults -currentHost write com.apple.screensaver modulePath -string "~/Library/Screen Savers/Epoch Flip Clock.saver"; defaults -currentHost write com.apple.screensaver moduleName -string "Epoch Flip Clock"; defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName "Epoch Flip Clock" path "~/Library/Screen Savers/Epoch Flip Clock.saver/" type 0


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
