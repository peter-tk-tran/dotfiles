vim.g.mapleader = " "

vim.opt.mouse = "a"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.cmd("nnoremap <leader>u :UndotreeToggle<cr>")

-- Colors
vim.opt.termguicolors = true

-- Tabbing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Copies current path to register
-- vim.cmd('nmap cp :let @" = expand("%:p")<CR>')
-- save to clipboard isntead
vim.cmd('nmap cp :let @+ = expand("%:p")<CR>')


-- Map sort function
vim.cmd("vnoremap <Leader>s :sort<CR>")

-- Better indentation
vim.cmd("vnoremap < <gv")
vim.cmd("vnoremap > >gv")

-- Terminal

-- Convert this to lua
Term_split = function()
	local window_height = vim.fn.winheight(0)
	local split_height = window_height / 3
	vim.api.nvim_command("belowright " .. split_height .. "new")
	vim.api.nvim_command("terminal")
end


vim.cmd('set shell=/bin/zsh')
vim.keymap.set('n', '<Leader>t', ':lua Term_split()<CR>')
-- "term://zsh
vim.cmd("tnoremap <Esc> <C-\\><C-n>")

-- Split windows are slimmer, we have a global status line
vim.opt.laststatus = 3
vim.cmd("highlight WinSeparator guibg=None")

vim.opt.scrolloff = 5 -- Set minimum space above and below cursor
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.colorcolumn = "120"
vim.opt.ignorecase = true -- set search to be case insensitive
vim.opt.smartcase = true  -- set search to be case sensitive when item has upper case letter

-- Git
vim.keymap.set('n', '<leader>gs', ':G<CR>')
vim.keymap.set('n', '<leader>gf', ':diffget //2<CR>')
vim.keymap.set('n', '<leader>gj', ':diffget //3<CR>')

vim.keymap.set('v', '<C-c>', '"+y<CR><CR>')
-- Sexy moving selected things around
-- vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")

-- Quick Fix List
vim.keymap.set('n', '<C-n>', ':cnext<CR>')
vim.keymap.set('n', '<C-p>', ':cprev<CR>')

vim.g.snippets = "luasnip"
require('plugins')
require('language_setup')
require('snips')
require('auto_complete')

vim.opt.wrap = false

require 'nvim-treesitter.configs'.setup {
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
-- Normie colorscheme
require("catppuccin").setup({
	flavour = "mocha",          -- latte, frappe, macchiato, mocha
	transparent_background = true, -- disables setting the background color. Matches the terminal background
	term_colors = true,         -- sets terminal colors (e.g. `g:terminal_color_0`)
	no_italic = false,          -- Force no italic
	no_bold = false,            -- Force no bold
	no_underline = false,       -- Force no underline
	styles = {
		-- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { "italic" }, -- Change the style of comments
		conditionals = { "italic" },
	},
	color_overrides = {},
	custom_highlights = {},
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		notify = false,
		mini = false,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
})
vim.cmd.colorscheme "catppuccin-mocha"
require "lsp_signature".setup()
