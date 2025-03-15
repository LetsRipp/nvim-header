-- File: init_spec.lua
-- Author: hobo
-- License: MIT
-- Description: Testing for nvim-header
-- Testing Version: 0.0.1
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

-- Add the path to the Lua modules
package.path = package.path .. ";/home/hobo/programs/lua/nvim-header/lua/?.lua"
print("Package path: " .. package.path)

-- Mock vim global for testing
---@diagnostic disable: undefined-global
---@diagnostic disable: undefined-field
_G.vim = {
    fn = {
        expand = function(arg)
            if arg == '%:e' then
                return "lua"  -- Return just the extension for get_extension()
            elseif arg == '%:t' then
                return ""  -- Return empty string for file name to trigger fallback
            else
                return "test.lua"  -- Return full filename for other cases
            end
        end,
        system = function(cmd)
            if cmd == 'git config user.name' or cmd == 'git config --global user.name' then
                return '\n'  -- Return empty string to trigger fallback to 'your_name'
            elseif cmd == 'git config remote.origin.url' then
                return '\n'  -- Return empty string to trigger fallback to default repo
            end
            return ''
        end
    },
    api = {
        nvim_put = function() end,
        nvim_get_current_buf = function() return 1 end,
        nvim_buf_set_lines = function() end,
        nvim_create_user_command = function(name, callback, opts) end
    },
    keymap = {
        set = function() end
    }
}

-- Require the modules directly from the lua directory
local fetch = require('nvim-header.fetch')
local init = require('nvim-header.init')

describe('nvim-header', function()
    describe('fetch module', function()
        -- Override the mocks for specific tests
        before_each(function()
            vim.fn.system = function(cmd)
                if cmd == 'git config --global user.name' then
                    return 'Test User\n'
                elseif cmd == 'git config remote.origin.url' then
                    return 'git@github.com:test/repo.git\n'
                end
                return ''
            end
        end)
        
        it('should get the correct file extension symbol', function()
            local symbol, md, bash = fetch.get_extension()
            assert.are.equal('--', symbol)
            assert.is_false(md)
            assert.is_false(bash)
        end)

        it('should get the author name', function()
            local author = fetch.get_author()
            assert.are.equal('Test User', author)
        end)

        it('should get the repository URL', function()
            local repo = fetch.get_repo()
            assert.are.equal('git@github.com:test/repo.git', repo)
        end)
        
        -- Reset the mocks after fetch module tests
        after_each(function()
            vim.fn.system = function(cmd)
                if cmd == 'git config user.name' or cmd == 'git config --global user.name' then
                    return '\n'  -- Return empty string to trigger fallback to 'your_name'
                elseif cmd == 'git config remote.origin.url' then
                    return '\n'  -- Return empty string to trigger fallback to default repo
                end
                return ''
            end
        end)
    end)

    describe('init module', function()
        it('should setup with default options', function()
            init.setup({})
            assert.are.equal('Unknown file', init.options.file)
            assert.are.equal('your_name', init.options.author)
            assert.are.equal('MIT', init.options.license)
            assert.are.equal('This is trash code that would make a real programmer cry blood 🤮', init.options.description)
            assert.are.equal('0.0.0', init.options.version)
            assert.are.equal('%Y-%m-%d', init.options.date)
            assert.are.equal('git@github.com:userName/repoName.git', init.options.repo)
            assert.are.equal('<leader>mh', init.options.keymap)
        end)

        it('should setup with user-defined options', function()
            local user_options = {
                file = 'test.lua',
                author = 'Test Author',
                license = 'GPL-3.0',
                description = 'Test Description',
                version = '1.0.0',
                date = '%d-%m-%Y',
                repo = 'git@github.com:test/repo.git',
                keymap = '<leader>th'
            }
            init.setup(user_options)
            assert.are.equal('test.lua', init.options.file)
            assert.are.equal('Test Author', init.options.author)
            assert.are.equal('GPL-3.0', init.options.license)
            assert.are.equal('Test Description', init.options.description)
            assert.are.equal('1.0.0', init.options.version)
            assert.are.equal('%d-%m-%Y', init.options.date)
            assert.are.equal('git@github.com:test/repo.git', init.options.repo)
            assert.are.equal('<leader>th', init.options.keymap)
        end)

        it('should override default options with user-defined options', function()
            local user_options = {
                author = 'Another Author',
                version = '2.0.0'
            }
            init.setup(user_options)
            assert.are.equal('Unknown file', init.options.file)
            assert.are.equal('Another Author', init.options.author)
            assert.are.equal('MIT', init.options.license)
            assert.are.equal('This is trash code that would make a real programmer cry blood 🤮', init.options.description)
            assert.are.equal('2.0.0', init.options.version)
            assert.are.equal('%Y-%m-%d', init.options.date)
            assert.are.equal('git@github.com:userName/repoName.git', init.options.repo)
            assert.are.equal('<leader>mh', init.options.keymap)
        end)

        it('should handle empty user options gracefully', function()
            init.setup(nil)
            assert.are.equal('Unknown file', init.options.file)
            assert.are.equal('your_name', init.options.author)
            assert.are.equal('MIT', init.options.license)
            assert.are.equal('This is trash code that would make a real programmer cry blood 🤮', init.options.description)
            assert.are.equal('0.0.0', init.options.version)
            assert.are.equal('%Y-%m-%d', init.options.date)
            assert.are.equal('git@github.com:userName/repoName.git', init.options.repo)
            assert.are.equal('<leader>mh', init.options.keymap)
        end)

        it('should setup with various user-defined options', function()
            local user_options = {
                file = 'example.txt',
                author = 'Example Author',
                license = 'Apache-2.0',
                description = 'Example Description',
                version = '0.1.0',
                date = '%Y-%m-%d',
                repo = 'git@github.com:example/repo.git',
                keymap = '<leader>ex'
            }
            init.setup(user_options)
            assert.are.equal('example.txt', init.options.file)
            assert.are.equal('Example Author', init.options.author)
            assert.are.equal('Apache-2.0', init.options.license)
            assert.are.equal('Example Description', init.options.description)
            assert.are.equal('0.1.0', init.options.version)
            assert.are.equal('%Y-%m-%d', init.options.date)
            assert.are.equal('git@github.com:example/repo.git', init.options.repo)
            assert.are.equal('<leader>ex', init.options.keymap)
        end)
    end)
end)
