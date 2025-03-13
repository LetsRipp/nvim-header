-- File: init.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.3
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

-- TODO: fix this, it breaks nvim when lazy loaded


local M = {}

local header = require('nvim-header.header')
local fetch = require('nvim-header.fetch')

M.setup = function(opts)

    -- default options
    M.options = vim.tbl_deep_extend('force', {

        file = vim.fn.expand("%:t"),
        author = fetch.get_author(),
        license = "MIT",
        description = "This is trash code that would make a real programmer cry blood 🤮",
        version = "0.0.0",
        date_format = os.date("%Y-%m-%d"),
        repo = fetch.get_repo(),
        keymap = "<leader>mh"

    }, opts or {})

    -- create user command
    vim.api.nvim_create_user_command("HeaderInsert", function()
        header.generate_header(M.options)
    end, {})

    -- create keymap if user has set one
    if M.options.keymap then
        vim.keymap.set(
        'n',
        M.options.keymap,
        '<cmd>HeaderInsert<CR>',
        { noremap = true, silent = true }
        )
    end
 
end

return M

