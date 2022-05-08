local ls = require "luasnip"

ls.config.set_config {
  -- This tells LuaSnip to remember to keep around the last snippet.
  -- You can jump back into it even if you move outside of the selection
  history = true,

  -- This one is cool cause if you have dynamic snippets, it updates as you type!
  updateevents = "TextChanged,TextChangedI",
}

-- <Right> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
-- insert mode and select mode
vim.keymap.set({ "i", "s" }, "<Right>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- <Left> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<Left>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })


vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/plugin/luasnip.lua<CR>")

