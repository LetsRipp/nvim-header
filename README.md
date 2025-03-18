[comment]: <> (File: README.md)
[comment]: <> (Author: hobo)
[comment]: <> (License: MIT)
[comment]: <> (Description: This is trash code that would make a real programmer cry blood 🤮)
[comment]: <> (Version: 0.0.3)
[comment]: <> (Date: 2025-03-12)
[comment]: <> (Repo: git@github.com:LetsRipp/nvim-header.git)

## nvim-header
![nvim-header](https://img.shields.io/badge/nvim--header-v0.0.4-blue.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Author: hobo](https://img.shields.io/badge/Author-hobo-green.svg)<BR>
generates a header for your file pulling information from your local and global git config files
or with your custom options

### for lazy.nvim 👍
```lua
return{
    "LetsRipp/nvim-header",
    dependencies = {'nvim-tree/nvim-web-devicons'},
    lazy = true,
    cmd = "HeaderInsert",
    config = function()
        require("nvim-header").setup({
            -- **user defined fields**
            -- keymap = "<leader>mh",                       default is <leader>mh
            -- author = "name",                             default will  pull from git config
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
```

>[!WARNING]    
I have not tested installation with packer or plug<BR>
If they are broken, submit an issue and I will fix it

### for packer ❓
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
### for vim-plug ❓
```vimrc
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
#### then run 
```
:PlugInstall
```
## 🚀 upcoming features

- [ ] additional themes
- [ ] versioning updating
- [ ] add date modified
- [ ] date modified updating

## Requirements

- Neovim 0.7+
