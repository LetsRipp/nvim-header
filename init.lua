-- File: init.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.2
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

local config = require("nvim-header.config")

local M = {}

-- loads plugin only when :HeaderInsert is run
M.setup = function(user_opts)
    config.setup(user_opts)
    vim.api.nvim_create_user_command("HeaderInsert", function()
        require("header.lua").generate_header()
    end, {})
end

return M

