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
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
                opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
                '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.code_action({
                        context = { only = { "source.organizeImports" } },
                        apply = true,
                    })
                    vim.wait(10)
                end,
            })
            vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
        end
        -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
        local capabilities = require('cmp_nvim_lsp').default_capabilities()


        -- General setup for all language servers
        vim.lsp.config('*', {
            capabilities = capabilities,
            on_attach = on_attach,
            root_markers = { ".git" },
        })

        -- Python LSP setup
        vim.lsp.config('pyright', {
            -- Command and arguments to start the server.
            cmd = { 'pyright-langserver', '--stdio' },
            filetypes = { "python" },
            root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
            single_file_support = true,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = 'workspace',
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = 'on',
                        -- Ignore all files for analysis to exclusively use Ruff for linting
                        ignore = { '*' },
                    },
                },
            },
        })
        vim.lsp.config('ruff', {
            init_options = {
                settings = {
                    lint = {
                        -- args = {"--config=~/Documents/Joule-The-SI-Copilot--Approaches/pyproject.toml"}, -- Specify linting args here
                        enable = true, -- Enable linting
                        run = "onSave" -- Run linting on save
                    },
                    fixAll = true,
                    organizeImports = true,
                }
            }
        })
        vim.lsp.enable('pyright')
        vim.lsp.enable('ruff')

        -- TypeScript/JavaScript LSP setup
        vim.lsp.config("ts_ls", {
            cmd = { "typescript-language-server", "--stdio" },
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', 'pnpm-workspace.yaml', 'yarn.lock', '.git' },
        }
        )
        vim.lsp.enable('ts_ls')

        -- require('lspconfig').cds_lsp.setup {
        --     root_dir = function() return vim.loop.cwd() end,
        --     filetypes = { "cds" } -- Attach to .cds files
        -- }

        -- vim.filetype.add({
        --     extension = {
        --         cds = "cds",
        --     },
        -- })

        -- require('lspconfig').rust_analyzer.setup {
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     settings = {
        --         ["rust-analyzer"] = {
        --             imports = { granularity = { group = "module" }, prefix = "self" },
        --             cargo = { buildScripts = { enable = true } },
        --             procMacro = { enable = true }
        --         }
        --     }
        -- }
        --

        -- LUA LSP setup
        vim.lsp.config('lua_ls', {
            filetypes = { "lua" }
        })
        vim.lsp.enable('lua_ls')

        -- require('lspconfig').postgres_lsp.setup {
        --     cmd = { "postgrestools", "lsp-proxy" },
        --     filetypes = { "sql" },
        --     single_file_support = true,
        -- }
        -- vim.cmd("nmap <silent> <Leader>b Obreakpoint()  # XXX<Esc>")
    end
}
