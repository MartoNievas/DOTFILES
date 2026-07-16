return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                command = "clippy",
                                extraArgs = { "--", "-D", "warnings" },
                            },
                        },
                    },
                },
            },
        },
    },
}
