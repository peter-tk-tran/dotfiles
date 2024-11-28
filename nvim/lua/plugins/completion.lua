return {
	"hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
	  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      "zbirenbaum/copilot.lua",
      "zbirenbaum/copilot-cmp",
    },
	config = function()
		-- require "custom.snippets"
		vim.opt.completeopt = { "menu", "menuone", "noselect" }

		local lspkind = require "lspkind"
		lspkind.init {
		  symbol_map = {
			Copilot = "",
		  },
		}

		vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

		local kind_formatter = lspkind.cmp_format {
		  mode = "symbol_text",
		  menu = {
			buffer = "[buf]",
			nvim_lsp = "[LSP]",
			nvim_lua = "[api]",
			path = "[path]",
			luasnip = "[snip]",
			gh_issues = "[issues]",
			tn = "[TabNine]",
			eruby = "[erb]",
		  },
		}

		local cmp = require "cmp"

		cmp.setup {
		  -- Enable luasnip to handle snippet expansion for nvim-cmp
		  snippet = {
			expand = function(args)
			  vim.snippet.expand(args.body)
			end,
		  },
		  formatting = {
			fields = { "abbr", "kind", "menu" },
			expandable_indicator = true,
			format = function(entry, vim_item)
			  -- Lspkind setup for icons
			  vim_item = kind_formatter(entry, vim_item)

			  return vim_item
			end,
		  },
		  sources = {
			{ name = "copilot" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer" },
		  },
		  view = {
			  entries = "native",
		  },
		  mapping = {
		    ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
		    ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
			["<C-y>"] = cmp.mapping(
			  cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			  },
			  { "i", "c" }
			),
		  },
		}
	end,
}
