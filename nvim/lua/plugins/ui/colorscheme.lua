return {
    {
        "morhetz/gruvbox",
        priority = 1000,
        config = function()
            vim.o.termguicolors = false
            vim.cmd("colorscheme gruvbox")
        end,
    },
}
