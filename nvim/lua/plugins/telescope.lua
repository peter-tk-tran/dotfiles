function search_dotfiles()
	require('telescope.builtin').find_files({
		prompt_title = "< VimRC >",
		cwd = "~/.config/nvim/",
	})
end

return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
        "nvim-lua/plenary.nvim"
    },
	config = function()
		-- Quick way to navigate to dotfiles
		vim.keymap.set("n", "<leader>vrc", function()
			search_dotfiles()
		end, {silent = true})

		vim.keymap.set("n", "gr", function()
			require('telescope.builtin').lsp_references()
		end, {silent = true})

		vim.keymap.set("n", "<leader>prw", function()
			require('telescope.builtin').grep_string()
		end, {silent = true})

		vim.keymap.set("n", "<C-f>", function()
			require("telescope.builtin").find_files()
		end, {silent = true})

		vim.keymap.set("n", "<leader>lg", function()
			require("telescope.builtin").live_grep()
		end, {silent = true})

		-- Quick way to navigate to sql files
		vim.keymap.set("n", "<leader>sql", function()
			require('telescope').search_sql()
		end, {silent = true})

		-- Quick way to navigate to sql files
		vim.keymap.set("n", "<leader>ji", function()
			require('telescope').search_jira()
		end, {silent = true})

		vim.keymap.set("n", "<leader>orm", function()
			require('telescope').search_orms()
		end, {silent = true})
	end
}
