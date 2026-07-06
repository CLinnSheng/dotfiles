vim.lsp.config.ruff = {
    on_attach = function(client)
        -- Let pyright own hover; ruff is linter/formatter only
        client.server_capabilities.hoverProvider = false
    end,
}
