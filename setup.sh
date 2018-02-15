https://github.com/mathiasbynens/dotfiles

#Terminal
# Set zsh as default shell
chsh -s $(which zsh)
# Install xcode dev tools
xcode-select --install

# Install Home-brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Install prezto - https://github.com/sorin-ionescu/prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
cp -f .zpreztorc ~/.

# Move gitconfig to home folder
cp -f .gitconfig ~/.

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
mas signin mas@example.com
mas install 1114591412

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh

brew install nmap
brew install ack
brew install tree

# Install AWS tools
brew install s3cmd
brew install awscli

# Install MenuMeters
curl -O curl -O https://member.ipmu.jp/yuji.tachikawa/MenuMetersElCapitan/zips/MenuMeters_1.9.6.zip
unzip MenuMeters_1.9.6.zip
mv MenuMeters.prefPane  /Users/balbers/Library/PreferencePanes
rm -f MenuMeters_1.9.6.zip

# Install Homebrew Cask
brew tap caskroom/cask

# Install zsh completions
brew install zsh-completions

# Install iterm2
brew cask install iterm2

# Install Slack
brew cask install slack

# Install rocket.chat
brew cask install rocket-chat

# Install Webstorm
brew cask install webstorm

# Install Google Chrome
brew cask install google-chrome

# Install Atom
brew cask install atom

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
source ~/.zshrc

# Generate ssh key
ssh-keygen -t rsa -C "$(hostname)"

# Install yarn
brew install yarn --without-node

# Install Docker for MacOS
curl -O https://download.docker.com/mac/stable/Docker.dmg
hdiutil attach Docker.dmg
cp -rf /Volumes/Docker/Docker.app /Applications
open -a Docker

# Install SourceTree
brew cask install sourcetree
mkdir dev
mkdir dev/projects

brew cask install pycharm-ce

brew cask install spotify

# Install VMware Fusion
brew cask install caskroom/versions/vmware-fusion
#export serial=""
#/Applications/VMware\ Fusion.app/Contents/Library/Initialize\ VMware\ Fusion.tool set "" "" ${serial}

brew cask install evernote

sudo ./citrix_and_cac.sh

# Remove brew cruft
brew cleanup

# Remove cask cruft
brew cask cleanup

./macos.sh

./setup.sh
