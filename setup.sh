#!/bin/bash

###############################################################################
# Reference
# The following sites have helpful examples for managing this project
# https://github.com/mathiasbynens/dotfiles
# https://github.com/Stratus3D/dotfiles
# https://github.com/herrbischoff/awesome-macos-command-line#transparency
###############################################################################

# Install xcode dev tools for git
xcode-select --install
sleep 1
check=$((xcode-\select --install) 2>&1)
echo $check
str="xcode-select: note: install requested for command line developer tools"
while [[ "$check" == "$str" ]];
do
  sleep 1
  check=$((xcode-\select --install) 2>&1)
  echo -n "."
done

# Clone macos_setup project from github
mkdir $HOME/dev
mkdir $HOME/dev/projects
cd $HOME/dev/projects/
git clone https://github.com/brianalbers/macos_setup.git

# Execute additional scripts from the cloned repo
cd macos_setup/scripts
./base.sh
./terminal.sh
./dev_environments.sh
./macos.sh
./dock.sh
