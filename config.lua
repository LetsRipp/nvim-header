local M = {}

local function get_repo()

    -- pulls git repo from git config
    local repo = vim.fn.system("git config remote.origin.url"):gsub("\n", "")
    return (repo ~= "" and repo) or "https://github.com/userName/repoName"

end

local function get_author()

    -- pulls author from git config
    local author = vim.fn.system("git config global user.name"):gsub("\n", "")
    if author == "" then
        author = vim.fn.system("git config --global user.name"):gsub("\n", "")
    end
    return (author ~= "" and author) or "your_name"

end

M.options = {

    file = vim.fn.expand("%:t"),
    author = get_author(),
    license = "MIT",
    description = "This is probaly trash",
    version = "0.0.0",
    date_format = os.date("%Y-%m-%d"),
    url = "https://" .. get_repo(),
    keymap = "<leader>mh"

}

-- setup function to allow user overrides
M.setup = function(opts)

    M.options = vim.tbl_extend("force", M.options, opts or {})

    if M.options.keymap then
        vim.api.nvim_set_keymap(
        "n",
        M.options.keymap,
        "<cmd>lua require('nvim-header').insert_header()<CR>",
        { noremap = true, silent = true }
        )
    end
end

