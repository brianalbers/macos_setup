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

# Install Webstorm
brew cask install jetbrains-toolbox
brew cask install webstorm
brew cask install pycharm-ce
brew cask install goland

# Install SourceTree
brew cask install sourcetree
mkdir dev
mkdir dev/projects

# Generate ssh key
ssh-keygen -t rsa -C "$(hostname)"
cp .ssh_config ~/.ssh
