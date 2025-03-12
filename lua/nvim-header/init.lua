-- File: init.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.2
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

-- TODO: fix this, it breaks nvim when lazy loaded

require('nvim-header.config')
require('nvim-header.header')

local M = {}

M.setup = function(user_opts)
    require('nvim-header.config').setup(user_opts)

    vim.api.nvim_create_user_command("HeaderInsert", function()
        require("nvim-header.header").generate_header()
    end, {})

    vim.keymap.set('n', '<leader>mh', function()
        require('nvim-header.header').generate_header()
    end, { noremap = true, silent = true })
end

return M

