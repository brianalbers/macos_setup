#!/bin/zsh

echo "############################################################"
echo "Starting terminal.sh"

# Install or update Home-brew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/balbers/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew doctor
else
    echo "Updating Homebrew"
    brew update
fi

#Terminal
# Set zsh as default shell
chsh -s $(which zsh)

# Install prezto - https://github.com/sorin-ionescu/prezto
rm -rf "${ZDOTDIR:-$HOME}/.zprezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
cp -f ../dotfiles/zpreztorc ~/.zpreztorc
cp -f ../dotfiles/zshenv ~/.zshenv
cp -f ../dotfiles/zshrc ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/balbers/.zprofile

sudo cp -f proj.sh /usr/local/bin/. 

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

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh

# Install other helpful utilities
brew install nmap
brew install ack
brew install tree

# Install iterm2
brew install --cask iterm2
cp -f ../dotfiles/com.googlecode.iterm2.plist ~/Library/Preferences
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

# Install autojump
# See https://olivierlacan.com/posts/cd-is-wasting-your-time/ for details
# Also see `[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh` in .zshrc file
brew install autojump
