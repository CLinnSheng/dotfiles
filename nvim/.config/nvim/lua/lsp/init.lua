require("lsp.lua_ls")
require("lsp.clangd")
require("lsp.gopls")
require("lsp.rust_analyzer")
require("lsp.ruff")
require("lsp.pyright")
require("lsp.bashls")
require("lsp.yamlls")
require("lsp.ts_ls")
require("lsp.html")

-- Get capabilities from blink.cmp
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config('*', {
    capabilities = capabilities
})

-- Apply capabilities to all configured servers
local servers = { "lua_ls", "clangd", "gopls", "rust_analyzer", "ruff", "pyright", "bashls", "yamlls", "ts_ls", "html" }
vim.lsp.enable(servers)
-- for _, server in ipairs(servers) do
--     vim.lsp.config[server] = vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, {
--         capabilities = capabilities,
--     })
-- end


vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local map = function(key, fn, desc, mode)
            vim.keymap.set(mode or "n", key, fn, { buffer = args.buf, desc = desc })
        end
        local fzf = require("fzf-lua")

        map("K", vim.lsp.buf.hover, "LSP Hover")
        map("gd", fzf.lsp_definitions, "Go to definition")
        map("gD", vim.lsp.buf.declaration, "Go to declaration")
        map("gi", fzf.lsp_implementations, "Go to implementation")
        map("gr", fzf.lsp_references, "Go to references")
        map("gt", fzf.lsp_typedefs, "Go to type definition")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })
        map("<leader>fm", vim.lsp.buf.format, "Format buffer")
        map("<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
        map("<leader>D", fzf.diagnostics_document, "Show buffer diagnostics")
    end,
})

-- Diagnostic Icons Customization
local signs = {
    [vim.diagnostic.severity.ERROR] = "",
    [vim.diagnostic.severity.WARN] = "",
    [vim.diagnostic.severity.HINT] = "󰌵",
    [vim.diagnostic.severity.INFO] = "",
}
vim.diagnostic.config({
    signs = {
        text = signs,
    },
    virtual_text = false,
    virtual_lines = false,
    underline = true,
    update_in_insert = false,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true
    }
})

vim.keymap.set("n", "<leader>ld", function()
    require("tiny-inline-diagnostic").toggle()
end, { desc = "Toggle inline diagnostics" })

-- Inline Diagnostics (end-of-line, wraps long messages)
require("tiny-inline-diagnostic").setup({
    preset = "modern",
    options = {
        show_source = true,
        show_code = true,
        multilines = {
            enabled = true,
            always_show = true,
        },
    },
})
