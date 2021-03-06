#!/bin/bash
setup_vim() {
    # installing neovim nightly
    if hash nvim 2>/dev/null; then
        echo "nvim exists."
    else
        echo "Installing nvim"
        brew install neovim --HEAD
    fi

    # setting up packer; this manages neovim plugins
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim


    # moving init.vim
    mv ~/.vimrc ~/.vimrc.old
    cp ./.vimrc ~/.vimrc

    mv ~/.config/nvim ~/.config/old_nvim
    cp -r ./nvim ~/.config/nvim

    # Install vim plugins
    vim +PlugInstall +qall

    # Install neovim plugins
    nvim +PackerSync
}

setup_langserver() {
    if hash efm-langserver 2>/dev/null; then
        echo "efm-langserver exists"
    else
        brew install efm-langserver
    fi
}

setup_python_env() {
    # Python setup
    if hash pyright 2>/dev/null; then
        echo "pyright exists"
    else
        npm i -g pyright
    fi

    if hash black 2>  /dev/null; then
        echo "black exists"
    else
        brew install black

    fi

    if hash isort 2>  /dev/null; then
        echo "isort exists"
    else
        brew install isort
    fi
}

# git configuration
git config --global alias.c "commit"
git config --global alias.cm "commit -m"
git config --global alias.a "add ."
git config --global alias.p "push"
git config --global alias.s "status"
# TODO add git hooks logic.

setup_vim
setup_python_env
setup_langserver
