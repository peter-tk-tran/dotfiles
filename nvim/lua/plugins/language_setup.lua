return {
    'neovim/nvim-lspconfig',
    dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
        "saadparwaiz1/cmp_luasnip",
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
    },

    config = function()
        require("mason").setup()

        local opts = { noremap = true, silent = true }

        -- global diagnostics keymaps
        vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
        vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

        -- on_attach: buffer local LSP keymaps
        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                opts)
            vim.api.nvim_buf_set_keymap(
                bufnr,
                'n',
                '<space>wl',
                '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                opts
            )
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
        end

        -- capabilities from nvim-cmp
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        capabilities.offsetEncoding = { "utf-8" }

        -- format on save if server supports textDocument/formatting
        local lsp_group = vim.api.nvim_create_augroup('my.lsp', {})

        vim.api.nvim_create_autocmd('LspAttach', {
            group = lsp_group,
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                if not client:supports_method('textDocument/willSaveWaitUntil')
                    and client:supports_method('textDocument/formatting') then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = lsp_group,
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                        end,
                    })
                end
            end,
        })

        -- Ruff organize imports and fixAll on save for Python
        local ruff_group = vim.api.nvim_create_augroup("RuffOnSave", {})

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = ruff_group,
            pattern = "*.py",
            callback = function()
                vim.lsp.buf.code_action({
                    context = {
                        -- only = { "source.fixAll.ruff", "source.organizeImports.ruff" },
                        only = { "source.organizeImports.ruff" },
                    },
                    apply = true,
                })
            end,
        })

        -- helper to enable servers with shared on_attach and capabilities
        local function enable(server, config)
            config = config or {}
            config.on_attach = on_attach
            config.capabilities = config.capabilities or capabilities
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end

        -- Python Ruff LSP setup (lint, fixes, import order)
        enable('ruff', {
            init_options = {
                settings = {
                    lint = {
                        enable = true,
                        run = "onSave",
                    },
                    fixAll = true,
                    organizeImports = true,
                },
            },
        })

        -- other language servers
        enable('rust_analyzer')
        enable('pyright')
        enable('ts_ls')
        enable('lua_ls')
    end,
}
