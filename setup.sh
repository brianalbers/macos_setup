#!/bin/zsh

###############################################################################
# Reference
# The following sites have helpful examples for managing this project
# https://github.com/mathiasbynens/dotfiles
# https://github.com/Stratus3D/dotfiles
# https://github.com/herrbischoff/awesome-macos-command-line#transparency
###############################################################################

./scripts/base.sh

sudo ./scripts/citrix_and_cac.sh

./scripts/macos.sh

./scripts/dev_environments.sh

./scripts/dock.sh
