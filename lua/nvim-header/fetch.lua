-- File: config.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.3
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

-- TODO: fix this, it breaks nvim when lazy loaded

local M = {}

local function get_extension()

    -- gets the extension of the file
    local filename = vim.fn.expand('%:e')

    -- declares the symbol variable
    local symbol = ''
    local md = false
    local bash = false

    -- checks if the file is a lua file...etc
    if filename == 'lua' then
        symbol = '--'
    elseif filename == 'py' then
        symbol = '#'
    elseif filename == 'sh' then
        symbol = '#'
        bash = true
    elseif filename == 'md' then
        symbol = '[comment]: <> ('
        md = true
    elseif filename == 'txt' then
        symbol = '#'
    elseif filename == 'yaml' then
        symbol = '#'
    elseif filename == 'yml' then
        symbol = '#'
    elseif filename == 'toml' then
        symbol = '#'
    elseif filename == 'ini' then
        symbol = '#'
    elseif filename == 'conf' then
        symbol = '#'
    else
        symbol = '//'       -- default symbol
    end
    return symbol, md, bash
end


local function get_repo()

    -- pulls git repo from git config
    local repo = vim.fn.system('git config remote.origin.url'):gsub('\n', '')

    if repo == '' then
        repo = 'git@github.com:userName/repoName.git'
    end

    return repo

end

local function get_author()

    -- pulls author from git config
    local author = vim.fn.system('git config global user.name'):gsub('\n', '')
    if author == '' then
        author = vim.fn.system('git config --global user.name'):gsub('\n', '')
    end
    return (author ~= '' and author) or 'your_name'

end

return M
