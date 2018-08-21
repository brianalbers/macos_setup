#!/bin/zsh

# https://github.com/mathiasbynens/dotfiles
# https://github.com/Stratus3D/dotfiles
# https://github.com/herrbischoff/awesome-macos-command-line#transparency

# Install or update Home-brew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
else
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
brew install vim --with-override-system-vi
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

# Install Homebrew Cask
brew tap caskroom/cask

# Install Slack
brew cask install slack
open /Applications/Slack.app

# Install rocket.chat
brew cask install rocket-chat
open /Applications/Rocket.chat+.app

# Install Google Chrome
brew cask install google-chrome

# Install Firefox Developer Edition
brew cask install caskroom/versions/firefox-developer-edition

# Install Atom
brew cask install atom

# Install Spotify for music
brew cask install spotify

# Install VMware Fusion
brew cask install vmware-fusion
open /Applications/VMware\ Fusion.app
#export serial=""
#/Applications/VMware\ Fusion.app/Contents/Library/Initialize\ VMware\ Fusion.tool set "" "" ${serial}

# Install VMWare Horizon Client for accessing CACI VDI
brew cask install vmware-horizon-client

# Commented out due to license limitations of 2 computers
#brew cask install evernote

# Remove brew cruft
brew cleanup

# Remove cask cruft
brew cask cleanup

# Set hostname based on user input
echo "Machine name current settings: "
echo "Please set the computername, hostname, localhostname and netbiosname (Leave blank for no change): "
read -p "New Hostname: "newhostname
m hostname $newhostname
