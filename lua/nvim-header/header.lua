-- File: header.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.2
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

-- TODO: the new error is header.lua line 28: attemt to concatenate 
-- field: date, a nill value 

local fetch = require('nvim-header.fetch')
local init = require('nvim-header.init')

local H = {}

-- generates the header
function H.generate_header(opts)

    -- creates the header
    local header = {
        'File: ' .. opts.file,
        'Author: ' .. opts.author,
        'License: ' .. opts.license,
        'Description: ' .. opts.description,
        'Version: ' .. opts.version,
        'Created: ' .. opts.date_format,
        'URL: ' .. opts.repo
    }

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
            header[i] = symbol .. '' .. line .. '' .. md_concat
        end
    elseif bash == true then
        table.insert(header, 1, bashFirstLine)
        -- Skip the shebang line
        for i, line in ipairs(header) do
            if i > 1 then                  header[i] = symbol .. ' ' .. line
            end
        end
    else
        for i, line in ipairs(header) do
            header[i] = symbol .. ' ' .. line
        end
    end

    -- sets the header to the current buffer
    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
end

return H
