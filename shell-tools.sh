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
  fi
}

install_brew_package_manager
install_fish_shell
