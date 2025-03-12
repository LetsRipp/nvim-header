-- File: header.lua
-- Author: author_name
-- License: MIT
-- Description: nvim extension that pulls info from git config and creates a header
-- Version: 0.0.2
-- Date: 25-03-11
-- URL: https://github.com/some_username/some_repo/

local config = require("nvim-header.config")

local H = {}

local function get_extension()

    -- gets the extension of the file
    local filename = vim.fn.expand("%:e")

    -- declares the symbol variable
    local symbol = ""

    -- checks if the file is a lua file...etc
    if filename == "lua" then
        symbol = "--"
    elseif filename == "py" then
        symbol = "#"
    elseif filename == "sh" then
        symbol = "#"
    elseif filename == "md" then
        symbol = "#"
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
    return symbol
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
    local symbol = get_extension()

    -- iterates over the header and adds the symbol to the beginning of each line
    for i, line in ipairs(header) do
        header[i] = symbol .. " " .. line
    end

    -- sets the header to the current buffer
    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
end

H.generate_header = generate_header

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>mh", "<cmd>lua require'hobo.utils.header'.generate_header()<CR>", { noremap = true, silent = true })

return H
