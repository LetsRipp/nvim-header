-- File: fetch.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.3
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

local F = {}

-- Gets the comment symbol based on file extension
F.get_extension = function()

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
    elseif filename == 'yaml' or filename == 'yml' then
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


F.get_repo = function()

    -- pulls git repo from git config
    local repo = vim.fn.system('git remote get-url origin'):gsub('\n', '')

    if repo == '' then
        repo = 'git@github.com:userName/repoName.git'
    end

    return repo

end

-- Gets the author name from git config
F.get_author = function()
    -- pulls author from git config
    local author = vim.fn.system('git config user.name'):gsub('\n', '')
    if author == '' then
        author = vim.fn.system('git config --global user.name'):gsub('\n', '')
    end

    return (author ~= '' and author) or 'your_name'
end

return F
