#!/bin/bash

# installing wget
if hash wget 2>/dev/null; then
    echo "wget exists."
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

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

function update_rc {
    to_append="source $SCRIPT_DIR/.rc"
    echo $to_append
    if grep -Fxq $to_append $1; then
        echo "config already in $1 file."
    else
        echo $to_append >> $1
    fi
}

if [[ $SHELL =~ "zsh" ]]; then
    update_rc "$HOME/.zshrc"

elif [[ $SHELL =~ "bash" ]]; then
    update_rc "$HOME/.bashrc"
else
    echo "What shell are you using?"
fi

# git configuration
git config --global alias.c "commit"
git config --global alias.cm "commit -m"
git config --global alias.a "add ."
git config --global alias.p "push"
git config --global alias.s "status"
# TODO add git hooks logic.

echo "Installation complete. Please restart your terminal for changes to take effect."
