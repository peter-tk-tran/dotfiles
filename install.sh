# installing wget
if hash wget 2>/dev/null; then
    echo "Wget exists."
else
    echo "Installing wget"
    brew install wget
fi

# installing neovim nightly
if hash nvim 2>/dev/null; then
    echo "nvim exiss."
else
    echo "Installing nvim nightly"
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
fi

# add git stuff.
git config --global alias.c "commit"
git config --global alias.cm "commit -m"
git config --global alias.a "add ."
git config --global alias.p "push"
git config --global alias.s "status"
