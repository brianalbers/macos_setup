#!/bin/zsh

# https://github.com/mathiasbynens/dotfiles
# https://github.com/Stratus3D/dotfiles
# https://github.com/herrbischoff/awesome-macos-command-line#transparency

echo "############################################################"
echo "Starting base.sh"

# Install or update Home-brew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Installing Homebrew"
    sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew doctor
else
    echo "Updating Homebrew"
    brew update
fi

# Move git config files to home folder
cp -f ../dotfiles/gitconfig ~/.gitconfig
cp -f ../dotfiles/gitignore_global ~/.gitignore_global

# Install Mac App store CLI to install Memory Clean 2
brew install mas

# Install Memory Clean 2
# Retrieve ID by running "mas search 'Memory Clean 2'"
mas signin brian@brianalbers.com
mas install 1114591412

# Install Disk Doctor: System Cleaner
mas install 455970963

# Install BetterSnapTool (1.8)
mas install 417375580
cp ../dotfiles/com.hegenberg.BetterSnapTool.plist ~/Library/Preferences

# Install Apple Office Applications
mas install 409203825  # Numbers
mas install 409183694  # Keynote
mas install 409201541  # Pages

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh

# Install other helpful utilities
brew install nmap
brew install ack
brew install tree

# Install m-cli - https://github.com/rgcr/m-cli                                               #
brew install m-cli

# Install openssl
brew install openssl

# Install iStat menu bar - se
brew cask install istat-menus
open /Applications/iStat\ Menus.app

# Install Slack
brew install --cask slack

# Install ExpressVPN
brew install --cask expressvpn

# Install XFINITY hotspot certs
open /Users/balbers/Library/Mobile\ Documents/com\~apple\~CloudDocs/XFINITY.mobileconfig

# Install Google Chrome
brew install --cask google-chrome

# Install Firefox Developer Edition
brew install --cask homebrew/cask-versions/firefox-developer-edition\

# Install Brave Browser
brew install --cask brave-browser

# Install 1Password
brew install --cask 1Password

# Install Atom
brew install --cask atom

# Install Spotify for music
brew install --cask spotify

# Install Signal
brew install --cask signal

# Install Authy
brew install --cask authy

# Install Authy
brew install --cask authy

# Install Parallels
brew install --cask homebrew/cask/parallels

# Remove brew cruft
brew cleanup

# Set hostname based on user input
echo "Machine name current settings: "
echo "Please set the computername, hostname, localhostname and netbiosname (Leave blank for no change): "
read -p "New Hostname: "newhostname
m hostname $newhostname
