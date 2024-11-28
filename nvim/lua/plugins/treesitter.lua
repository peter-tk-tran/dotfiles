return {
	'nvim-treesitter/nvim-treesitter',
	build = ":TSUpdate",
	config = function()
		require('nvim-treesitter.configs').setup({
			highlight = {
				enable = true,
				disable = {},
			},
			indent = {
				enable = false,
				disable = {},
			},
			ensure_installed = {
				'python',
				'sql',
				'typescript',
				'javascript',
				'rust'
			},
		}
		)
	end
}
