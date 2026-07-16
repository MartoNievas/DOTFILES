return {
    { import = "lazyvim.plugins.extras.lang.rust" },

    "neovim/nvim-lspconfig",
    opts = {
        servers = {
            hls = {
                -- Esta es la ruta estándar de ghcup para el binario
                cmd = { "/home/martin/.ghcup/bin/haskell-language-server-wrapper", "--lsp" },
            },
        },
    },
}
