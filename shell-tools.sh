#!/bin/bash

###################
# GENERAL PURPOSE #
###################

# PARTIAL CREDIT: https://github.com/kevinelliott/.dotfiles/blob/master/install.sh

command_exists() {
  type "$1" &> /dev/null
}

file_contains_string() {
  # q for quiet
  grep -q $2 $1
}

get_dot_to_dot_root() {
  script="`python -c 'import os,sys;print os.path.realpath(sys.argv[1])' "$0"`" #"`readlink -f "$0"`"
  echo "`dirname "$script"`"
}

current_working_dir=$(get_dot_to_dot_root)

################
# INSTALLATION #
################

set_basic_git_info() {
  git config --global user.email clozach@users.noreply.github.com
  git config --global user.name "Chris Lozac'h"
}

install_brew_package_manager() {
  if command_exists brew
  then
    echo "✅  brew already installed"
  else
    echo
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
    echo
    echo "\n🔫  fish 🔫"
    local result=`brew install fish`
    echo "💬  fish installation resulted in: $result"
    echo
    echo '🥊  To remove fish…'
    echo 'brew uninstall fish'
    echo "🏁  fish 🏁"
  fi
}

make_fish_default_shell() {
  echo
  echo "🔫  fish as default shell 🔫"
  if file_contains_string /etc/shells /usr/local/bin/fish
  then
    echo "💬  /etc/shells contains /usr/local/bin/fish. No change needed."
  else
    echo "🗯  Adding /usr/local/bin/fish to /etc/shells"
    local result=`echo /usr/local/bin/fish >> /etc/shells`
    echo "💬  Editing /etc/shells result: $result"
  fi

  if [ "$SHELL" == "/usr/local/bin/fish" ]
  then
    echo "💬  shell already set to fish"
  else
    echo "🗯  changing shell to fish"
    `chsh -s /usr/local/bin/fish`
  fi
  echo "🏁  fish as default shell 🏁"
}

link_fish_functions() {
  echo
  echo "🔫  symlinking fish 🔫"

  if ! [ -e ~/.config ]
  then
    mkdir ~/.config
  fi

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

install_fonts_for_bobthefish() {
  echo
  echo "🔫  Install fonts for bobthefish 🔫"
  local bold_italic=https://github.com/powerline/fonts/blob/master/Cousine/Cousine%20Bold%20Italic%20for%20Powerline.ttf?raw=true
  local bold=https://github.com/powerline/fonts/blob/master/Cousine/Cousine%20Bold%20for%20Powerline.ttf?raw=true
  local italic=https://github.com/powerline/fonts/blob/master/Cousine/Cousine%20Italic%20for%20Powerline.ttf?raw=true
  local standard=https://github.com/powerline/fonts/blob/master/Cousine/Cousine%20for%20Powerline.ttf?raw=true

  open $bold_italic
  open $bold
  open $italic
  open $standard

  echo "Time to double-click on downloaded Cousine fonts needed for a clean bobthefish shell prompt."
  echo "Press any key when ready…"
  read -n 1
  open ~/Downloads/
  echo "⚠️ Now open Terminal prefs (maybe iTerm some day), set theme to Homebrew and font to Cousine for Powerline."
  echo "Press any key when ready…"
  read -n 1
  echo "🏁  Install fonts for bobthefish 🏁"
}

echo # I like to have white space top & bottom
set_basic_git_info
install_brew_package_manager
install_fish_shell
make_fish_default_shell
link_fish_functions
install_fonts_for_bobthefish
echo # I like to have white space top & bottom
