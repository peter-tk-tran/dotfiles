local M = {} -- this is a table in lua
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "< VimRC >",
        cwd = "~/.config/nvim",
    })
end


M.search_sql = function()
    require("telescope.builtin").find_files({
        prompt_title = "< PSQL >",
        cwd = "~/Documents/sql",
    })
end


M.search_jira = function()
    require("telescope.builtin").find_files({
        prompt_title = "< JIRA >",
        cwd = "~/Documents/tickets",
    })
end

M.search_orms = function()
    require("telescope.builtin").find_files({
        prompt_title = "< ORMs >",
        cwd = "~/Documents/Projects/BP/bp/database",
    })
end


-- TODO make telescope for datasets.
return M
