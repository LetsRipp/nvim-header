-- File: init_spec.lua
-- Author: hobo
-- License: MIT
-- Description: Testing for nvim-header
-- Testing Version: 0.0.1
-- Date: 2025-03-12
-- Repo: git@github.com:LetsRipp/nvim-header.git

-- Mock vim global for testing
_G.vim = {
    fn = {
        expand = function(arg)
            return "test.lua"  -- Mock file extension for testing
        end,
        system = function(cmd)
            if cmd == 'git config --global user.name' then
                return 'Test User\n'
            elseif cmd == 'git config remote.origin.url' then
                return 'git@github.com:test/repo.git\n'
            end
            return ''
        end
    },
    api = {
        nvim_put = function() end,
        nvim_get_current_buf = function() return 1 end,
        nvim_buf_set_lines = function() end
    }
}

-- Require the modules directly from the lua directory
local fetch = require('nvim-header.fetch')
local header = require('nvim-header.header')

describe('nvim-header', function()
    describe('fetch module', function()
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
    end)
end)
