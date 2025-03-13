-- File: header.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.2
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

-- TODO: this breaks the whole system when lazy loaded 

local fetch = require('nvim-header.fetch')
local init = require('nvim-header.init')

local H = {}


-- generates the header
H.generate_header = function(opts)

    -- creates the header
    local header = {

        'File: ' .. opts.author,
        'Author: ' .. opts.author,
        'License: ' .. opts.license,
        'Description: ' .. opts.description,
        'Version: ' .. opts.version,
        'Created: ' .. opts.date,
        'URL: ' .. opts.url  }

    vim.api.nvim_put(header, 'l', true, true)

    -- gets the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- gets the extension of the file
    local symbol, md, bash = fetch.get_extension()
    local md_concat = ')'
    local bashFirstLine = '#!/bin/bash'

    -- iterates over the header and adds the symbol to the beginning of each line
    -- if its a markdown file it adds ')' to the end of the comment line
    if md == true then
        for i, line in ipairs(header) do
            header[i] = symbol .. '' ..line ..''..md_concat
        end
    elseif bash == true then
        table.insert(header, 1, bashFirstLine)
    else
        for i, line in ipairs(header) do
            header[i] = symbol .. ' ' .. line
        end
    end

    -- sets the header to the current buffer
    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
end

return H
