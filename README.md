[comment]: <> (File: README.md)
[comment]: <> (Author: hobo)
[comment]: <> (License: MIT)
[comment]: <> (Description: This is trash code that would make a real programmer cry blood 🤮)
[comment]: <> (Version: 0.0.3)
[comment]: <> (Date: 2025-03-12)
[comment]: <> (Repo: git@github.com:LetsRipp/nvim-header.git)

## nvim-header
generates a header for your file pulling information from your local and global git config files
or with your custom options

### for lazy.nvim
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

[comment]: <> (TODO: add packer and vim config)

### for packer
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
### for vim
