-- File: header.lua
-- Author: hobo
-- License: MIT
-- Description: This is probaly trash
-- Version: 0.0.2
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

local config = require("nvim-header.config")

local H = {}

local function get_extension()

    -- gets the extension of the file
    local filename = vim.fn.expand("%:e")

    -- declares the symbol variable
    local symbol = ""
    local md = false

    -- checks if the file is a lua file...etc
    if filename == "lua" then
        symbol = "--"
    elseif filename == "py" then
        symbol = "#"
    elseif filename == "sh" then
        symbol = "#"
    elseif filename == "md" then
        symbol = "[comment]: <> ("
        md = true
    elseif filename == "txt" then
        symbol = "#"
    elseif filename == "yaml" then
        symbol = "#"
    elseif filename == "yml" then
        symbol = "#"
    elseif filename == "toml" then
        symbol = "#"
    elseif filename == "ini" then
        symbol = "#"
    elseif filename == "conf" then
        symbol = "#"
    else
        symbol = "//"       -- default symbol
    end
    return symbol, md
end

-- generates the header
local function generate_header()

    --puls opts from config.lua
    local opts = config.options

    -- creates the header
    local header = {

        "File: " .. opts.author,
        "Author: " .. opts.author,
        "License: " .. opts.license,
        "Description: " .. opts.description,
        "Version: " .. opts.version,
        "Created: " .. opts.date,
        "URL: " .. opts.url  }

    vim.api.nvim_put(header, "l", true, true)

    -- gets the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- gets the extension of the file
    local symbol, md = get_extension()
    local md_concat = ")"

    -- iterates over the header and adds the symbol to the beginning of each line
    -- if its a markdown file it adds ')' to the end of the comment line
    if md == true then
        for i, line in ipairs(header) do
            header[i] = symbol .. "" ..line ..""..md_concat
        end
    else
        for i, line in ipairs(header) do
            header[i] = symbol .. " " .. line
        end
    end

    -- sets the header to the current buffer
    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
end

H.generate_header = generate_header

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>mh", "<cmd>lua require'hobo.utils.header'.generate_header()<CR>", { noremap = true, silent = true })

return H
