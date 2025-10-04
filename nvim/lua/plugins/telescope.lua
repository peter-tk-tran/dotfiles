function search_dotfiles()
    require('telescope.builtin').find_files({
        prompt_title = "< VimRC >",
        cwd = "~/.config/nvim/",
    })
end

function search_sql()
    require('telescope.builtin').find_files({
        prompt_title = "< SQL Files >",
        cwd = "~/Documents/sql",
    })
end

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        vim.keymap.set("n", "<leader>vrc", function() search_dotfiles() end, { silent = true })
        vim.keymap.set("n", "<leader>sql", function() search_sql() end, { silent = true })

        vim.keymap.set("n", "gr", function()
            require('telescope.builtin').lsp_references()
        end, { silent = true })

        vim.keymap.set("n", "<leader>prw", function()
            require('telescope.builtin').grep_string()
        end, { silent = true })

        vim.keymap.set("n", "<C-f>", function()
            require("telescope.builtin").find_files()
        end, { silent = true })

        vim.keymap.set("n", "<leader>lg", function()
            require("telescope.builtin").live_grep()
        end, { silent = true })
    end
}
