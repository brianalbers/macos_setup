#!/bin/bash

# Install or update Home-brew
# Install or update Home-brew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    brew update
fi

brew install pyenv

# Install Webstorm
#brew cask install jetbrains-toolbox
#brew cask install webstorm
#brew cask install pycharm-ce
#brew cask install goland
#brew cask install intellij-idea

# Install Visual Studio Code
brew install visual-studio-code
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension PeterJausovec.vscode-docker
code --install-extension ms-vscode.Go
code --install-extension ms-python.python
code --install-extension waderyan.nodejs-extension-pack
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension DanielThielking.aws-cloudformation-yaml
#code --install-extension loganarnett.lambda-snippets

# Install AWS tools
brew install s3cmd
brew install awscli
brew install aws-vault

# Install AWS SAM
# please not pip should have automatically been installed with python
#pip install --user aws-sam-cli

# Setup ssh
# Encrypt: openssl enc -aes-256-cbc -md md5 -salt -in configurerc.sh -out configurerc.sh.aes
if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
  ssh-keygen -t rsa -C "$(hostname)" -f "$HOME/.ssh/id_rsa"
fi
cat ~/.ssh/id_rsa.pub | echo
