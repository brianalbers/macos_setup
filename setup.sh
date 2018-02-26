#!/bin/zsh

# https://github.com/mathiasbynens/dotfiles
# https://github.com/Stratus3D/dotfiles

#Terminal
# Set zsh as default shell
chsh -s $(which zsh)
# Install xcode dev tools
xcode-select --install

# Clone macos_setup project from github
mkdir $HOME/dev
mkdir $HOME/dev/projects
cd $HOME/dev/projects/
git clone https://github.com/brianalbers/macos_setup.git
export MACOS_SETUP_DIR=$HOME/dev/projects/macos_setup

# Install Home-brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Install prezto - https://github.com/sorin-ionescu/prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
cp -f dotfiles/zpreztorc ~/.zpreztorc

# Move gitconfig to home folder
cp -f dotfiles/gitconfig ~/.gitconfig

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install Mac App store CLI to install Memory Clean 2
brew install mas

# Install Memory Clean 2
# Retrieve ID by running "mas search 'Memory Clean 2'"
mas signin brian@brianalbers.com
mas install 1114591412

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

# Install openssl
brew install openssl

# Install iStat menu bar - se
brew cask install istat-menus
open /Applications/iStat\ Menus.app

# Install Homebrew Cask
brew tap caskroom/cask

# Install zsh completions
brew install zsh-completions

# Install iterm2
brew cask install iterm2
cp -f dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences

# Install Slack
brew cask install slack
open /Applications/Slack.app

# Install rocket.chat
brew cask install rocket-chat
open /Applications/Rocket.chat+.app

# Install Google Chrome
brew cask install google-chrome

# Install Firefox Developer Edition
brew cask install firefox-developer-edition

# Install Atom
brew cask install atom

# Install Spotify for music
brew cask install spotify

# Install VMware Fusion
brew cask install vmware-fusion
open /Applications/VMware\ Fusion.app
#export serial=""
#/Applications/VMware\ Fusion.app/Contents/Library/Initialize\ VMware\ Fusion.tool set "" "" ${serial}

# Commented out due to license limitations of 2 computers
#brew cask install evernote

sudo $MACOS_SETUP_DIR/citrix_and_cac.sh

# Install Citrix Receiver
brew cask install citrix-receiver
defaults write com.citrix.receiver.nomas PKCS11ModulePath -string /Library/CACKey/libcackey.dylib
defaults write com.citrix.receiver.nomas PKCS11ModuleEnabled YES

# Remove brew cruft
brew cleanup

# Remove cask cruft
brew cask cleanup

$MACOS_SETUP_DIR/dev_environments.sh

$MACOS_SETUP_DIR/dock.sh

$MACOS_SETUP_DIR/macos.sh
