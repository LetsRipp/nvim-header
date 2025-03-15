return {
    "LetsRipp/nvim-header",
    dependencies = {},
    opts = {
        -- **user defined fields**
        -- keymap = "<leader>mh",                       default is <leader>mh
        -- author = "name",                             default will  pull from git config
        -- license = "GPL-3.0"                          default is MIT
        -- description = "description of the file"      default is "This is trash code that would make a real programmer cry blood 🤮"
        -- version = "1.0.0",                           default is 0.0.0
        -- repo = "git@github.com:userName/repoName"    default will pull from git config 
        -- created = os.date("%d-%m-%Y")                default is %Y-%m-%d or (2025-01-15) 
            -- options are
            -- %D (date in dd/mm/yy format)
            -- %H:%M (hour:min)
            -- %Y (year in yyyy format)
            -- %d (day in dd format)
            -- %m (month in mm format) 
            -- %y (year in yy format)
    },
    -- lazy loading
    lazy = true,
    -- command to insert the header
    cmd = 'HeaderInsert',
    -- keymap to insert the header
    keys = {
        { '<leader>mh', '<cmd>HeaderInsert<cr>', desc = "Insert Header" },
    },
    -- config
    config = function(_, opts)
        require('nvim-header').setup(opts)
    end
}

