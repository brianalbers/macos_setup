#!/bin/zsh

# https://github.com/mathiasbynens/dotfiles
# https://github.com/Stratus3D/dotfiles
# https://github.com/herrbischoff/awesome-macos-command-line#transparency

# Install or update Home-brew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/balbers/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    brew update
fi

# Move git config files to home folder
cp -f ../dotfiles/gitconfig ~/.gitconfig
cp -f ../dotfiles/gitignore_global ~/.gitignore_global

# Install BetterSnapTool (1.8)
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
brew install istat-menus
open /Applications/iStat\ Menus.app

# Install Homebrew Cask
brew tap homebrew/cask

# Install Slack
brew install slack
open /Applications/Slack.app

# Install ExpressVPN
brew install expressvpn

# Install Google Chrome
brew install google-chrome

# Install Firefox
brew install firefox

# Install Brave Browser
brew install brave-browser

# Install 1Password
brew install 1Password

# Install Signal
brew install signal

# Install 1Password
brew install 1password

# Install Authy
brew install authy

# Remove brew cruft
brew cleanup

# Set hostname based on user input
echo "Machine name current settings: "
echo "Please set the computername, hostname, localhostname and netbiosname (Leave blank for no change): "
read -p "New Hostname: "newhostname
m hostname $newhostname
