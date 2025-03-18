-- File: fetch.lua
-- Author: hobo
-- License: MIT
-- Description: This is trash code that would make a real programmer cry blood 🤮
-- Version: 0.0.4
-- Created: 2025-03-12
-- Last modified: 2025-03-18
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
    local repo = ''

    -- checks if file shares a directory with a path
    local function dir_exists(path)
        local stat = vim.loop.fs_stat(path)
        return stat and stat.type == 'directory'
    end

    -- check for .git and sets the repo or ""
    if dir_exists('.git') then
        local remote = vim.fn.systemlist("git remote get-url origin")[1] or ""
        if remote ~= "" then
            repo = remote
        end
    end

    -- if repo is empty, check for global git config and sets userName
    if repo == "" then
        local userName = vim.fn.systemlist('git config --global user.name')[1] or ""
        -- if userName is not empty, set repo
        if userName ~= "" then
            repo = 'git@github.com:' .. userName .. '/projectName.git'
        else
            repo = 'git@github.com:userName/projectName.git'
        end
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
