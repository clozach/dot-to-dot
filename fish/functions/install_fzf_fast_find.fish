function install_fzf_fast_find
  # https://github.com/junegunn/fzf
	echo "📦  Installing fzf"
  brew install fzf
  echo y | /usr/local/opt/fzf/install
end
