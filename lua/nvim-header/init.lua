-- File: init.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.0
-- Date: Sat 15 Mar 2025 02:21:23 PM EDT
-- Repo: git@github.com:userName/repoName.git
--
-- File: init.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.4
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

local fetch = require('nvim-header.fetch')
local M = {}

-- Setup function called by the plugin
M.setup = function(opts)
    opts = opts or {}

    -- Default options
    M.options = {
        file = vim.fn.expand("%:t") ~= "" and vim.fn.expand("%:t") or "Unknown file",
        author = fetch.get_author(),
        license = "MIT",
        description = "This is trash code that would make a real programmer cry blood 🤮",
        version = "0.0.0",
        date = "%Y-%d-%m",
        repo = fetch.get_repo(),
        keymap = "<leader>mh"
    }

    -- Override defaults with user options
    for k, v in pairs(opts) do
        M.options[k] = v
    end

    -- Create keymap if user has set one
    if M.options.keymap then
        vim.keymap.set(
            'n',
            M.options.keymap,
            '<cmd>HeaderInsert<CR>',
            { noremap = true, silent = true, desc = "Insert Header" }
        )
    end

    -- Create user command
    vim.api.nvim_create_user_command("HeaderInsert", function()
        M.insert_header()
    end, {})
end

-- Generate and insert the header
M.insert_header = function()

    -- Create the header content
    local header_content = {
        'File: ' .. vim.fn.expand("%:t"),
        'Author: ' .. M.options.author,
        'License: ' .. M.options.license,
        'Description: ' .. M.options.description,
        'Version: ' .. M.options.version,
        'Created: ' .. os.date(M.options.date),
        'Repo: ' .. M.options.repo
    }

    -- Get the file type and comment symbols
    local symbol, md, bash = fetch.get_extension()
    local formatted_header = {}

    -- Format header based on file type
    if md then
        -- Markdown format
        for _, line in ipairs(header_content) do
            table.insert(formatted_header, symbol .. line .. ')')
        end
    elseif bash then
        -- Bash format with shebang
        table.insert(formatted_header, "#!/bin/bash")
        for _, line in ipairs(header_content) do
            table.insert(formatted_header, symbol .. ' ' .. line)
        end
    else
        -- Default format
        for _, line in ipairs(header_content) do
            table.insert(formatted_header, symbol .. ' ' .. line)
        end
    end

    -- Add a blank line after the header
    table.insert(formatted_header, "")

    -- Get the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- Insert the header at the top of the file
    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, formatted_header)
end

return M

