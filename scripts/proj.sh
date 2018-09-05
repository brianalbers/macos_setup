#!/bin/bash
#
# this script should not be run directly,
# instead you need to source it from your .bashrc,
# by adding this line:
#   source /usr/local/bin/proj.sh
#

function proj() {
  project=${1}

  if [ -z "$project" ];
  then
    cd ~/dev/projects
  else
    cd ~/dev/projects/$project
  fi

}
