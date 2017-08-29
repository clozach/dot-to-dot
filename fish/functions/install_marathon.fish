function install_marathon
  echo "📦  Installing marathon, a Swifty scripting tool"
  git clone https://github.com/JohnSundell/Marathon.git
  cd Marathon
  make
  cd ..
  rm -rf Marathon
end
