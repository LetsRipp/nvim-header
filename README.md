# nvim-header

![nvim-header](https://img.shields.io/badge/nvim--header-v0.0.3-blue.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Author: hobo](https://img.shields.io/badge/Author-hobo-green.svg)

## Description

`nvim-header` generates a header for your file by pulling information from your local and global git config files or with your custom options.

## Installation

### Using lazy.nvim

```lua
return {
    "LetsRipp/nvim-header",
    dependencies = {},
    opts = {
        -- **user defined fields**
        -- keymap = "<leader>mh",                       default is <leader>mh
        -- author = "name",                             default will pull from git config
        -- license = "GPL-3.0"                          default is MIT
        -- version = "1.0.0",                           default is 0.0.0
        -- repo = "git@github.com:userName/repoName"    default will pull from git config 
        -- date_format = os.date("%d-%m-%Y")            default is %Y-%m-%d or (2025-01-15) 
            -- options are
            -- %D(date in dd/mm/yy format)
            -- %H:%M (hour:min)
-- %Y (year in yyyy format)
            -- %d (day in dd format)
            -- %m (month in mm format) 
            -- %y (year in yy format)
    },
    lazy = true,
    cmd = { "HeaderInsert", "HeaderUpdateTime" },
    keys = {
        { '<leader>mh', '<cmd>HeaderInsert<cr>' },
        { '<leader>ut', '<cmd>HeaderUpdateTime<cr>' },
    },
}
> **Warning**
> I have not tested vim-plug or packer.nvim. If they are broken, let me know, I will fix it.

### Using packer.nvim

```lua
return require('packer').startup(function(use)
    use {
        'LetsRipp/nvim-header',
        dependencies = {'nvim-tree/nvim-web-devicons'},
        lazy = true,
        cmd = "HeaderInsert",
        config = function()
            require("nvim-header").setup({
                -- **user defined fields**
                -- keymap = "<leader>mh",                       default is <leader>mh
                -- author = "name",                             default will pull from git config
                -- license = "GPL-3.0"                          default is MIT
                -- version = "1.0.0",                           default is 0.0.0
                -- repo = "git@github.com:userName/repoName"    default will pull from git config 
                -- date_format = os.date("%d-%m-%Y")            default is %Y-%m-%d or (2025-01-15) 
                -- options are
                -- %D(date in dd/mm/yy format)
                -- %H:%M (hour:min)
                -- %Y (year in yyyy format)
                -- %d (day in dd format)
                -- %m (month in mm format) 
                -- %y (year in yy format)
            })
        end
    }
end)
```

### Using vim-plug

```vim
" Start the plugin block
call plug#begin('~/.vim/plugged')

" Add the plugin with its dependencies and lazy loading
Plug 'LetsRipp/nvim-header'
Plug 'nvim-tree/nvim-web-devicons'

" End the plugin block
call plug#end()

" Configuration for nvim-header
augroup NvimHeaderConfig
  autocmd!
  autocmd FileType * lua require("nvim-header").setup({
      -- **user defined fields**
      -- keymap = "<leader>mh",                       default is <leader>mh
      -- author = "name",                             default will pull from git config
      -- license = "GPL-3.0"                          default is MIT
      -- version = "1.0.0",                           default is 0.0.0
      -- repo = "git@github.com:userName/repoName"    default will pull from git config 
      -- date_format = os.date("%d-%m-%Y")            default is %Y-%m-%d or (2025-01-15) 
      -- options are
      -- %D(date in dd/mm/yy format)
      -- %H:%M (hour:min)
      -- %Y (year in yyyy format)
      -- %d (day in dd format)
      -- %m (month in mm format) 
      -- %y (year in yy format)
  })
augroup END
```

After adding the configuration, run `:PlugInstall`.

## Issues

Please submit issues if found.

## TODO

1. Add ability to update header to current date for versioning.
2. Add different formats.
```


