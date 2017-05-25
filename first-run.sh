#!/bin/bash

###################
# GENERAL PURPOSE #
###################

# PARTIAL CREDIT: https://github.com/kevinelliott/.dotfiles/blob/master/install.sh
# HOW TO SHARE THIS ACROSS SCRIPTS?

get_dot_to_dot_root() {
  script="`python -c 'import os,sys;print os.path.realpath(sys.argv[1])' "$0"`" #"`readlink -f "$0"`"
  echo "`dirname "$script"`"
}

current_working_dir=$(get_dot_to_dot_root)

$current_working_dir/mac-os-prefs.sh
$current_working_dir/shell-tools.sh
