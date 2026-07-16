-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.lazyvim_check_order = false

vim.diagnostic.config({
    float = {
        source = "always", -- Muestra qué componente lanzó el error
        border = "rounded",
        focusable = true,
        -- Esto fuerza que el texto no se quede en una sola línea eterna
        max_width = 80,
        max_height = 20,
        wrap = true, -- Importante para habilitar el salto de línea
    },
})
