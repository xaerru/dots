return {
    {
        "p00f/cphelper.nvim",
        rocks = "http",
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
            require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
        end,
        after = "nvim-treesitter",
    },

    {
        "mizlan/iswap.nvim",
        config = function()
            require("iswap").setup({
                keys = "hjfdnvsla",
            })
        end,
        after = "nvim-treesitter",
    },
}
