#!/bin/bash

# Install or update Home-brew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
else
    brew update
fi

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
source ~/.zshrc

# Install node
nvm install v6.11.1
nvm use v6.11.1

# Install yarn
brew install yarn --without-node

# Install python
brew install python@2

# gpg2 is required for installing RVM
brew install gnupg gnupg2

# install java 8
brew cask install java8

# Install RVM and latest stable version of Ruby
curl -sSL https://get.rvm.io | bash -s stable

# Install golang
export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
brew install go
brew install hg bzr

# Install Docker for MacOS
curl -O https://download.docker.com/mac/stable/Docker.dmg
hdiutil attach Docker.dmg
cp -rf /Volumes/Docker/Docker.app /Applications
open -a Docker
hdiutil detach /dev/disk2
rm -f Docker.dmg

# Install Pivotal Cloud Foundry CLI
brew install cloudfoundry/tap/cf-cli

# Install Webstorm
# brew cask install jetbrains-toolbox
brew cask install webstorm
brew cask install pycharm-ce
brew cask install goland

# Install Visual Studio Code
brew cask install visual-studio-code
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension PeterJausovec.vscode-docker
code --install-extension ms-vscode.Go
code --install-extension ms-python.python
code --install-extension waderyan.nodejs-extension-pack
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension amandeepmittal.expressjs
code --install-extension ms-vscode.node-debug2
code --install-extension DanielThielking.aws-cloudformation-yaml
code --install-extension loganarnett.lambda-snippets

# Install SourceTree
brew cask install sourcetree

# Install AWS tools
brew install s3cmd
brew install awscli
brew cask install aws-vault

# Install AWS SAM
# please not pip should have automatically been installed with python
pip install --user aws-sam-cli

# Setup ssh
# Encrypt: openssl enc -aes-256-cbc -md md5 -salt -in configurerc.sh -out configurerc.sh.aes
if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
  ssh-keygen -t rsa -C "$(hostname)" -f "$HOME/.ssh/id_rsa"
fi
cat ~/.ssh/id_rsa.pub | echo
cp -f ../dotfiles/ssh_config ~/.ssh/config

cp ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/BITS/certs.tar.aes ~/.ssh/.
echo "1.1(upper)(evens)2bangs"
openssl enc -aes-256-cbc -md md5 -d -in ~/.ssh/certs.tar.aes -out ~/.ssh/certs.tar
tar xf ~/.ssh/certs.tar -C ~/.ssh
rm -f ~/.ssh/certs.tar
rm -f ~/.ssh/certs.tar.aes
