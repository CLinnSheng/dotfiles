vim.lsp.config.rust_analyzer = {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = true,
            check = {
                command = "clippy",
            },
        },
    },
}
