--local nvlx = require("_nvlx.empty_config")

nvlx.general = {
    colorscheme = "nordbuddy",
    autosave = true,
    winblend = 25,
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
        --[";;"] = { "which_key_ignore", mode = "i" },
        ["<leader><TAB>"] = { "<CMD>:BufferLineCyclePrev<CR>", "Previous Buffer" },
        ["<leader>f"] = { [[<CMD>%s/\s\+$//e | noh | Neoformat | write<CR>]], "Format" },
        ["<leader>j"] = { "<CMD><ESC>:m .+1<CR>==<CR>", "Move Line Down" },
        ["<leader>k"] = { "<CMD><ESC>:m .-2<CR>==<CR>", "Move Line Up" },
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
    command = {
        ["w!!"] = "execute 'silent! write !sudo tee % >/dev/null' <bar> edit!",
    },
}

nvlx.config.plugins.gitsigns = {
    word_diff = true,
}

nvlx.config.plugins.autopairs = {
    fast_wrap = {
        end_key = "-",
        keys = "aoeuidhtns",
    },
}

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

nvlx.plugins = {
    {
        "p00f/cphelper.nvim",
        rocks = "http",
        after = "nordbuddy",
    },

    {
        "neovimhaskell/haskell-vim",
        event = "BufRead",
        ft = "haskell",
    },

    {
        "iamcco/markdown-preview.nvim",
        config = function()
            vim.g.mkdp_auto_start = 1
        end,
        ft = "markdown",
    },

    {
        "chaoren/vim-wordmotion",
    },

    {
        "andweeb/presence.nvim",
        config = function()
            require("presence"):setup({
                auto_update = true,
                neovim_image_text = "The One True Text Editor",
                main_image = "file",
                log_level = nil,
                debounce_timeout = 10,
                enable_line_number = false,
                blacklist = {},
                editing_text = "Editing %s",
                file_explorer_text = "Browsing %s",
                git_commit_text = "Committing changes",
                plugin_manager_text = "Managing plugins",
                reading_text = "Reading %s",
                workspace_text = "Working on %s",
                line_number_text = "Line %s out of %s", -- Line number format string (for when enable_line_number is set to true)
            })
        end,
        after = "nordbuddy",
    },

    {
        "phaazon/hop.nvim",
        after = "nordbuddy",
    },

    {
        "tweekmonster/startuptime.vim",
        cmd = "StartupTime",
    },

    {
        "mfussenegger/nvim-ts-hint-textobject",
        config = function()
            require("tsht").config.hint_keys = { "a", "o", "e", "i", "d", "h", "t", "n" }
        end,
        after = "nvim-treesitter",
    },

    {
        "mizlan/iswap.nvim",
        config = function()
            require("iswap").setup({
                keys = "aoeuidhtn",
            })
        end,
        after = "nvim-treesitter",
    },

    {
        "JoseConseco/vim-case-change",
        after = "nordbuddy",
    },
}

--return nvlx
