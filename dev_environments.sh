#!/bin/zsh

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
source ~/.zshrc

# Install node
nvm install v6.11.1
nvm use v6.11.1

# Install yarn
brew install yarn --without-node

# gpg2 is required for installing RVM
brew install gnupg gnupg2

# Install RVM and latest stable version of Ruby
curl -sSL https://get.rvm.io | bash -s stable

# Install Docker for MacOS
curl -O https://download.docker.com/mac/stable/Docker.dmg
hdiutil attach Docker.dmg
cp -rf /Volumes/Docker/Docker.app /Applications
open -a Docker
hdiutil detach /dev/disk2
rm -f Docker.dmg

# Install Webstorm
brew cask install jetbrains-toolbox
brew cask install webstorm
brew cask install pycharm-ce
brew cask install goland

# Install SourceTree
brew cask install sourcetree
mkdir dev
mkdir dev/projects

# Install AWS tools
brew install s3cmd
brew install awscli

# Setup ssh
# Encrypt: openssl enc -aes-256-cbc -md md5 -salt -in configurerc.sh -out configurerc.sh.aes
cp ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/BITS/certs.tar.aes ~/.ssh/.
echo "1.1(upper)(evens)2bangs"
openssl enc -aes-256-cbc -md md5 -d -in ~/.ssh/certs.tar.aes -out ~/.ssh/certs.tar
tar xf ~/.ssh/certs.tar -C ~/.ssh
rm -f ~/.ssh/certs.tar
rm -f ~/.ssh/certs.tar.aes

if [ ! -f "$HOME/.ssh/id_rsa.pub"]; then
  ssh-keygen -t rsa -C "$(hostname)" -f "$HOME/.ssh/id_rsa"
fi
cat ~/.ssh/id_rsa.pub | echo
cp -f $MACOS_SETUP_DIR/dotfiles/ssh_config ~/.ssh/.ssh_config

return 1
