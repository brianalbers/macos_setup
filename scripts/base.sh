#!/bin/zsh

# https://github.com/mathiasbynens/dotfiles
# https://github.com/Stratus3D/dotfiles
# https://github.com/herrbischoff/awesome-macos-command-line#transparency

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

exit 1;
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

# Install Homebrew Cask
brew tap caskroom/cask

# Install Slack
brew cask install slack
open /Applications/Slack.app

# Install ExpressVPN
brew cask install expressvpn

# Install Google Chrome
brew cask install google-chrome

# Install Firefox Developer Edition
brew cask install homebrew/cask-versions/firefox-developer-edition\

# Install Brave Browser
brew cask install brave-browser

# Install 1Password
brew cask install 1Password

# Install Atom
brew cask install atom

# Install Spotify for music
brew cask install spotify

# Install Signal
brew cask install signal

# Install VMware Fusion
brew cask install vmware-fusion
open /Applications/VMware\ Fusion.app
#export serial=""
#/Applications/VMware\ Fusion.app/Contents/Library/Initialize\ VMware\ Fusion.tool set "" "" ${serial}

# Install Authy
brew cask install authy

# Remove brew cruft
brew cleanup

# Remove cask cruft
brew cask cleanup

