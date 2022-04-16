-- Quick way to navigate to dotfiles
vim.keymap.set("n", "<leader>vrc", function()
    require('telescope').search_dotfiles()
end, {silent = true})

vim.keymap.set("n", "gr", function()
    require('telescope.builtin').lsp_references()
end, {silent = true})

vim.keymap.set("n", "<leader>ps", function()
    require('telescope.builtin').grep_string()
end, {silent = true})

vim.keymap.set("n", "<C-f>", function()
    require("telescope.builtin").find_files()
end, {silent = true})
