return {
  "williamboman/mason.nvim",
  lazy = false,

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
    -- "saghen/blink.cmp",
  },

  config = function()
    -- import mason and mason_lspconfig
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
        "jdtls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "pyright",
        "clangd",
        "angularls",
        "bashls",
        "csharp_ls",
        "ast_grep",
        "docker_compose_language_service",
        "elixirls",
        "gopls",
        -- "java_language_server",
        "eslint",
        "jsonls",
        "kotlin_language_server",
        "marksman",
        "rust_analyzer",
        "solidity",
        "sqlls",
        "ts_ls",
			},
			automatic_installation = true,
		})

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua",   -- lua formatter
        "isort",    -- python formatter
        "pylint",
        "clangd",
        "denols",
        "black",
        "clang-format",
        -- { 'eslint_d', version = '13.1.2' },
      },
    })
  end,
}
