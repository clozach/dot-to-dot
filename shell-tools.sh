#!/bin/bash

###################
# GENERAL PURPOSE #
###################

# PARTIAL CREDIT: https://github.com/kevinelliott/.dotfiles/blob/master/install.sh

command_exists () {
  type "$1" &> /dev/null ;
}

get_dot_to_dot_root() {
  script="`python -c 'import os,sys;print os.path.realpath(sys.argv[1])' "$0"`" #"`readlink -f "$0"`"
  echo "`dirname "$script"`"
}

current_working_dir=$(get_dot_to_dot_root)

################
# INSTALLATION #
################

install_brew_package_manager() {
  if command_exists brew
  then
    echo "✅  brew already installed"
  else
    echo "🔫  brew 🔫"
    # re: "echo y": https://stackoverflow.com/questions/7642674/how-do-i-script-a-yes-response-for-installing-programs

    local result=`echo y | /usr/bin/ruby -e "$(curl -fSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    echo "💬  brew installation resulted in: $result"
    echo '🥊  To remove brew…'
    echo 'Uninstall old formulas: brew cleanup'
    echo 'Download and run the uninstall script:'
    echo 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"'
    echo "🏁  brew 🏁"
  fi
}

install_fish_shell() {
  if command_exists fish
  then
    echo "✅  fish already installed"
  else
    echo "🔫  fish 🔫"
    local result=`brew install fish`
    echo "💬  fish installation resulted in: $result"
    echo
    echo '🥊  To remove fish…'
    echo 'brew uninstall fish'
    echo "🏁  fish 🏁"

    echo "🔫  fish as default shell 🔫"
    local result=`sudo echo /usr/local/bin/fish >> /etc/shells`
    echo "💬  Editing /etc/shells result: $result"
    local result=`chsh -s /usr/local/bin/fish`
    echo "💬  chsh to fish result: $result"
    echo "🏁  fish as default shell 🏁"
  fi
}

link_fish_functions() {
  echo "🔫  symlinking fish 🔫"

  local f=~/.config/fish
  if test -h "$f"
  then
    echo "Symlink already in place at $f 👍"
  else
    local tmp="ln -s $current_working_dir/fish ~/.config/fish"
    echo "Linking fish config to dot-to-dot: $tmp"
    eval $tmp
    echo `ls -al $f`
  fi

  echo "🏁  symlinking fish 🏁"
}

install_brew_package_manager
install_fish_shell
link_fish_functions
