return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/popup.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use 'nvim-telescope/telescope-fzy-native.nvim'
	use 'nvim-telescope/telescope-media-files.nvim'
	use 'mbbill/undotree'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-repeat'
	use 'tpope/vim-fugitive'
	use 'bronson/vim-trailing-whitespace'
	use {'kkoomen/vim-doge', run = ':call doge#install()'}

	-- Visual
	use { "catppuccin/nvim", as = "catppuccin" }
	use { "ellisonleao/gruvbox.nvim" } -- Never forget your roots
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
	use { "nvim-tree/nvim-tree.lua" }
	use { 'norcalli/nvim-colorizer.lua' }

	-- Auto Completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	-- Snippets
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	use "ray-x/lsp_signature.nvim"
	use 'onsails/lspkind-nvim'

	-- Lsp
	use "williamboman/mason-lspconfig.nvim"
	use 'williamboman/mason.nvim'
	use 'neovim/nvim-lspconfig'
	use 'lukas-reineke/lsp-format.nvim'
	use 'mattn/efm-langserver'

	use {
		"danymat/neogen",
		config = function()
			require('neogen').setup {}
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	}
end)
