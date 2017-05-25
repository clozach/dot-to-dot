#!/bin/bash

if (( $# != 2 ))
then
  echo "Usage: bash <(curl -s https://raw.githubusercontent.com/clozach/dot-to-dot/master/install.sh) <name of ssh key to create and/or copy> <permanent local residence for dot-to-dot repo>"
  exit 1
fi

ssh_key_name=$1
ssh_file=~/.ssh/$ssh_key_name
parent_dir=$2

create_github_key() {
  echo "🔫  $ssh_key_name keygen 🔫"
  if ! [ -e ~/.ssh/$ssh_key_name ]
  then
    echo "creating $ssh_key_name key"
    ssh-keygen -f $ssh_file -C "$ssh_key_name"
    ssh-add $ssh_file
    ssh-add -l
    echo "$ssh_key_name key added. To uninstall…"
    echo "ssh-add -d $ssh_key_name"
    echo "rm ~/.ssh/$ssh_key_name*"
  else
    echo "$ssh_key_name key already exists"
  fi
  echo "🏁  $ssh_key_name keygen 🏁"
}

copy_key_to_clipboard() {
  cat "$ssh_file.pub" | pbcopy
  echo "Public 🗝  copied to clipboard. Paste into a new SSH in GitHub Settings. Press any key when ready…"
  read -n 1
  open "http://github.com/"
}

clone_dot_to_dot() {
  echo "Now that github has your public SSH key: press any key to clone dot-to-dot…"
  read -n 1
  local tmp=$PWD
  cd $parent_dir
  git clone git@github.com:clozach/dot-to-dot.git
  cd $tmp
}

create_github_key
copy_key_to_clipboard
clone_dot_to_dot
