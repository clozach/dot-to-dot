#!/usr/local/bin/fish

echo
echo "🔫  Install `fisherman` package manager 🔫"
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
echo "🏁  Install fisherman 🏁"

echo
echo "🔫  Install z 🔫"
if not file_exists ~/.bash_profile
    echo ".bash_profile not found: creating empty .bash_profile."
    touch ~/.bash_profile
end
fisher z
