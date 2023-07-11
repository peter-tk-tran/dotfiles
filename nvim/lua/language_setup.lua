-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
		'<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
	-- require "lsp_signature".setup({})
	--
	--
	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
end
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pyright'].setup {
	root_dir = function() return vim.loop.cwd() end,
	on_attach = on_attach,
	single_file_support = true,
	capabilities = capabilities,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				typeCheckingMode = 'on'
			}
		}
	}
}

require('lspconfig')['rust_analyzer'].setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			imports = { granularity = { group = "module" }, prefix = "self" },
			cargo = { buildScripts = { enable = true } },
			procMacro = { enable = true }
		}
	}
}

require "lspconfig".efm.setup {
	init_options = { documentFormatting = true },
	filetypes = { 'python', 'sql', 'json', 'lua' },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			python = {
				{
					formatCommand =
					"isort --line-length 120 -m VERTICAL_HANGING_INDENT --tc --profile black -",
					-- "isort --line-length 120 -m VERTICAL_HANGING_INDENT -sp ~/.isort.cfg --tc --profile black -",
					formatStdin = true
				}, {
				formatCommand = "black --line-length 120 --quiet --preview -",
				formatStdin = true
			}
			},
			sql = {
				{ formatCommand = "pg_format -i -s 2 -W 1", formatStdin = true }
			},
			lua = { { formatCommand = "lua-format -i --column_width 120", formatStdin = true } }
		}
	},
	on_attach = on_attach
}

require 'lspconfig'.lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' }
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true)
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false }
		}
	}
}

vim.cmd("nmap <silent> <Leader>b Obreakpoint()  # XXX<Esc>")
