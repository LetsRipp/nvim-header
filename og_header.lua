-- TODO: fix me!!
-- i don't do anything anymore
local H = {}

local function get_extension()

    -- gets the extension of the file
    local filename = vim.fn.expand("%:e")

    -- declares the symbol variable
    local symbol = ""
    local md = false

    -- checks if the file is a lua file...etc
    if filename == "lua" then
        symbol = "--"
    elseif filename == "py" then
        symbol = "#"
    elseif filename == "sh" then
        symbol = "#"
    elseif filename == "md" then
        symbol = "[comment]: <> ("
        md = true
   elseif filename == "txt" then
        symbol = "#"
    elseif filename == "yaml" then
        symbol = "#"
    elseif filename == "yml" then
        symbol = "#"
    elseif filename == "toml" then
        symbol = "#"
    elseif filename == "ini" then
        symbol = "#"
    elseif filename == "conf" then
        symbol = "#"
    else
        symbol = "//"       -- default symbol
    end
    return symbol, md
end

local function get_git_repo()

    -- pulls git repo from git config
    local repo = vim.fn.system("git config remote.origin.url"):gsub("\n", "")

    -- debugging line
    print("Repo: " .. repo)

    if repo == "" then
        repo = "git@github.com:userName/repoName.git"
    end

    return repo

end

local function get_git_author()

    -- pulls author from git config
    local author = vim.fn.system("git config --global user.name"):gsub("\n", "")
    return (author ~= "" and author) or "your_name"
end

-- generates the header
local function generate_header()

    -- gets authro and url
    local repo = get_git_repo()
    local author = get_git_author()

    -- creates the header
    local header = {
        "File: " .. vim.fn.expand("%:t"),
        "Author: " .. author,
        "License: MIT",
        "Description: This is trash code that would make a real programmer cry blood 🤮",
        "Version: 0.0.0",
        "Date: " .. os.date("%Y-%m-%d"),
        "Repo: " .. repo
    }

    -- gets the current buffer
    local bufnr = vim.api.nvim_get_current_buf()

    -- gets the extension of the file
    local symbol, md = get_extension()
    local md_concat = ")"

    -- iterates over the header and adds the symbol to the beginning of each line
    -- if md file then appends ')'
    if md == true then
        for i, line in ipairs(header) do
            header[i] = symbol .. "" ..line ..""..md_concat
        end
    else
        for i, line in ipairs(header) do
            header[i] = symbol .. " " .. line
        end
    end

    -- sets the header to the current buffer
    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
end

H.generate_header = generate_header

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>mh", "<cmd>lua require'hobo.utils.header'.generate_header()<CR>", { noremap = true, silent = true })

return H
