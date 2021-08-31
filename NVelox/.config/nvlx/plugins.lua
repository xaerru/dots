return {
    {
        "p00f/cphelper.nvim",
        rocks = "http",
        after = "nordbuddy",
    },

    {
        "neovimhaskell/haskell-vim",
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
}
