local plugins = dofile(os.getenv("HOME") .. "/.config/nvlx/plugins.lua")

nvlx.general = {
    colorscheme = "nordbuddy",
    autosave = true,
    highlights = {
        TSNodeKey = {
            cterm = "bold",
            ctermfg = 198,
            gui = "bold",
            guifg = "#8fbcbb",
        },
        TSNodeUnmatched = {
            ctermfg = 242,
            guifg = "#4c566a",
        },
    },
}

nvlx.keybinds = {
    insert = {
        ["jj"] = "<Right>",
        ["<C-j>"] = "<ESC>:m .+1<CR>==i",
        ["<C-k>"] = "<ESC>:m .-2<CR>==i",
        [";;"] = "<ESC>A;",
    },

    normal = {
        [";"] = ":",
        ["<leader>j"] = "<ESC>:m .+1<CR>==",
        ["<leader>k"] = "<ESC>:m .-2<CR>==",
    },

    object = {
        ["im"] = ":lua require('tsht').nodes()<CR>",
    },

    visual = {
        ["im"] = ":lua require('tsht').nodes()<CR>",
    },

    visual_block = {
        ["J"] = ":m '>+1<CR>gv=gv",
        ["K"] = ":m '<-2<CR>gv=gv",
    },
}

nvlx.plugins = plugins

nvlx.settings = {
    iskeyword = vim.opt.iskeyword + { "-" } - { "_" },
    list = true,
    showbreak = "↪",
    listchars = table.concat({
        "eol:↲",
        "tab:▶‒",
        "trail:•",
        "extends:❯",
        "precedes:❮",
        "nbsp:_",
    }, ","),
}
