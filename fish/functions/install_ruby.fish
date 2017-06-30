function install_ruby
	echo "📦  Installing rbenv"
  brew install rbenv ruby-build

  echo "📦  Installing ruby 2.4.1"
  rbenv install 2.4.1
  rbenv global 2.4.1
end
