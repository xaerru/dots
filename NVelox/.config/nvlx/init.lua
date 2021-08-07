local plugins = dofile("/home/grvxs/.config/nvlx/plugins.lua")

nvlx.general.colorscheme = "nordbuddy"
nvlx.general.autosave = true

nvlx.keybinds = {
    object = {
        ["im"] = ":lua require('tsht').nodes()<CR>",
    },
    visual = {
        ["im"] = ":lua require('tsht').nodes()<CR>",
    },
}

nvlx.plugins = plugins
