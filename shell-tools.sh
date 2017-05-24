#!/bin/bash

install_brew_package_manager() {
  if hash brew 2>/dev/null; then
    echo "✅  brew already installed"
  else
    echo "🔫  brew 🔫"
    # re: "echo y": https://stackoverflow.com/questions/7642674/how-do-i-script-a-yes-response-for-installing-programs

    local result=`echo y | /usr/bin/ruby -e "$(curl -fSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    echo "💬  brew installation resulted in: $result"
    echo '🥊  To remove brew…'
    echo 'Uninstall old formulas: brew cleanup'
    ucho 'Download and run the uninstall script:'
    echo 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"'
    echo "🏁  brew 🏁"
  fi
}

install_fish_shell() {
  if hash fish 2>/dev/null; then
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
    local tmp="ln -s $PWD/fish ~/.config/fish"
    echo "Linking fish config to dot-to-dot: $tmp"
    eval $tmp
    echo `ls -al $f`
  fi

  echo "🏁  symlinking fish 🏁"
}

install_brew_package_manager
install_fish_shell
link_fish_functions
