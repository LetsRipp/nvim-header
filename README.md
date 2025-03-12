# nvim-header
generates a header for your file

### insert the following into your nvim-header.lua file for lazy.nvim
```lua
return{
    "LetsRipp/nvim-header",
    dependencies = {},
    lazy = true,
    cmd = "HeaderInsert",
    config = function()
        require("nvim-header").setup({
            -- **user defined fields**
            -- keymap = "<leader>mh",               default is <leader>mh
            -- author = "name",                     default will  pull from git config
            -- license = "GPL-3.0"                  default is MIT
            -- version = "1.0.0",                   default is 0.0.0
            -- url = "your_url.com"                 default will pull from git config 
            -- date_format = os.date("%d-%m-%Y")    default is %Y-%m-%d or (2025-01-15) 
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

[comment]: #(TODO add packer and vim config)

### TODO packer load
### TODO vim load
