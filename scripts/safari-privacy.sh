#!/usr/bin/env bash
# Safari privacy settings for a new Mac:
#   1. Advanced Tracking & Fingerprinting Protection -> all browsing
#   2. Search engine -> DuckDuckGo
#   3. Install Wipr 2 Safari extension for ad blocking
#
# Requires: the terminal app running this script has Full Disk Access
# (System Settings > Privacy & Security > Full Disk Access). Safari's
# preferences live in its sandbox container, which is protected.
set -euo pipefail

SAFARI_PLIST="$HOME/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari"

# Quit Safari so it doesn't overwrite the changes when it exits.
osascript -e 'tell application "Safari" to quit' >/dev/null 2>&1 || true
sleep 1

# Fail early with a clear message if we can't write Safari's preferences.
if ! defaults write "$SAFARI_PLIST" __write_check -bool true 2>/dev/null; then
  echo "ERROR: Can't write Safari preferences. Give your terminal app Full Disk Access" >&2
  echo "       (System Settings > Privacy & Security > Full Disk Access), then rerun." >&2
  exit 1
fi
defaults delete "$SAFARI_PLIST" __write_check

# 1. Advanced tracking and fingerprinting protection in all browsing.
#    Set explicitly so a future change in Apple's default doesn't silently weaken it.
defaults write "$SAFARI_PLIST" EnableEnhancedPrivacyInRegularBrowsing -bool true
defaults write "$SAFARI_PLIST" EnableEnhancedPrivacyInPrivateBrowsing -bool true

# 3. DuckDuckGo as the search engine.
#    Safari reads the system-wide web search provider from the global domain.
#    Note: this replaces the whole NSPreferredWebServices value (fine on a new Mac).
defaults write -g NSPreferredWebServices \
  '{ NSWebServicesProviderWebSearch = { NSDefaultDisplayName = DuckDuckGo; NSProviderIdentifier = "com.duckduckgo"; }; }'
defaults write "$SAFARI_PLIST" SearchProviderShortName -string "DuckDuckGo"

echo "Safari privacy settings applied:"
defaults read "$SAFARI_PLIST" | grep -E 'EnableEnhancedPrivacy|SearchProviderShortName' || true
defaults read -g NSPreferredWebServices || true
echo "Open Safari > Settings > Search and > Advanced to confirm."

# Install Safari Extension Wipr 2 for ad blocking
brew install mas
sudo mas install 1662217862   # mas 4.0+ needs sudo for installs
open -a "Wipr 2"              # launches Wipr's setup walkthrough
