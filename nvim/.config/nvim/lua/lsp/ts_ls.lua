vim.lsp.config.ts_ls = {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    settings = {
        typescript = {
            inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayReturnTypeHints = true,
            },
        },
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayReturnTypeHints = true,
            },
        },
    },
}
