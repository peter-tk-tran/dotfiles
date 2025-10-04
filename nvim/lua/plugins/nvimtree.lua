-- -- -- disable netrw at the very start of your init.lua
-- -- vim.g.loaded_netrw = 1
-- -- vim.g.loaded_netrwPlugin = 1

-- -- -- optionally enable 24-bit colour
-- -- vim.opt.termguicolors = true

-- -- empty setup using defaults
-- require("nvim-tree").setup()

-- -- -- OR setup with some options
-- -- require("nvim-tree").setup({
-- --   sort = {
-- --     sorter = "case_sensitive",
-- --   },
-- --   view = {
-- --     width = 30,
-- --   },
-- --   renderer = {
-- --     group_empty = true,
-- --   },
-- --   filters = {
-- --     dotfiles = true,
-- --   },
-- -- })
--
-- return {
--   "nvim-tree/nvim-tree.lua",
--   config = function ()
--     -- Load the nvim-tree plugin with default settings
--     require("nvim-tree").setup()
--   end
-- }
return {}
