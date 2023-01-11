# Installing NeoVim
1. `cp -r ./nvim ~/.config/`
2. `cd ~/.config/nvim`
3. `nvim init.lua`
4. While in neovim type `:PackerSync`, this will install plugins. Note IT WILL fail the first time you run it because of TreeSitter,
just ignore it :).

# Using Neovim, my workflow
Say I'm working on a project called `foo`

1. `cd foo`
2. `nvim .` opening up directory, that way I have access to all files, within the `foo` folder
3. `CTRL f` to open up a fuzzy finder and search for file I want to go to. This is a lot nicer than looking at the default directory tree in neovim.

I also use terminal from within neovim very often, to open terminal run: `spacebar t` OR type `:term`

Nifty features:
1. Undotree. This thing is amazing. Ever mess up really bad and you didn't do a git commit? Type `spacebar u`, and revert back to the part where you didn't mess up.
2. VimFugitive Run git commands from within neovim. Examples:
    2a. `:Git status`
    2b. `:Git commit`
    2c. `:Git push -u origin`
3. LSP
4. Telescope: Really good fuzzy finder


