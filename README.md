# Dotfiles

## Neovim
Note: My current nvim version is `0.9.5`
I think as long as you're above this version you should be good.
`https://github.com/neovim/neovim`

### Setup
1. Copy nvim config `cp -r nvim ~/.config/nvim`
2. Install packer (nvim plugin manager): `git clone --depth 1 https://github.com/wbthomason/packer.nvim\ ~/.local/share/nvim/site/pack/packer/start/packer.nvim`
3. Installing packages:
    1. `cd ~/.config/nvim`
    2. `nvim init.lua`
    3. Run nvim command `:PackerInstall`
4. Syntax highlighting Treesitter `:TSInstall  <whatever language you use>`
