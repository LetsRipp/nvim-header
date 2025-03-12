-- File: nvim-header.lua
-- Author: hobo
-- License: MIT
-- Description: This is probaly trash
-- Version: 0.0.0
-- Date: 2025-03-12
-- URL: https://https://github.com/UserName/RepoName

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


