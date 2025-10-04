return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap-python",
        },
        config = function()
            local dap = require "dap"
            local ui = require "dapui"
            ui.setup({})

            dap.set_log_level("TRACE")


            require("dap-python").setup("/Users/I747624/Documents/CAP-Copilot/.venv/bin/python")
            -- Python configurations
            table.insert(dap.configurations.python,
                {
                    type = "python",
                    request = "launch",
                    name = "Launch Module",
                    module = "src",             -- Specify the module name here (replace "src" with your module name)
                    args = {},                  -- Optional: Add command-line arguments
                    justMyCode = false,         -- Optional: Debug only your code
                    cwd = "${workspaceFolder}", -- Set the working directory
                }
            )

            -- depending on your installation location.
            -- local debugger_location = os.getenv("HOME") .. "/Software/vscode-node-debug2"

            -- dap.adapters.node = {
            -- 	type = "executable",
            -- 	command = "node",
            -- 	args = { debugger_location .. "/out/src/nodeDebug.js" },
            --  }

            -- Add NodeJS debugger configuration
            dap.adapters["pwa-node"] = {
                type = "server",
                host = "::1",
                port = "${port}",
                executable = {
                    command = "js-debug-adapter",
                    args = { "${port}" },
                },
            }

            for _, language in ipairs({ "typescript", "javascript" }) do
                require("dap").configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require 'dap.utils'.pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Mocha Tests",
                        -- trace = true, -- include debugger info
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/mocha/bin/mocha.js",
                            "--recursive", -- Ensure all test files are included
                            "test/**/*.js" -- Match your test files
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    }

                }
            end

            -- local last_args = nil
            -- dap.configurations.javascript = {
            -- 	{
            -- 		type = "pwa-node",
            -- 		request = "launch",
            -- 		name = "Launch Program",
            -- 		program = "${file}",
            -- 		cwd = "${workspaceFolder}",
            -- 	},
            -- 	{
            -- 		type = "pwa-node",
            -- 		request = "launch",
            -- 		name = "Debug Mocha Tests",
            -- 		program = "${workspaceFolder}/node_modules/.bin/mocha",
            -- 		args = function()
            -- 			if last_args then
            -- 				return last_args
            -- 			end
            -- 			return { "--no-timeouts", "--require", "chai/register-expect.js", "${file}" }
            -- 		end,
            -- 		cwd = "${workspaceFolder}",
            -- 		skipFiles = { "<node_internals>/**" },
            -- 		console = "integratedTerminal",
            -- 	}
            -- }


            vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
            vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

            -- Eval var under cursor
            vim.keymap.set("n", "<space>?", function()
                require("dapui").eval(nil, { enter = true })
            end)

            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.step_into)
            vim.keymap.set("n", "<F3>", dap.step_over)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F5>", dap.step_back)
            vim.keymap.set("n", "<F13>", dap.restart)

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            -- -- Hook to capture args on start
            -- dap.listeners.before.["store_args"] = function(session, body)
            -- local config = session.config
            -- last_args = config.args
            -- end
            dap.listeners.before.event_terminated.dapui_config = function(session, body)
                local config = session.config
                last_args = config.args
                -- ui.close()
            end
            -- dap.listeners.before.event_exited.dapui_config = function()
            --   ui.close()
            -- end
        end,
    },
}
