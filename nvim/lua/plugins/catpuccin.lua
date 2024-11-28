return {
	'catppuccin/nvim',
	config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- Change this to your preferred flavor
        })

        -- Set the colorscheme
        vim.cmd.colorscheme("catppuccin")
    end
}
