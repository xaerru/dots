local plugins = require("plugins")

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

nvlx.keybinds.leader = {
    normal = {
        H = {
            {
                name = "hop",
                c = { "<cmd>HopChar1<cr>", "Char1" },
                l = { "<cmd>HopLine<cr>", "Line" },
                p = { "<cmd>HopPattern<cr>", "Pattern" },
                s = { "<cmd>ISwapWith<cr>", "Swap arguments" },
                v = { "<cmd>HopChar2<cr>", "Char2" },
                w = { "<cmd>HopWord<cr>", "Word" },
            },
            { prefix = "" },
        },
        o = {
            {
                name = "cphelper",
                d = { "<CMD>CphDelete<CR>", "Delete testcases" },
                e = { "<CMD>CphEdit<CR>", "Edit/Add testcases" },
                i = { "<CMD>CphRetest<CR>", "Run tests without recompiling" },
                r = { "<CMD>CphReceive<CR>", "Receive problem" },
                t = { "<CMD>CphTest<CR>", "Run tests" },
            },
        },
    },
    visual = {
        H = {
            {
                name = "hop",
                c = { "<cmd>HopChar1<cr>", "Char1" },
                l = { "<cmd>HopLine<cr>", "Line" },
                p = { "<cmd>HopPattern<cr>", "Pattern" },
                v = { "<cmd>HopChar2<cr>", "Char2" },
                w = { "<cmd>HopWord<cr>", "Word" },
            },
            { prefix = "", mode = "v" },
        },
    },
    {
        [";;"] = { "which_key_ignore", mode = "i" },
        ["<leader><TAB>"] = { "<CMD>:BufferLineCyclePrev<CR>", "Previous Buffer" },
        ["<leader>f"] = { [[<CMD>%s/\s\+$//e | noh | Neoformat | write<CR>]], "Format" },
        ["<leader>j"] = { "<CMD><ESC>:m .+1<CR>==<CR>", "Move Line Down" },
        ["<leader>k"] = { "<CMD><ESC>:m .-2<CR>==<CR>", "Move Line Up" },
        ["<leader>n"] = { "<CMD>NvimTreeToggle<CR>", "Nvim Tree Toggle" },
    },
}

nvlx.keybinds.general = {
    insert = {
        ["jj"] = "<Right>",
        ["<C-j>"] = "<ESC>:m .+1<CR>==i",
        ["<C-k>"] = "<ESC>:m .-2<CR>==i",
    },

    normal = {
        [";"] = ":",
        ["Ld"] = ":set langmap=1&,2[,3{,4},5(,6=,7*,8),9+,0],&%,[7,{5,}3,(1,=9,*0,)2,+4,]6<CR>",
        ["Lq"] = ":set langmap=<CR>",
    },

    object = {
        ["im"] = ":lua require('tsht').nodes()<CR>",
    },

    visual = {
        ["im"] = ":lua require('tsht').nodes()<CR>",
        ["<C-e>"] = "<ESC>",
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
    colorcolumn = "100",
    relativenumber = true,
    showbreak = "↪",
    listchars = table.concat({
        "eol:↲",
        "tab:▶‒",
        "trail:•",
        "extends:❯",
        "precedes:❮",
        "nbsp:_",
    }, ","),
    fillchars = table.concat({
        [[fold: ]],
        [[vert:│]],
        [[eob: ]],
        [[msgsep:‾]],
    }, ","),
}

nvlx.disabled = {
    builtin_plugins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit",
    },
}

vim.cmd([[set langmap=1&,2[,3{,4},5(,6=,7*,8),9+,0],&%,[7,{5,}3,(1,=9,*0,)2,+4,]6<CR>]])
