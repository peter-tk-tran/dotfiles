#!/bin/bash

vim +PlugInstall +qall
# installing neovim nightly
if hash nvim 2>/dev/null; then
    echo "nvim exists."
else
    echo "Installing nvim"
    brew install neovim
fi

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

mv ~/.vimrc ~/.vimrc.old
cp ./.vimrc ~/.vimrc

rm -r ~/.config/nvim
cp -r ./nvim ~/.config/nvim


# git configuration
git config --global alias.c "commit"
git config --global alias.cm "commit -m"
git config --global alias.a "add ."
git config --global alias.p "push"
git config --global alias.s "status"
# TODO add git hooks logic.



# Python setup
if hash pyright 2>/dev/null; then
    echo "pyright exists"
else
    npm i -g pyright
fi

echo "Installation complete. Please restart your terminal for changes to take effect."
